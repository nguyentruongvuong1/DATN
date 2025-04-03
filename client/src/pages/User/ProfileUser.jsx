import styles from"../../styles/User/profileuser.module.css";
import { useState, useEffect } from "react";
import { useSelector } from "react-redux";
export default function Profileuser() {
  const user = useSelector((stare) => stare.auth.user);
  const [profile, setprofile] = useState([]);
  const [order, setorder] = useState([]);
  const [orderDetail, setOrderDetail] = useState([]);
  const [selectedOrderId, setSelectedOrderId] = useState(null);
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    fetch(`http://localhost:3000/user/user/${user?.id}`)
      .then((res) => res.json())
      .then((result) => setprofile(result));
    fetch(`http://localhost:3000/user/order_user/${user?.id}`)
      .then((res) => res.json())
      .then((result) => setorder(result));
  }, [user?.id]);

 const fetchOrderDetail = async (order_id) => {
    try {
        const res = await fetch(`http://localhost:3000/user/orderdetail_user/${order_id}`);
        
        if (!res.ok) {
            throw new Error(`Lỗi server: ${res.status}`);
        }

        const text = await res.text();
        if (!text.trim()) {
            throw new Error("API trả về dữ liệu rỗng");
        }

        const data = JSON.parse(text);
        setOrderDetail(data);
        setSelectedOrderId(order_id);
        setShowModal(true);
    } catch (error) {
        console.error("Lỗi khi lấy chi tiết đơn hàng:", error);
        setOrderDetail([]); // Tránh lỗi undefined khi render
    }
};

  const closeModal = () => {
    setShowModal(false);
  };
  return (
    <div className={styles.container_full}>
      <div className={styles.fix}>
        <a href="">Cập nhật thông tin</a>
      </div>

      <div className={styles.user}>Thông tin người dùng</div>

      <div className={styles.container}>
        <div className={styles.user1}>
          <div className={styles.circle}>
            <img src={profile.avatar} alt="" />
          </div>
          <p>
            {" "}
            <strong>Tên người dùng:</strong> {profile.username}
          </p>
          <p>
            <strong>Email:</strong> {profile.email}
          </p>
          <p>
            <strong>Số điện thoại:</strong> {profile.phone}
          </p>
          <p>
            <strong>Địa chỉ:</strong>{" "}
            {profile.address?.length > 0
              ? profile.address
              : "Bạn chưa nhập địa chỉ"}
          </p>
        </div>
      </div>
      <div className={styles.container}>
        <div className={styles.history}>
          <div className={styles.text}>
            <b>Lịch sử đơn hàng</b>
          </div>
          <table>
            <thead>
              <tr>
                <th>ID đơn hàng</th>
                <th>Phương thức thanh toán</th>
                <th>Ngày mua</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {order.map((or, index) => (
                <tr key={index}>
                  <td>{or.id}</td>
                  <td>Cây kim tiền</td>
                  <td>21/2/2025</td>
                  <td className={styles.ttdagiao}>
                    <div className={styles.texttt}>Đã giao</div>
                  </td>
                  <td>
                    <button onClick={() => fetchOrderDetail(or.id)}>
                      {" "}
                      Xem
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {showModal && (
  <div className={styles.modal} onClick={closeModal}>
    <div
      className={styles["modal-content"]}
      onClick={(e) => e.stopPropagation()}
    >
      <button className={styles["close-btn"]} onClick={closeModal}>
        X
      </button>
      <h3>Chi tiết đơn hàng #{selectedOrderId}</h3>
      <table>
        <thead>
          <tr>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Tổng</th>
          </tr>
        </thead>
        <tbody>
          {
            orderDetail.map((item, index) => (
              <tr key={index}>
                <td>{item.pr_id}</td>
                <td>{item.quantity}</td>
                <td>{item.price.toLocaleString('vi')} VNĐ</td>
                <td>{(item.price * item.quantity).toLocaleString()} đ</td>
              </tr>
            ))
          }
        </tbody>
      </table>
    </div>
  </div>
)}

    </div>
  );
}
