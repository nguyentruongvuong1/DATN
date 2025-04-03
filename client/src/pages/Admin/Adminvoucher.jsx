import React, { useState, useEffect } from "react";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";


const AdminVoucher = () => {
  const [vouchers, setVouchers] = useState([]);
  const [formData, setFormData] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [isEdit, setIsEdit] = useState(false);

  useEffect(() => {
    fetchVouchers();
  }, []);

  const fetchVouchers = async () => {
    try {
      const { data } = await axios.get("http://localhost:3000/admin/voucher");
      setVouchers(data);
    } catch (error) {
      console.error("Lỗi khi lấy dữ liệu:", error);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Bạn có chắc muốn xóa voucher này không?")) return;
    try {
      await axios.delete(`http://localhost:3000/admin/voucher/${id}`);
      fetchVouchers();
    } catch (error) {
      console.error("Lỗi khi xóa voucher:", error);
    }
  };

  const handleSave = async (e) => {
    e.preventDefault();
    try {
      if (isEdit) {
        await axios.put(`http://localhost:3000/admin/voucher/${formData.id}`, formData);
      } else {
        await axios.post("http://localhost:3000/admin/voucher", formData);
      }
      fetchVouchers();
      setShowForm(false);
    } catch (error) {
      console.error("Lỗi khi lưu voucher:", error);
    }
  };

  return (
    <div className="main">
      <div className="topbar">
        <div className="toggle">
        <ion-icon name="menu-outline"></ion-icon>
        </div>
        <div className="search">
          <label>
            <input type="text" placeholder="Tìm kiếm" />
            <ion-icon name="search-outline"></ion-icon>
          </label>
        </div>
        <div className="user">
          <img src="/images/user.jpg" alt="User" />
        </div>
      </div>
      <div className="details">
        <div className="recentOrders">
          <div className="cardHeader">
            <h2>Quản Lý Mã Giảm Giá</h2>
            <button className="buttonAdd" onClick={() => { setShowForm(true); setIsEdit(false); setFormData({ code: '', discount_type: 'fixed', discount_value: 0, quantity: 1, end_date: '', status: 1 }); }}>Thêm Voucher</button>
          </div>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Mã giảm giá</th>
                <th>Số lượng</th>
                <th>Kiểu giảm</th>
                <th>Giá trị</th>
                <th>Đã sử dụng</th>
                <th>Ngày tạo</th>
                <th>Ngày hết hạn</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {vouchers.map((voucher) => (
                <tr key={voucher.id}>
                  <td>{voucher.id}</td>
                  <td>{voucher.code}</td>
                  <td>{voucher.quantity}</td>
                  <td>{voucher.discount_type}</td>
                  <td>{voucher.discount_value}</td>
                  <td>{voucher.used_count}</td>
                  <td>{voucher.start_date}</td>
                  <td>{voucher.end_date}</td>
                  <td>{voucher.status === 1 ? "Hoạt động" : "Hết hạn"}</td>
                  <td>
                    <button onClick={() => { setShowForm(true); setIsEdit(true); setFormData(voucher); }}>Sửa</button>
                    <button onClick={() => handleDelete(voucher.id)}>Xóa</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {showForm && (
            <>
            {/* Lớp phủ nền để làm mờ background */}
            <div className="modal-overlay" onClick={() => setShowForm(false)}></div>
            <div className="modal-container">
              <h3>{isEdit ? "Sửa" : "Thêm"} Voucher</h3>
              <form onSubmit={handleSave}>
                <label>Mã Voucher:</label>
                <input type="text" value={formData.code} onChange={(e) => setFormData({ ...formData, code: e.target.value })} required />
                <label>Loại giảm:</label>
                <select value={formData.discount_type} onChange={(e) => setFormData({ ...formData, discount_type: e.target.value })}>
                  <option value="fixed">Giảm tiền</option>
                  <option value="percent">Giảm phần trăm</option>
                </select>
                <label>Giá trị giảm:</label>
                <input type="number" value={formData.discount_value} onChange={(e) => setFormData({ ...formData, discount_value: Math.max(0, e.target.value) })} />
                <label>Số lượng:</label>
                <input type="number" value={formData.quantity} onChange={(e) => setFormData({ ...formData, quantity: Math.max(0, e.target.value) })} />
                <label>Ngày hết hạn:</label>
                <input type="date" value={formData.end_date} onChange={(e) => setFormData({ ...formData, end_date: e.target.value })} />
                <label>Trạng thái:</label>
                <select value={formData.status} onChange={(e) => setFormData({ ...formData, status: e.target.value })}>
                  <option value="1">Hoạt động</option>
                  <option value="0">Hết hạn</option>
                </select>
                <button type="submit">Lưu</button>
                <button type="button" className="cancel-btn" onClick={() => setShowForm(false)}>Hủy</button>
              </form>
            </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default AdminVoucher;
