import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import styles from "../../styles/User/prCate.module.css";
import { faHeart, faEye, faArrowRight } from "@fortawesome/free-solid-svg-icons";
import { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { themPr } from "../../CartSlice";
import { checkLogin, updateCountPrlike } from "../../AuthSlice";
import "@ant-design/v5-patch-for-react-19";
import { message } from "antd";
import { Link } from "react-router-dom";
import axios from 'axios';

export default function PrCate() {
  const dispatch = useDispatch();
  const user = useSelector((state) => state.auth.user);
  const [categories, setCategories] = useState([]);
  const [likePr, setLikePr] = useState({});

  // Kiểm tra user đăng nhập
  useEffect(() => {
    dispatch(checkLogin());
  }, [dispatch]);

  // Lấy danh sách danh mục và sản phẩm
  useEffect(() => {
    const fetchData = async () => {
      try {
        // Lấy tất cả danh mục và sản phẩm
        const res = await fetch(`${import.meta.env.VITE_API_URL}/pr/categories-with-products`);
        const data = await res.json();
        setCategories(data);

        // Nếu có user, lấy danh sách sản phẩm yêu thích
        if (user && user.id) {
          const resFav = await fetch(
            `${import.meta.env.VITE_API_URL}/pr/user-favorite/${user.id}`
          );
          const likedProductIds = await resFav.json();

          // Tạo object likePr từ dữ liệu API
          const likedStatus = {};
          data.forEach(category => {
            category.products.forEach(pr => {
              likedStatus[pr.id] = likedProductIds.includes(pr.id);
            });
          });
          setLikePr(likedStatus);
        }
      } catch (error) {
        console.error("Lỗi khi tải dữ liệu:", error);
      }
    };
    fetchData();
  }, [user]);

  // Xử lý toggle thích sản phẩm (giữ nguyên)
  const toggleFavorite = async (pr_id) => {
    if (!user || !user.id) {
      message.error("Bạn cần đăng nhập để thích sản phẩm!");
      return;
    }

    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/pr/toggle-favorite`, {
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
          data.liked ? `Bạn đã thích sản phẩm!` : "Bạn đã hủy thích sản phẩm!"
        );
      }
    } catch (error) {
      console.error("Lỗi khi toggle yêu thích:", error);
    }
  };

  // Tăng lượt xem của sản phẩm (giữ nguyên)
  const View = async (id) => await axios.post(`${import.meta.env.VITE_API_URL}/pr/view/${id}`);

  return (
    <main className={styles.bgmain}>
      <div className={styles.container_title}>
        <div className={styles.title}>
          <div className={styles.title_name}>
            <p>DANH MỤC NỔI BẬT</p>
          </div>
        </div>
      </div>

      <section className={styles.container}>
        {categories.map((category) => (
          <div className={styles.products} key={category.id}>
            <h2 className={styles.productsTitle}>{category.name.toUpperCase()}</h2>
            
            {category.products.map((pr) => (
              <div className={styles.product} key={pr.id}>
                <div className={styles.product_img}>
                  <img
                    src={
                      pr.images ? pr.images.split(",")[0] : "/default-image.jpg"
                    }
                    alt={pr.name}
                  />
                </div>
                <div className={styles.pr_thongbao}>
                  <p>Hot</p>
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
                <div className={styles.pr_view}>
                  <i>
                    <FontAwesomeIcon icon={faEye} />
                  </i>
                  <p>{pr.view}</p>
                </div>
                <div className={styles.product_btn}>
                  <div className={styles.pr_xemchitiet}>
                    <button onClick={() => View(pr.id)}>
                      <Link
                        to={`/chi_tiet_san_pham/${pr.id}`}
                        className={styles.btnxct}
                      >
                        Xem chi tiết
                      </Link>
                    </button>
                  </div>
                  <div className={styles.pr_themvaogio}>
                    <button
                      onClick={() => {
                        dispatch(themPr(pr));
                        message.success("Bạn đã thêm sản phẩm vào giỏ hàng");
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
            <div className={styles.btn_xemthem}>
          <div className={styles.btn_xemthem1}>
          <Link to={`/pr_by_cate/${category.id}`} className={styles.btn_xemthem_link}> 
            Xem thêm 
          </Link> 
          <FontAwesomeIcon icon={faArrowRight} />
            </div>
            </div>
          </div>
        ))}

      </section>
    </main>
  );
}