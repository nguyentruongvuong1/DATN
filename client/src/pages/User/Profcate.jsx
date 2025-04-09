import React, { useState, useEffect } from "react";
import styles from "../../styles/User/profcate.module.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSlidersH, faHeart } from "@fortawesome/free-solid-svg-icons";
import { useParams, Link } from "react-router-dom";
import { checkLogin, updateCountPrlike } from "../../AuthSlice";
import { useDispatch, useSelector } from "react-redux";
import "@ant-design/v5-patch-for-react-19";
import { message } from "antd";
import { themPr } from "../../CartSlice";
import ReactPaginate from "react-paginate";
import Search from "../../components/User/search";

const ProductPage = () => {
  let { cate_id } = useParams();
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);
  const [openSubmenu, setOpenSubmenu] = useState(null);
  const [type_cate, Settype_cate] = useState([]);
  const [product, Setproduct] = useState([]);
  const [sortPr, SetsortPr] = useState("create_date");
  const user = useSelector((state) => state.auth.user);
  const [likePr, setLikePr] = useState({});
  const [cate, setcate] = useState([]);
  const [minPrice, setMinPrice] = useState(0);
  const [maxPrice, setMaxPrice] = useState(0);
  const [selectedMin, setSelectedMin] = useState(0);
  const [selectedMax, setSelectedMax] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const dispatch = useDispatch();

  // Kiểm tra user đăng nhập
  useEffect(() => {
    dispatch(checkLogin());
  }, [dispatch]);

  // Cập nhật lại giá trị khi thay đổi thanh trượt
  const handlePriceChange = (minValue, maxValue) => {
    if (minValue < maxValue) {
      setSelectedMin(minValue);
      setSelectedMax(maxValue);
      setCurrentPage(1); // Reset về trang đầu khi thay đổi giá
    }
  };

  // Paginate
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(8);
  const [totalProducts, setTotalProducts] = useState(0);

  // Lấy tất cả type_cate của cate
  useEffect(() => {
    fetch("http://localhost:3000/c/categories_with_type_cate")
      .then((res) => res.json())
      .then((data) => {
        setcate(data);
      })
      .catch((err) => console.error("Lỗi lấy danh mục:", err));
  }, []);

  // Lấy type_cate dựa vào id
  useEffect(() => {
    fetch(`http://localhost:3000/c/type_cate/${cate_id}`)
      .then((res) => res.json())
      .then((data) => Settype_cate(data));
  }, [cate_id]);

  const toggleSidebar = () => {
    setIsSidebarOpen(!isSidebarOpen);
  };

  const toggleSubmenu = (e, submenuId) => {
    e.preventDefault();
    setOpenSubmenu(openSubmenu === submenuId ? null : submenuId);
  };

  // Lấy sản phẩm
  useEffect(() => {
    const fetchData = async () => {
      setIsLoading(true);
      try {
        const url = `http://localhost:3000/pr/products-by-type/${cate_id}?sort=${sortPr}&page=${currentPage}&limit=${itemsPerPage}&minPrice=${selectedMin}&maxPrice=${selectedMax}`;

        const products = await fetch(url);
        const response = await products.json();
        Setproduct(response.products || response);
        setTotalProducts(response.total || response.length);

        if (user && user.id) {
          const resFav = await fetch(
            `http://localhost:3000/pr/user-favorite/${user.id}`
          );
          const likedProductIds = await resFav.json();

          const likedStatus = (response.products || response).reduce(
            (acc, pr) => {
              acc[pr.id] = likedProductIds.includes(pr.id);
              return acc;
            },
            {}
          );
          setLikePr(likedStatus);
        }
      } catch (error) {
        console.error("Lỗi khi tải sản phẩm:", error);
      } finally {
        setIsLoading(false);
      }
    };
    fetchData();
  }, [
    user,
    cate_id,
    sortPr,
    currentPage,
    itemsPerPage,
    selectedMin,
    selectedMax,
  ]);

  useEffect(() => {
    const fetchPriceRange = async () => {
      try {
        const res = await fetch(
          `http://localhost:3000/pr/price-range_typecate/${cate_id}`
        );
        const data = await res.json();
        setMinPrice(data.min_price);
        setMaxPrice(data.max_price);
        setSelectedMin(data.min_price);
        setSelectedMax(data.max_price);
      } catch (error) {
        console.error("Lỗi khi lấy khoảng giá:", error);
      }
    };

    fetchPriceRange();
  }, [cate_id]);

  const handlePageChange = (page) => {
    setCurrentPage(Math.max(1, page));
  };

  const toggleFavorite = async (pr_id) => {
    if (!user || !user.id) {
      message.error("Bạn cần đăng nhập để thích sản phẩm!");
      return;
    }

    try {
      const response = await fetch("http://localhost:3000/pr/toggle-favorite", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ user_id: user.id, pr_id }),
      });

      const data = await response.json();
      if (data.success) {
        setLikePr((prev) => ({
          ...prev,
          [pr_id]: data.liked,
        }));

        dispatch(updateCountPrlike(data.liked ? 1 : -1));
        message.success(
          data.liked ? "Bạn đã thích sản phẩm!" : "Bạn đã hủy thích sản phẩm!"
        );
      }
    } catch (error) {
      console.error("Lỗi khi toggle yêu thích:", error);
    }
  };

  return (
    <div>
      {type_cate && (
        <nav className={styles.bgnav}>
          <div className={styles.containernav}>
            <img
              src={type_cate.image}
              alt=""
              className={styles.navBackground}
            />
            <div className={styles.nav_content}>
              <h1>{type_cate.name}</h1>
              <p>{type_cate.content}</p>
            </div>
          </div>
        </nav>
      )}

      <main className={`${styles.container_full} ${styles.bgmain}`}>
        <section className={styles.container}>
          <div className={styles.Prdanhmuc_select}>
            <div>
              <div
                className={styles["category-toggle"]}
                onClick={toggleSidebar}
              >
                <FontAwesomeIcon icon={faSlidersH} /> <span>CHỌN DANH MỤC</span>
              </div>
            </div>

            <div className={styles.content}>
              <aside
                id="sidebar"
                className={`${styles.sidebar} ${
                  isSidebarOpen ? styles.show : ""
                }`}
              >
                <Search />
                <div className={styles.title_loctheogia}>
                  <h3>LỌC THEO GIÁ</h3>
                </div>
                <div className={styles.rangeWrapper}>
                  <input
                    type="range"
                    min={minPrice}
                    max={maxPrice}
                    step="20000"
                    value={selectedMin}
                    onChange={(e) =>
                      handlePriceChange(Number(e.target.value), selectedMax)
                    }
                    className={`${styles.range} ${styles.rangeMin}`}
                  />
                  <input
                    type="range"
                    min={minPrice}
                    max={maxPrice}
                    step="20000"
                    value={selectedMax}
                    onChange={(e) =>
                      handlePriceChange(selectedMin, Number(e.target.value))
                    }
                    className={`${styles.range} ${styles.rangeMax}`}
                  />

                  
                </div>

                <p className={styles.rangeWrapper_gia}>
                    Giá: {Number(selectedMin).toLocaleString("vi")} -{" "}
                    {Number(selectedMax).toLocaleString("vi")}
                  </p>

                <h3 className={styles["filter-danhmuc"]}>DANH MỤC</h3>
                {cate.map((c) => (
                  <ul className={styles["category-list"]} key={c.id}>
                    <li
                      className={`${styles["has-submenu"]} ${
                        openSubmenu === c.id ? styles.open : ""
                      }`}
                    >
                      {c.id !== type_cate?.cate_id ? (
                        <Link
                          to={`/pr_by_cate/${c.id}`}
                          className={styles.categoryLink}
                        >
                          {c.name}
                        </Link>
                      ) : (
                        <div
                          role="button"
                          onClick={(e) => toggleSubmenu(e, c.id)}
                          className={`${styles.categoryButton} ${
                            openSubmenu === c.id ? styles.rotated : ""
                          }`}
                        >
                          {c.name}
                        </div>
                      )}

                      {c.id === type_cate?.cate_id && openSubmenu === c.id && (
                        <ul className={`${styles.submenu} ${styles.open}`}>
                          {c.type_cate?.length > 0 ? (
                            c.type_cate.map((tc) => (
                              <li key={tc.id}>
                                <Link
                                  to={`/pr_by_typecate/${tc.id}`}
                                  className={styles.subcategoryLink}
                                >
                                  {tc.name}
                                </Link>
                              </li>
                            ))
                          ) : (
                            <li>Không có loại danh mục</li>
                          )}
                        </ul>
                      )}
                    </li>
                  </ul>
                ))}
              </aside>
            </div>

            <div>
              <select name="" id="" onChange={(e) => SetsortPr(e.target.value)}>
                <option value="create_date">
                  Sắp xếp theo sản phẩm mới nhất
                </option>
                <option value="price_asc">Sắp xếp theo giá tăng dần</option>
                <option value="price_desc">Sắp xếp theo giá giảm dần</option>
                <option value="view">Sắp xếp theo mức độ phổ biến</option>
              </select>
            </div>
          </div>

          {isLoading ? (
            <div>Đang tải sản phẩm...</div>
          ) : (
            <>
              <div className={styles.products}>
                {product.map((pr) => (
                  <div className={styles.product} key={pr.id}>
                    <div className={styles.product_img}>
                      <img
                        src={
                          pr.images
                            ? pr.images.split(",")[0]
                            : "/default-image.jpg"
                        }
                        alt={pr.name}
                      />
                    </div>
                    <div
                      className={`${styles.pr_tim} ${
                        likePr[pr.id] ? styles.liked : ""
                      }`}
                      onClick={() => toggleFavorite(pr.id)}
                    >
                      <i>
                  <FontAwesomeIcon
                    icon={faHeart}
                    style={{
                      color: likePr[pr.id] ? "red" : "white",
                      stroke: likePr[pr.id] ? "none" : "#224229",
                      strokeWidth: likePr[pr.id] ? "0" : "15px",
                      padding: "2px",
                    }}
                  />
                </i>
                    </div>
                    <div className={styles.product_btn}>
                      <div className={styles.pr_xemchitiet}>
                        <button>
                          <Link to={`/chi_tiet_san_pham/${pr.id}`}>
                            Xem chi tiết
                          </Link>
                        </button>
                      </div>
                      <div className={styles.pr_themvaogio}>
                        <button
                          onClick={() => {
                            dispatch(themPr(pr));
                            message.success(
                              "Bạn đã thêm sản phẩm vào giỏ hàng"
                            );
                          }}
                        >
                          Thêm vào giỏ
                        </button>
                      </div>
                    </div>
                    <div className={styles.product_info}>
                      <p className={styles.product_price}>{pr.name}</p>
                      <p>{Number(pr.price).toLocaleString("vi")} VNĐ</p>
                    </div>
                  </div>
                ))}
              </div>
              {totalProducts > itemsPerPage && (
                <div className={styles.paginationContainer}>
                  <ReactPaginate
                    breakLabel="⋯"
                    nextLabel=">"
                    previousLabel="<"
                    onPageChange={(selectedItem) =>
                      handlePageChange(selectedItem.selected + 1)
                    }
                    pageRangeDisplayed={2}
                    marginPagesDisplayed={1}
                    pageCount={Math.ceil(totalProducts / itemsPerPage)}
                    renderOnZeroPageCount={null}
                    containerClassName={styles.pagination}
                    pageClassName={styles.pageItem}
                    pageLinkClassName={styles.pageLink}
                    previousClassName={styles.pageItem}
                    previousLinkClassName={`${styles.pageLink} ${styles.previousLink}`}
                    nextClassName={styles.pageItem}
                    nextLinkClassName={`${styles.pageLink} ${styles.nextLink}`}
                    activeClassName={styles.active}
                    breakClassName={styles.break}
                    forcePage={Math.min(
                      Math.max(0, currentPage - 1),
                      Math.ceil(totalProducts / itemsPerPage) - 1
                    )}
                  />
                </div>
              )}
            </>
          )}
        </section>
      </main>

      <div
        id="overlay"
        className={`${styles.overlay} ${isSidebarOpen ? styles.active : ""}`}
        onClick={toggleSidebar}
      ></div>
    </div>
  );
};

export default ProductPage;
