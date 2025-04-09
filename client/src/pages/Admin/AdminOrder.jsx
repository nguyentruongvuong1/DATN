import React, { useState, useEffect } from "react";
import { Menu, Search, Eye } from "lucide-react";
import ReactPaginate from "react-paginate";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";
import { Link } from "react-router-dom";
import moment from "moment";



export default function AdminOrder() {

  const getStatusName = (status) => {
    switch (status) {
      case 1:
        return "Chờ xác nhận";
      case 2:
        return "Xác nhận";
      case 3:
        return "Đang giao";
      case 4:
        return "Hoàn thành";
      default:
        return "Không xác định";
    }
  };

  const [order, setOrder] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(8);
  const [totalOrder, setTotalOrder] = useState(0);
  const [model, setmodel] = useState(false);

  const [order_detail, setorder_detail] = useState([]);

  const fecth_Ordetail = async (order_id) => {
    try {
      const res = await fetch(
        `http://localhost:3000/admin/order_detail/${order_id}`
      );
      const data = await res.json(); // Thêm await
      setorder_detail(Array.isArray(data) ? data : []); // Đảm bảo luôn là mảng
      setmodel(true);
    } catch (error) {
      console.error("Lỗi khi lấy chi tiết đơn hàng:", error);
      setorder_detail([]);
      setmodel(false);
    }
  };

  const fetchOrder = async () => {
    try {
      const response = await axios.get(
        `http://localhost:3000/admin/order?page=${currentPage}&limit=${itemsPerPage}`
      );
      setOrder(response.data.order || response.data);
      setTotalOrder(response.data.total || response.data.length);
      console.log(response.data);
    } catch (error) {
      console.error("Lỗi khi lấy dữ liệu bình luận:", error);
    }
  };

  useEffect(() =>{
    fetchOrder()
  },[])

  const handleStatusChange = async (orderId, currentStatus, newStatus) => {
    try {
      const res = await axios.put(
        `http://localhost:3000/admin/order_status/${orderId}`,
        { order_status: newStatus }
      );
  
      // Cập nhật UI ngay lập tức
      setOrder(prev => prev.map(item => 
        item.id === orderId ? { ...item, order_status: newStatus } : item
      ));
  
      alert(res.data.message || "Cập nhật thành công!");
    } catch (error) {
      console.error("Chi tiết lỗi:", error.response?.data || error.message);
      alert(error.response?.data?.error || "Lỗi server! Vui lòng thử lại.");
    }
  };


  const handlePageChange = (selectedItem) => {
    setCurrentPage(selectedItem.selected + 1);
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
            <h2>Quản Lý Đơn Hàng</h2>
          </div>
          <table className="comment-table">
            <thead>
              <tr>
                <th>ID DH</th>
                <th>ID US</th>
                <th>Tên</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Ghi chú</th>
                <th>Mã giảm giá</th>
                <th>Trạng thái thanh toán</th>
                <th>Mã thanh toán</th>
                <th>Phương thức thanh toán</th>
                <th>Ngày</th>
                <th>Trạng thái</th>
                <th>Chi tiết</th>
              </tr>
            </thead>
            <tbody>
              {order.map((or, index) => (
                <tr key={index}>
                  <td>{or.id}</td>
                  <td>{or.user_id}</td>
                  <td>{or.name}</td>
                  <td>{or.address}</td>
                  <td>{or.phone}</td>
                  <td>{or.note === "" ? "không có" : or.note}</td>
                  <td>
                    {or.voucher_id === null ? "Không sử dụng" : or.voucher_id}
                  </td>
                  <td>{or.transaction_status === 2 ?'Đã thanh toán' : 'Chưa thanh toán' }</td>
                  <td>{or.transaction_code}</td>
                  <td>{or.payment_method === 1 ? "Tiền mặt" : "MoMo"}</td>
                  <td>{moment(or.create_at).format("DD-MM-YYYY")}</td>
                  <td>
                    <select
                      value={or.order_status}
                      onChange={(e) =>
                        handleStatusChange(
                          or.id,
                          or.order_status,
                          parseInt(e.target.value)
                        )
                      }
                    >
                      {[1, 2, 3, 4].map((status) => (
                        <option
                          key={status}
                          value={status}
                          disabled={
                            status <= or.order_status ||
                            status - or.order_status > 1
                          }
                        >
                          {getStatusName(status)}
                        </option>
                      ))}
                    </select>
                  </td>
                  <td>
                    <button onClick={() => fecth_Ordetail(or.id)}>
                      Xem
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {totalOrder > itemsPerPage && (
            <div className="paginationContainer">
              <ReactPaginate
                breakLabel="⋯"
                nextLabel=">"
                previousLabel="<"
                onPageChange={handlePageChange}
                pageRangeDisplayed={2}
                marginPagesDisplayed={1}
                pageCount={Math.ceil(totalOrder / itemsPerPage)}
                containerClassName="pagination"
                pageClassName="pageItem"
                pageLinkClassName="pageLink"
                previousClassName="pageItem"
                previousLinkClassName="pageLink previousLink"
                nextClassName="pageItem"
                nextLinkClassName="pageLink nextLink"
                activeClassName="active"
                breakClassName="breakItem"
                forcePage={Math.min(
                  Math.max(0, currentPage - 1),
                  Math.ceil(totalOrder / itemsPerPage) - 1
                )}
              />
            </div>
          )}
        </div>

        {model && (
  <div className="modal-wrapper">
    <table className="table_ordertail">
      <thead>
        <tr>
          <th>ID DH</th>
          <th>Mã SP</th>
          <th>Tên SP</th>
          <th>Số lượng</th>
          <th>Đơn giá</th>
          <th>Thành tiền</th>
          <th>Ngày tạo</th>
        </tr>
      </thead>
      <tbody>
        {order_detail.map((order_d, index) => (
          <tr key={index}>
            <td>{order_d.order_id}</td>
            <td>{order_d.pr_id}</td>
            <td>{order_d.product_name}</td>
            <td>{order_d.quantity}</td>
            <td>{order_d.price}</td>
            <td>{order_d.total}</td>
            <td>{moment(order_d.create_at).format("DD-MM-YYYY")}</td>
          </tr>
        ))}
      </tbody>
    </table>
  </div>
)}
      </div>
    </div>
  );
}
