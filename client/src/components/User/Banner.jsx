import styles from "../../styles/User/banner.module.css";
import { useState, useEffect } from "react";
import {Link} from "react-router-dom"
export default function Banner() {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [images, setimages] = useState([]);

  useEffect(() => {
    const fetchImages = async () => {
      try {
        const response = await fetch(`${import.meta.env.VITE_API_URL}/banner/`);
        const data = await response.json();
        setimages(data.map((item) => item.image )); // Lấy URL ảnh từ API
      } catch (error) {
        console.error("Lỗi khi tải ảnh:", error);
      }
    };

    fetchImages();
  }, []);

  useEffect(() => {
    if (images.length === 0) return;

    const interval = setInterval(() => {
      setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
    }, 5000);

    return () => clearInterval(interval);
  }, [images.length]);

  return (
    <section className={styles.bgimg}>
        <div className={styles.slide} >
          {images.length > 0 ? (
            <img
              src={images[currentIndex]}
              alt={`Slide ${currentIndex + 1}`}
        
            />
          ) : (
            <p>Đang tải ảnh...</p>
          )}
        </div>
      <div className={styles.banner}>
        <div className={styles.banner_content}>
          <h1>Tận hưởng không gian sống xanh</h1>
          <p>
            Bổ sung thêm cây xanh là một cách đơn giản nhất để tạo ra sự thoải
            mái cho không gian sống của bạn, giúp mang lại hiệu quả công việc và
            thư giãn mỗi khi trở về.
          </p>
          <div className={styles.banner_btn}>
            <div className={styles.btn_lienhe}>
              <Link to={'/lienhe'}>Liên hệ</Link>
            </div>
            <div className={styles.btn_khampha}>
              <Link href="">Khám phá ngay</Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
