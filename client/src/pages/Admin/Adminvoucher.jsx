import React, { useState, useEffect } from "react";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";
import ReactPaginate from "react-paginate";
import moment from "moment";
import { Menu, Search } from "lucide-react";


const AdminVoucher = () => {
  const [vouchers, setVouchers] = useState([]);
  const [formData, setFormData] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [isEdit, setIsEdit] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(8); // Số voucher mỗi trang
  const [totalVouchers, setTotalVouchers] = useState(0);
  const [sortOrder, setSortOrder] = useState("asc"); // Trạng thái sắp xếp (tăng dần hoặc giảm dần)


  useEffect(() => {
    const fetchVouchers = async () => {
      try {
        const response = await axios.get(
          `${import.meta.env.VITE_API_URL}/admin/vouchers?page=${currentPage}&limit=${itemsPerPage}`
        );
        setVouchers(response.data.vouchers || response.data);
        setTotalVouchers(response.data.total || response.data.length);
      } catch (error) {
        console.error("Lỗi khi tải voucher:", error);
      }
    };
    fetchVouchers();
  }, [currentPage, itemsPerPage]);


  const fetchVouchers = async () => {
    try {
      const { data } = await axios.get(
        `${import.meta.env.VITE_API_URL}/admin/vouchers?page=${currentPage}&limit=${itemsPerPage}`
      );
      setVouchers(data.vouchers || []);
      setTotalVouchers(data.total || 0);
    } catch (error) {
      console.error("Lỗi khi lấy dữ liệu:", error);
    }
  };


  const handleDelete = async (id) => {
    if (!window.confirm("Bạn có chắc muốn xóa voucher này không?")) return;
    try {
      await axios.delete(`${import.meta.env.VITE_API_URL}/admin/voucher/${id}`);
      fetchVouchers();
    } catch (error) {
      console.error("Lỗi khi xóa voucher:", error);
    }
  };

  const handleSave = async (e) => {
    e.preventDefault();
    try {
      if (isEdit) {
        await axios.put(`${import.meta.env.VITE_API_URL}/admin/voucher/${formData.id}`, formData);
      } else {
        await axios.post("${import.meta.env.VITE_API_URL}/admin/voucher", formData);
      }
      fetchVouchers();
      setShowForm(false);
    } catch (error) {
      console.error("Lỗi khi lưu voucher:", error);
    }
  };

  // const handlePageChange = (page) => {
  //   setCurrentPage(Math.max(1, page)); // Đảm bảo trang không nhỏ hơn 1
  // };

  const handlePageChange = (selectedItem) => {
    setCurrentPage(selectedItem.selected + 1);
  };
  const handleSort = () => {
    const sortedVouchers = [...vouchers];
    if (sortOrder === "asc") {
      sortedVouchers.sort((a, b) => a.id - b.id); // Sắp xếp tăng dần
      setSortOrder("desc");
    } else {
      sortedVouchers.sort((a, b) => b.id - a.id); // Sắp xếp giảm dần
      setSortOrder("asc");
    }
    setVouchers(sortedVouchers); // Cập nhật lại vouchers với thứ tự đã sắp xếp
  };

  return (
    <div className="main">
      <div className="topbar">
        <div className="toggle">
          <Menu size={24} />
        </div>
        <div className="search">
          <label>
            <input type="text" placeholder="Tìm kiếm" />
            <Search size={24} />
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
                <th onClick={handleSort} style={{ cursor: "pointer" }}>
                  ID {sortOrder === "asc" ? "↑" : "↓"}
                </th>
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
                  <td>{moment(voucher.start_date).format('DD-MM-YYYY')}</td>
                  <td>{moment(voucher.end_date).format('DD-MM-YYYY')}</td>
                  <td>{voucher.status === 1 ? "Hoạt động" : "Hết hạn"}</td>
                  <td>
                    <button onClick={() => { setShowForm(true); setIsEdit(true); setFormData(voucher); }}>Sửa</button>
                    <button onClick={() => handleDelete(voucher.id)}>Xóa</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {totalVouchers > itemsPerPage && (
            <div className="paginationContainer">
              <ReactPaginate
                breakLabel="⋯"
                nextLabel=">"
                previousLabel="<"
                onPageChange={handlePageChange}
                pageRangeDisplayed={2}
                marginPagesDisplayed={1}
                pageCount={Math.ceil(totalVouchers / itemsPerPage)}
                containerClassName="pagination"
                pageClassName="pageItem"
                pageLinkClassName="pageLink"
                previousClassName="pageItem"
                previousLinkClassName="pageLink previousLink"
                nextClassName="pageItem"
                nextLinkClassName="pageLink nextLink"
                activeClassName="active"
                breakClassName="breakItem"
                forcePage={Math.min(Math.max(0, currentPage - 1), Math.ceil(totalVouchers / itemsPerPage) - 1)}
              />
            </div>
          )}


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
