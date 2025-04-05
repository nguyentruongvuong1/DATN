import React from "react";
import { Link } from "react-router-dom";
import { Menu } from "lucide-react";

import "../../styles/Admin/styleadmin.css"; // Đảm bảo đường dẫn đúng
import Bieudo from "../../components/Admin/Bieudo.jsx"; // Đảm bảo đường dẫn đúng


const AdminDashboard = () => {
  return (
    <div className="main">
      <div className="topbar">
        <div className="toggle">
          <Menu size={24} />
        </div>
        
      </div>
      <div className="cardBox">
        <div className="card">
          <div>
            <div className="numbers">500,000 VND</div>
            <div className="cardName">Doanh Thu Theo Ngày </div>
          </div>
          <div className="iconBx">
            <ion-icon name="eye-outline"></ion-icon>
          </div>
        </div>
        <div className="card">
          <div>
            <div className="numbers">1,500,000 VND</div>
            <div className="cardName">Doanh Thu Theo Tuần</div>
          </div>
          <div className="iconBx">
            <ion-icon name="cart-outline"></ion-icon>
          </div>
        </div>
        <div className="card">
          <div>
            <div className="numbers">20,000,000 VND</div>
            <div className="cardName">Doanh Thu Theo Tháng</div>
          </div>
          <div className="iconBx">
            <ion-icon name="people-outline"></ion-icon>
          </div>
        </div>
        <div className="card">
          <div>
            <div className="numbers">1000000000 VND</div>
            <div className="cardName">Tổng Doanh Thu</div>
          </div>
          <div className="iconBx">
            <ion-icon name="cash-outline"></ion-icon>
          </div>
        </div>
        <div className="card">
          <div>
            <div className="numbers">1,504</div>
            <div className="cardName">Tổng Đơn Hàng</div>
          </div>
          <div className="iconBx">
            <ion-icon name="eye-outline"></ion-icon>
          </div>
        </div>
        <div className="card">
          <div>
            <div className="numbers">80</div>
            <div className="cardName">Tổng Người Dùng</div>
          </div>
          <div className="iconBx">
            <ion-icon name="cart-outline"></ion-icon>
          </div>
        </div>
        <div className="card">
          <div>
            <div className="numbers">284</div>
            <div className="cardName">Người Dùng Mới</div>
          </div>
          <div className="iconBx">
            <ion-icon name="people-outline"></ion-icon>
          </div>
        </div>
        <div className="card">
          <div>
            <div className="numbers">42</div>
            <div className="cardName">Số Lượng Bài Viết</div>
          </div>
          <div className="iconBx">
            <ion-icon name="cash-outline"></ion-icon>
          </div>
        </div>
      </div>
      <div className="graphBox">

        <Bieudo />
      </div>

      <div className="details">
        <div className="recentOrders">
          <div className="cardHeader">
            <h2>Bảng Doanh Thu</h2>
          </div>
          <table>
            <thead>
              <tr>
                <td>Name</td>
                <td>Price</td>
                <td>Payment</td>
                <td>Status</td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Star Refrigerator</td>
                <td>$1200</td>
                <td>Paid</td>
                <td><span className="status delivered">Delivered</span></td>
              </tr>
              <tr>
                <td>Window Coolers</td>
                <td>$110</td>
                <td>Due</td>
                <td><span className="status pending">Pending</span></td>
              </tr>
              <tr>
                <td>Speakers</td>
                <td>$620</td>
                <td>Paid</td>
                <td><span className="status return">Return</span></td>
              </tr>
              <tr>
                <td>Hp Laptop</td>
                <td>$110</td>
                <td>Due</td>
                <td><span className="status inprogress">In Progress</span></td>
              </tr>
              <tr>
                <td>Apple Watch</td>
                <td>$1200</td>
                <td>Paid</td>
                <td><span className="status delivered">Delivered</span></td>
              </tr>
              <tr>
                <td>Wall Fan</td>
                <td>$110</td>
                <td>Paid</td>
                <td><span className="status pending">Pending</span></td>
              </tr>
              <tr>
                <td>Adidas Shoes</td>
                <td>$620</td>
                <td>Paid</td>
                <td><span className="status return">Return</span></td>
              </tr>
              <tr>
                <td>Denim Shirts</td>
                <td>$110</td>
                <td>Due</td>
                <td><span className="status inprogress">In Progress</span></td>
              </tr>
              <tr>
                <td>Casual Shoes</td>
                <td>$575</td>
                <td>Paid</td>
                <td><span className="status pending">Pending</span></td>
              </tr>
              <tr>
                <td>Wall Fan</td>
                <td>$110</td>
                <td>Paid</td>
                <td><span className="status pending">Pending</span></td>
              </tr>
              <tr>
                <td>Denim Shirts</td>
                <td>$110</td>
                <td>Due</td>
                <td><span className="status inprogress">In Progress</span></td>
              </tr>
            </tbody>
          </table>
        </div>

      </div>
    </div >

  );
}

export default AdminDashboard;