import { useState } from 'react';
import styles from '../../styles/User/lienhe.module.css';

export default function Lienhe() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    message: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState(null);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    setSubmitStatus(null);

    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/contact`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });
      
      const result = await response.json();
      
      if (result.success) {
        setSubmitStatus({ 
          success: true, 
          message: 'Gửi tin nhắn thành công! Chúng tôi sẽ liên hệ lại sớm.' 
        });
        // Reset form
        setFormData({
          name: '',
          email: '',
          phone: '',
          message: ''
        });
      } else {
        setSubmitStatus({ 
          success: false, 
          message: result.message || 'Có lỗi xảy ra. Vui lòng thử lại sau.' 
        });
      }
    } catch (error) {
      setSubmitStatus({ 
        success: false, 
        message: 'Lỗi kết nối. Vui lòng kiểm tra mạng và thử lại.' ,
        error
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className={styles.container}>
      <header className={styles.bgheader}>
        <h1>Liên hệ với Green Trees Shop</h1>
      </header>
      
      <main>
        <section className={styles["contact-container"]}>
          <div className={styles["contact-info"]}>
            <h2>Thông tin liên hệ</h2>
            <ul>
              <li><strong>Địa chỉ vườn:</strong> Công viên phần mềm Quang Trung, HCM</li>
              <li><strong>Hotline:</strong> 0838 369 639 – 09 6688 9393</li>
              <li><strong>Email:</strong> hotro@grts.com</li>
              <li><strong>Mở cửa:</strong> 8:30 – 21:00</li>
            </ul>
            <button className={styles["contact-button"]}>
              <a href="tel:0838369639">0838 369 639</a>
            </button>
          </div>
          
          <div className={styles["qr-code"]}>
            <h2>Quét QR Zalo</h2>
            <img src="/images/qr.png" alt="QR Code Zalo" loading="lazy" />
            <p>Mạng xã hội Green Trees Shop</p>
          </div>
        </section>
        
        <section>
          <div className={styles.khung}>
            <div className={styles["form-container"]}>
              <h2>📩 Gửi Tin Nhắn Cho Chúng Tôi</h2>
              
              {submitStatus && (
                <div className={`${styles.alert} ${submitStatus.success ? styles.success : styles.error}`}>
                  {submitStatus.message}
                </div>
              )}
              
              <form onSubmit={handleSubmit}>
                <div className={styles["form-group"]}>
                  <label htmlFor="name">Họ và Tên</label>
                  <input 
                    type="text" 
                    id="name"
                    name="name"
                    value={formData.name}
                    onChange={handleChange}
                    placeholder="Nhập họ tên của bạn"
                    required
                  />
                </div>
              
                <div className={styles["form-group"]}>
                  <label htmlFor="email">Email</label>
                  <input 
                    type="email" 
                    id="email"
                    name="email"
                    value={formData.email}
                    onChange={handleChange}
                    placeholder="Nhập email của bạn"
                    required
                  />
                </div>
              
                <div className={styles["form-group"]}>
                  <label htmlFor="phone">Số Điện Thoại</label>
                  <input 
                    type="tel" 
                    id="phone"
                    name="phone"
                    value={formData.phone}
                    onChange={handleChange}
                    placeholder="Nhập số điện thoại của bạn"
                  />
                </div>
              
                <div className={styles["form-group"]}>
                  <label htmlFor="message">Nội Dung</label>
                  <textarea 
                    id="message"
                    name="message"
                    value={formData.message}
                    onChange={handleChange}
                    placeholder="Nhập nội dung tin nhắn"
                    required
                    rows="5"
                  ></textarea>
                </div>
              
                <button 
                  type="submit" 
                  className={styles["btn-submit"]}
                  disabled={isSubmitting}
                >
                  <img 
                    src="https://cdn-icons-png.flaticon.com/512/1041/1041916.png" 
                    alt="Send" 
                    width="20"
                    height="20"
                    loading="lazy"
                  />
                  {isSubmitting ? 'Đang gửi...' : 'Gửi Tin Nhắn'}
                </button>
              </form>
            </div>
          </div>
        </section>
      </main>
      
      <div className={styles.khung}>
        <iframe 
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.759522747722!2d106.68235961411692!3d10.83065306113817!2m3!1f0!1f0!1f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317529cddfd676ad!2sSaigon!5e0!3m2!1svi!2s!4v1699984598895" 
          allowFullScreen
          loading="lazy"
          height="300"
          style={{ border: 0, width: '100%' }}
          aria-hidden="false"
          tabIndex="0"
          title="Bản đồ Green Trees Shop"
        ></iframe>
      </div>
    </div>
  );
}