import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import styles from"../../styles/User/verify.module.css";

export default function VerifyOTP() {
  const [otp, setOtp] = useState("");
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const [timer, setTimer] = useState(60); // 60 giây (1 phút)
  const [isResendDisabled, setIsResendDisabled] = useState(true);
  const navigate = useNavigate();

  // Lấy thông tin từ sessionStorage
  const email = sessionStorage.getItem("email");
  const username = sessionStorage.getItem("username");
  const phone = sessionStorage.getItem("phone");
  const password = sessionStorage.getItem("password");

  useEffect(() => {
    if (!email || !username || !phone || !password) {
      navigate("/dangky");
      return;
    }

    // Kiểm tra trạng thái OTP khi component mount
    checkOTPStatus();

    // Bộ đếm ngược
    const countdown = setInterval(() => {
      setTimer((prevTimer) => {
        if (prevTimer <= 1) {
          clearInterval(countdown);
          setIsResendDisabled(false);
          return 0;
        }
        return prevTimer - 1;
      });
    }, 1000);

    return () => clearInterval(countdown);
  }, [navigate, email, username, phone, password]);

  // Kiểm tra trạng thái OTP
  const checkOTPStatus = async () => {
    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/xacminhotp/check-status`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email }),
      });
      
      const data = await response.json();
      
      if (!response.ok) {
        throw new Error(data.message || "Lỗi kiểm tra OTP");
      }
      
      if (data.expired) {
        setError(data.message || "Mã OTP đã hết hạn");
        setIsResendDisabled(false);
        setTimer(0);
      } else {
        setTimer(Math.max(0, data.remainingTime));
        setIsResendDisabled(true);
      }
    } catch (err) {
      console.error("Lỗi khi kiểm tra OTP:", err);
      setError("Không thể kiểm tra trạng thái OTP");
    }
  };

  // Xác minh OTP
  const handleVerifyOTP = async () => {
    if (!otp) {
      setError("Vui lòng nhập mã OTP");
      return;
    }

    if (otp.length !== 6) {
      setError("Mã OTP phải có 6 chữ số");
      return;
    }

    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/xacminhotp`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          username,
          email,
          password,
          phone,
          otp,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || "Xác minh OTP thất bại");
      }

      setSuccess("Xác minh thành công! Đang chuyển hướng...");
      clearUserData();
      setTimeout(() => navigate("/dangnhap"), 2000);
    } catch (err) {
      setError(err.message || "Có lỗi xảy ra, vui lòng thử lại");
      console.error(err);
    }
  };

  // Gửi lại OTP
  const handleResendOTP = async () => {
    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/dangky/resend-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || "Gửi lại OTP thất bại");
      }

      setSuccess("Đã gửi lại mã OTP thành công!");
      setTimer(60); // Reset về 60 giây (1 phút)
      setIsResendDisabled(true);
      setError(null);
    } catch (err) {
      setError(err.message || "Có lỗi khi gửi lại OTP");
      console.error(err);
    }
  };

  // Xóa dữ liệu user
  const clearUserData = () => {
    sessionStorage.removeItem("email");
    sessionStorage.removeItem("username");
    sessionStorage.removeItem("phone");
    sessionStorage.removeItem("password");
  };

  // Định dạng thời gian
  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, "0")}:${secs.toString().padStart(2, "0")}`;
  };

  return (
    <section className={styles.verify_container}>
      <div className={styles.verify_box}>
        <h2>Xác Minh OTP</h2>
        <p className={styles.info}>Mã OTP đã được gửi đến: {email}</p>
        
        {success && <div className={styles.success}>{success}</div>}
        {error && <div className={styles.error}>{error}</div>}
        
        <input
          type="text"
          inputMode="numeric"
          pattern="[0-9]*"
          placeholder="Nhập mã OTP 6 số"
          value={otp}
          onChange={(e) => {
            const value = e.target.value.replace(/\D/g, "").slice(0, 6);
            setOtp(value);
            setError(null);
          }}
          className={styles.otp_input}
        />
        
        <div className={styles.timer}>
          Thời gian còn lại: {formatTime(timer)}
        </div>
        
        <button 
          onClick={handleVerifyOTP}
          className={styles.verify_button}
          disabled={!otp || otp.length !== 6}
        >
          Xác Minh
        </button>
        
        <button
          onClick={handleResendOTP}
          disabled={isResendDisabled}
          className={`${styles.resend_button} ${
            isResendDisabled ? styles.disabled : ""
          }`}
        >
          Gửi lại mã OTP
        </button>
      </div>
    </section>
  );
}