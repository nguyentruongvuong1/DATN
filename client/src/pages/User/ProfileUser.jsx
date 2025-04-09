import styles from"../../styles/User/profileuser.module.css";
import { useState, useEffect } from "react";
import { useSelector } from "react-redux";
import moment from "moment";
export default function Profileuser() {
  const user = useSelector((stare) => stare.auth.user);
  const [profile, setprofile] = useState([]);
  const [order, setorder] = useState([]);
  const [orderDetail, setOrderDetail] = useState([]);
  const [selectedOrderId, setSelectedOrderId] = useState(null);
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_URL}/user/user/${user?.id}`)
      .then((res) => res.json())
      .then((result) => setprofile(result));
    fetch(`${import.meta.env.VITE_API_URL}/user/order_user/${user?.id}`)
      .then((res) => res.json())
      .then((result) => setorder(result));
  }, [user?.id]);

 const fetchOrderDetail = async (order_id) => {
    try {
        const res = await fetch(`${import.meta.env.VITE_API_URL}/user/orderdetail_user/${order_id}`);
        
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
          <table className={styles.table_order}>
            <thead>
              <tr>
            <th>ID DH</th>
            <th>ID Voucher</th>
            <th>Trạng thái đơn hàng</th>
            <th>Trạng thái thanh toán</th>
            <th>Mã Giao dịch</th>
            <th>Phương thức thanh toán</th>
            <th>Ngày</th>
            <th>Chi tiết</th>
              </tr>
            </thead>
            <tbody>
              {order.map((or, index) => (
                <tr key={index}>
                  <td>{or.id}</td>
                  <td>{or.voucher_id === '' ? or.voucher_id : 'Không sử dụng'}</td>
                  <td>
                  {
                  or.order_status === 1 ? ('Chờ xác nhận') : 
                  or.order_status === 2 ? ('Đã xác nhận') : 
                  or.order_status === 3 ? ('Đang giao hàng') : 
                  ('Đã nhận hàng')
                }
                    
                    </td>
                  <td>{or.transaction_status === 2 ? 'Đã thanh toán' : 'Chưa thanh toán'}</td>
                  <td>{or.transaction_code}</td>
                  <td>{or.payment_method === 1 ? 'Tiền mặt' : 'MoMo'}</td>
                  <td>{moment(or.create_at).format('DD-MM-YYYY')}</td>               
                  <td>
                    <button onClick={() => fetchOrderDetail(or.id)} className={styles.btn_xem}>
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
      <table className={styles.table_order}>
        <thead>
          <tr>
            <th>ID đơn hàng</th>
            <th>Tên sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Tổng giá</th>
            <th>Ngày</th>
          </tr>
        </thead>
        <tbody>
          {
            orderDetail.map((item, index) => (
              <tr key={index}>
                <td>{item.order_id}</td>
                <td>{item.pr_id}</td>
                <td>{item.quantity}</td>
                <td>{item.price.toLocaleString('vi')}</td>
                <td>{(item.price * item.quantity).toLocaleString()} đ</td>
                <td>{moment(item.create_at).format('DD-MM-YYYY')}</td>
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
