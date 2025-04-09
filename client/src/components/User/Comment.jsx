import React, { useState, useEffect, useRef } from "react";
import { useSelector } from "react-redux";
import { useParams } from "react-router-dom";
import { Rate, message } from "antd";
import styles from"../../styles/User/prdetail.module.css";

export default function ProductReview() {
  const { id: productId } = useParams();
  const user = useSelector((state) => state.auth.user);
  const isLoggedIn = useSelector((state) => state.auth.DaDangNhap);
  const [rating, setRating] = useState(5);
  const [hasPurchased, setHasPurchased] = useState(false);
  const [loading, setLoading] = useState(true);
  const contentRef = useRef(null);
  const [hasReviewed, setHasReviewed] = useState(false);

  // Kiểm tra quyền đánh giá khi component mount
  useEffect(() => {
    if (!isLoggedIn || !user?.id) {
      setLoading(false);
      return;
    }

    const checkReviewPermission = async () => {
      try {
        // Kiểm tra đồng thời cả quyền mua hàng và đã đánh giá chưa
        const [purchaseRes, reviewRes] = await Promise.all([
          fetch(`${import.meta.env.VITE_API_URL}/reviews/check-purchase?userId=${user.id}&productId=${productId}`),
          fetch(`${import.meta.env.VITE_API_URL}/reviews/check-reviewed?userId=${user.id}&productId=${productId}`)
        ]);

        const purchaseData = await purchaseRes.json();
        const reviewData = await reviewRes.json();

        setHasPurchased(purchaseData.hasPurchased);
        setHasReviewed(reviewData.reviewed); 
      } catch (error) {
        console.error("Lỗi khi kiểm tra quyền:", error);
        message.error("Có lỗi xảy ra khi kiểm tra quyền đánh giá");
      } finally {
        setLoading(false);
      }
    };

    checkReviewPermission();
  }, [isLoggedIn, user, productId]);

  const handleSubmitReview = async () => {
    if (!contentRef.current?.value.trim()) {
      message.error("Vui lòng nhập đánh giá");
      return;
    }

    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/reviews/submit-review`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          userId: user.id,
          productId,
          content: contentRef.current.value,
          stars: rating,
        }),
      });

      const data = await response.json();

      if (!response.ok) throw new Error(data.error || "Gửi đánh giá thất bại");

      if (data.success) {
        message.success("Đánh giá thành công!");
        contentRef.current.value = "";
        setRating(5);
        setHasReviewed(true); // Cập nhật trạng thái đã đánh giá
      }
    } catch (error) {
      message.error(error.message);
      console.error("Lỗi khi gửi đánh giá:", error);
    }
  };

  if (!isLoggedIn) {
    return (
      <div className={styles.reviewNotice}>
        Vui lòng <a href="/dangnhap">đăng nhập</a> để đánh giá sản phẩm.
      </div>
    );
  }

  if (loading) return <div className={styles.loading}>Đang kiểm tra quyền...</div>;

  return (
    <div className={styles.reviewContainer}>
      <h3>Đánh giá sản phẩm</h3>

      {hasReviewed ? (
        <div className={styles.reviewedNotice}>
          Bạn đã đánh giá sản phẩm này rồi. Cảm ơn bạn đã đóng góp ý kiến!
        </div>
      ) : hasPurchased ? (
        <>
          <div className={styles.ratingSection}>
            <span><strong>Đánh giá sao: </strong></span>
            <Rate 
              value={rating} 
              onChange={setRating} 
              className={styles.ratingStars} 
            />
          </div>
          
          <textarea
            className={styles.reviewTextarea}
            placeholder="Nhập đánh giá của bạn..."
            ref={contentRef}
            rows={4}
          />
          
          <button 
            className={styles.submitButton}
            onClick={handleSubmitReview}
          >
            Gửi đánh giá
          </button>
        </>
      ) : (
        <div className={styles.reviewNotice}>
          <div className={styles.ratingSection}>
            <span><strong>Đánh giá sao: </strong></span>
            <Rate 
              value={rating} 
              onChange={setRating} 
              className={styles.ratingStars} 
              disabled
            />
          </div>
          
          <textarea
            className={styles.reviewTextarea}
            placeholder="Nhập đánh giá của bạn..."
            ref={contentRef}
            rows={4}
            disabled
          />
          <div className={styles.purchaseNotice}>
            Bạn cần mua sản phẩm này trước khi đánh giá!
          </div>
        </div>
      )}
    </div>
  );
}