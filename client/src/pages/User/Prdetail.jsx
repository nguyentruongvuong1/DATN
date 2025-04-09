import styles from"../../styles/User/prdetail.module.css";
import React from "react";
import { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import { themPr } from "../../CartSlice";
import { useDispatch, useSelector } from "react-redux";
import "@ant-design/v5-patch-for-react-19";
import { message } from "antd";
import Comment from "../../components/User/Comment";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faHeart } from "@fortawesome/free-solid-svg-icons";
import { checkLogin, updateCountPrlike } from "../../AuthSlice";
import axios from "axios";
import moment from "moment";
export default function Prdetail() {
  const { id } = useParams();
  const [pr, setPr] = useState(null);
  const [mainImage, setMainImage] = useState("");
  const [thumbnails, setThumbnails] = useState([]);
  const [type_cate, sertype_cate] = useState([]);
  const dispatch = useDispatch();
  const [quantity, setQuantity] = useState(1);
  const [prlq, setprlq] = useState([]);
  const user = useSelector((state) => state.auth.user);
  const [likePr, setLikePr] = useState({});
  const [cate, setcate] = useState([]);
  const [Reviews, setReviews] = useState([]);
  const [totalStar, settotalStar] = useState(null);

  useEffect(() => {
    dispatch(checkLogin());
  }, [dispatch]);

  useEffect(() => {
    const fetchCate = async () => {
      const res = await fetch(`${import.meta.env.VITE_API_URL}/c/namecate/${id}`);
      const data = await res.json();
      setcate(data);
    };
    fetchCate();
  }, [id]);

  // Lấy chi tiết sản phẩm
  useEffect(() => {
    const fetchPr = async () => {
      try {
        const res = await fetch(`${import.meta.env.VITE_API_URL}/pr/detailPr/${id}`);
        const data = await res.json();

        if (data) {
          setPr(data);
          sertype_cate(data.type_cate);
          if (data.images) {
            const imageList = data.images.split(","); // Tách chuỗi thành mảng
            setMainImage(imageList[0]); // Ảnh chính là ảnh đầu tiên
            setThumbnails(imageList); // Danh sách ảnh nhỏ
          }
        }
      } catch (error) {
        console.error("Lỗi khi lấy thông tin sản phẩm:", error);
      }
    };

    fetchPr();
  }, [id]);

  // Lấy sản phẩm liên quan
  useEffect(() => {
    const fetchprlq = async () => {
      try {
        const res = await fetch(`${import.meta.env.VITE_API_URL}/pr/prlq/${id}`);
        const data = await res.json();
        setprlq(data);

        if (user && user.id) {
          const resFav = await fetch(
            `${import.meta.env.VITE_API_URL}/pr/user-favorite/${user.id}`
          );
          const likedProductIds = await resFav.json();

          // Tạo object likePr từ dữ liệu API
          const likedStatus = data.reduce((acc, pr) => {
            acc[pr.id] = likedProductIds.includes(pr.id);
            return acc;
          }, {});
          setLikePr(likedStatus);
        }
      } catch (error) {
        console.error("Lỗi khi lấy bình luận:", error);
      }
    };
    fetchprlq();
  }, [id, user]);

  // Lấy reviews của sản phẩm
  useEffect(() => {
    const fetchReviews = async () => {
      try {
        const res = await axios.get(
          `${import.meta.env.VITE_API_URL}/reviews/product-reviews?productId=${id}`
        );
        setReviews(res.data.data);
      } catch (error) {
        console.error("Lỗi khi tải đánh giá:", error);
      }
    };
    fetchReviews();
  }, [id]);

  // Lấy tổng só sao được đánh giá của sản phẩm
  useEffect(() => {
    const fetchtotalStar = async () => {
      try {
        const res = await fetch(
          `${import.meta.env.VITE_API_URL}/reviews/average-rating/${id}`
        );
        const data = await res.json();
        // Giả sử data có cấu trúc { average_rating: 4.5 }
        settotalStar(data.average_rating); // Set chỉ giá trị average_rating
      } catch (error) {
        console.error("Lỗi khi tải tổng số sao được đánh giá:", error);
      }
    };

    fetchtotalStar();
  }, [id]);

  const Star = ({ filled }) => (
    <span style={{ color: filled ? "#ffc107" : "#e4e5e9" }}>★</span>
  );

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

  const Maxquantity = pr ? pr.inventory_quantity : 0;

  const handleChange = (e) => {
    let value = e.target.value;

    // Chỉ cho phép nhập số
    if (/^\d*$/.test(value)) {
      const num = parseInt(value, 10);
      if (num > Maxquantity) {
        message.warning(`Chỉ có thể mua số lượng tối đa là ${Maxquantity}`);
        setQuantity(Maxquantity);
      } else {
        setQuantity(num > 0 ? num : ""); // Không cho số âm, giữ input rỗng khi nhập 0
      }
    }
  };

  // Tăng số lượng
  const increaseQuantity = () => {
    if (quantity < Maxquantity) {
      setQuantity((prev) => prev + 1);
    } else {
      message.warning(`Chỉ có thể mua tối đa ${Maxquantity} sản phẩm.`);
    }
  };

  // Giảm số lượng
  const decreaseQuantity = () => {
    setQuantity((prev) => (prev > 1 ? prev - 1 : prev));
  };

  // Xử lý khi thêm vào giỏ hàng
  const handleAddToCart = () => {
    if (quantity < 1) {
      message.warning("Số lượng phải lớn hơn 0!");
      return;
    }
    if (quantity > pr.inventory_quantity) {
      message.warning(`Chỉ còn ${pr.inventory_quantity} sản phẩm trong kho`);
      return;
    }

    const price = pr.price_sale > 0 ? pr.price_sale : pr.price;

    dispatch(themPr({ ...pr, so_luong: quantity, price }));
    message.success("Bạn đã thêm sản phẩm vào giỏ hàng");
  };

   // Tang view
   const View = async (id) => await axios.post(`${import.meta.env.VITE_API_URL}/pr/view/${id}`); 


  // Nếu chưa có dữ liệu, hiển thị thông báo
  if (!pr) return <p>Đang tải...</p>;

  return (
    <div className={styles.background}>
      <div className={styles.container}>
        <div className={styles.oo}>
          <div className={styles.odau}>
            <img
              id="mainImg"
              src={mainImage}
              alt="Main"
              width="575px"
              height="500px"
            />
            <div className={styles.abc}>
              {thumbnails.map((src, index) => (
                <img
                  key={index}
                  src={src}
                  alt="Thumbnail"
                  width="130px"
                  height="130px"
                  onClick={() => setMainImage(src)}
                  style={{ cursor: "pointer" }}
                />
              ))}
            </div>
          </div>
          <div className={styles.ocuoi}>
            <div className={styles.cay}>
              <b>{pr.name}</b>
            </div>
            <div >
                    {totalStar !== null &&
                    totalStar !== undefined &&
                    !isNaN(totalStar) ? (
                      <>
                    <p> <strong> Đánh giá: </strong> {" "}
                        {[...Array(5)].map((_, index) => (
                          <Star
                            key={index}
                            filled={index < Math.floor(totalStar)}
                          />
                        ))}
                        <span> ({totalStar} / 5.0 sao)</span>{" "}
                        </p>
                      </>
                    ) : null}{" "}
                    {/* Nếu totalStar không hợp lệ, không render gì */}
                  </div>
            <div className={styles.masp}>
              {" "}
              <strong>Mã sản phẩm:</strong> {pr.id}{" "}
            </div>
            <div className={styles.masp}>
              {" "}
              <strong>Lượt xem:</strong> {pr.view}{" "}
            </div>
            {pr.price_sale > 0 ? (
              <div>
                <div className={styles.gia}>
                  <p>
                    {" "}
                    <strong>Giá: </strong>{" "}
                    <del style={{ color: "rgba(0, 0, 0, 0.603)" }}>
                      {" "}
                      {pr.price} VNĐ
                    </del>
                  </p>
                </div>
                <div className={styles.gia}>
                  <p>
                    {" "}
                    <strong>Giá đã giảm: </strong> {pr.price_sale} VNĐ
                  </p>
                </div>
              </div>
            ) : (
              <div className={styles.gia}>
                <p>
                  {" "}
                  <strong>Giá: </strong> {pr.price} VNĐ
                </p>
              </div>
            )}

            <div className={styles.mota}>
              <p>
                {" "}
                <strong> Mô tả sản phẩm: </strong>
              </p>
            </div>
            <div className={styles.dongmota}>
              <p>{pr.discription} </p>
            </div>

            <div className={styles.trangthai}>
              <p>
                {" "}
                <strong> Số lượng còn lại: </strong> {pr.inventory_quantity}{" "}
              </p>
            </div>

            <div className={styles["button-container"]}>
              <div className={styles.counter}>
                <button onClick={decreaseQuantity} className={styles.counter}>
                  -
                </button>
                <input
                  type="text"
                  value={quantity}
                  onChange={handleChange}
                  onBlur={() => setQuantity(quantity || 1)} // Nếu rỗng, đặt lại thành 1
                />
                <button onClick={increaseQuantity}>+</button>
              </div>
              <button className={styles["btn-cart"]} onClick={handleAddToCart}>
                Thêm vào giỏ
              </button>
            </div>

            <div className={styles["product-info"]}>
              <p className={styles.categories}>
                <strong>Danh mục:</strong>{" "}
                <Link to={`/pr_by_cate/${cate.cate_id}`}>
                  {cate.cate_name},{" "}
                </Link>
                {type_cate.length > 0
                  ? type_cate.map((tc, index) => (
                      <span key={index}>
                        <Link to={`/pr_by_typecate/${tc.id}`}>
                          {tc.name}
                          {index < type_cate.length - 1 && ", "}
                        </Link>
                      </span>
                    ))
                  : "Không có danh mục"}
              </p>

              <div className={styles["return-policy"]}>
                <img src="/images/baove.png" alt="Return Policy" />
                <div className={styles["return-policy-text"]}>
                  <strong>Miễn phí đổi trả</strong>
                  <p>Đổi trả trong vòng 7 ngày nếu không hài lòng</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className={styles.bgwhite}>
        <div className={styles.container_comment}>
          <div className={styles["product-title"]}>
            Đánh giá về <span>{pr.name}</span>
          </div>
          <div className={styles.ochung}>
            <div className={styles.o1}>
              <div className={styles["review-container"]}>
                <div className={styles.danhgia}>
                  
                  <h3>Đánh giá từ người dùng khác</h3>
                  <div style={{marginBottom:'20px'}}>
                    {totalStar !== null &&
                    totalStar !== undefined &&
                    !isNaN(totalStar) ? (
                      <>
                        {[...Array(5)].map((_, index) => (
                          <Star
                            key={index}
                            filled={index < Math.floor(totalStar)}
                          />
                        ))}
                        <span> ({totalStar} / 5.0 sao)</span>{" "}
                      </>
                    ) : null}{" "}
                    {/* Nếu totalStar không hợp lệ, không render gì */}
                  </div>
                </div>
                {Reviews.length > 0 ? (
                  Reviews.map((rv, index) => (
                    <div className={styles["user-review"]} key={index}>
                      <div className={styles.user}>
                        <img src={rv.userAvatar} alt="" />
                        <strong>{rv.userName}</strong>{" "}
                        <span className={styles.stars}></span>
                      </div>
                      <div className={styles.date}>
                        {moment(rv.comment_date).format("H:mm YYYY-MM-DD")}
                      </div>
                      <div className="rating">
                        {[...Array(5)].map((_, i) => (
                          <Star key={i} filled={i < rv.rating} />
                        ))}
                      </div>
                      <div className={styles.comment}>
                        <p>{rv.content}</p>
                      </div>
                    </div>
                  ))
                ) : (
                  <div>
                    <p>
                      Chưa có đánh giá nào về sản phẩm này bạn hãy là người đâu
                      tiên đánh giá
                    </p>
                  </div>
                )}
              </div>
            </div>
            <div className={styles.o2}>
              <Comment />
            </div>
          </div>
        </div>
      </div>

      <div className={styles.bgmain}>
        <section className={styles.container}>
          <div className={styles.title}>
            <div className={styles.title_name}>
              <p>SẢN PHẨM LIÊN QUAN</p>
            </div>
          </div>

          <div className={styles.products}>
            {prlq.map((pr) => (
              <div className={styles.product} key={pr.id}>
                <div className={styles.product_img}>
                  <img
                    src={
                      pr.images ? pr.images.split(",")[0] : "/default-image.jpg"
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
                    <button onClick={() => View(pr.id)}>
                      {" "}
                      <Link
                        to={`/chi_tiet_san_pham/${pr.id}`}
                        className={styles.btnxct}
                      >
                        {" "}
                        Xem chi tiết{" "}
                      </Link>{" "}
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
          </div>
        </section>
      </div>
    </div>
  );
}
