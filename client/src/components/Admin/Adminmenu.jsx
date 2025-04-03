import React from "react";
import { Link, useLocation } from "react-router-dom";
import { 
  MdDashboard, MdCategory, MdWork, MdLocalOffer, 
  MdReceipt, MdPerson, MdStar 
} from "react-icons/md"; // Import icons từ react-icons
import "../../styles/Admin/styleadmin.css";


const AdminMenu = () => {
  const location = useLocation(); // Lấy đường dẫn hiện tại

  return (
    <div className="navigation">
      <ul>
      <Link to="/">
        <li>
            <img src="./../images/logwhite.png" alt="" className="logo" width={250} height={40} />
        </li>
        </Link>


        <li className={location.pathname === "/admin/dashboard" ? "hovered" : ""}>
          <Link to="/admin/dashboard">
            <span className="icon"><MdDashboard size={24} /></span>
            <span className="title">Trang quản trị</span>
          </Link>
        </li>

        <li className={`has-submenu ${location.pathname.startsWith("/admin/cate") ? "hovered" : ""}`}>
          <Link to="/admin/cate">
            <span className="icon"><MdCategory size={24} /></span>
            <span className="title">Danh mục</span>
          </Link>
          <ul className="submenu">
            <li><Link to="/admin/cate">Danh mục Chính</Link></li>
            <li><Link to="/admin/characteristic">Đặc điểm</Link></li>
            <li><Link to="/admin/typecate">Thể loại</Link></li>
          </ul>
        </li>

        <li className={location.pathname === "/admin/product" ? "hovered" : ""}>
          <Link to="/admin/product">
            <span className="icon"><MdWork size={24} /></span>
            <span className="title">Sản Phẩm</span>
          </Link>
        </li>

        <li className={location.pathname === "/admin/voucher" ? "hovered" : ""}>
          <Link to="/admin/voucher">
            <span className="icon"><MdLocalOffer size={24} /></span>
            <span className="title">Mã Giảm Giá</span>
          </Link>
        </li>

        <li className={location.pathname === "/admin/order" ? "hovered" : ""}>
          <Link to="/admin/order">
            <span className="icon"><MdReceipt size={24} /></span>
            <span className="title">Đơn Hàng</span>
          </Link>
        </li>

        <li className={location.pathname === "/admin/account" ? "hovered" : ""}>
          <Link to="/admin/account">
            <span className="icon"><MdPerson size={24} /></span>
            <span className="title">Tài Khoản</span>
          </Link>
        </li>

        <li className={location.pathname === "/admin/comment" ? "hovered" : ""}>
          <Link to="/admin/comment">
            <span className="icon"><MdStar size={24} /></span>
            <span className="title">Đánh Giá</span>
          </Link>
        </li>
      </ul>
    </div>
  );
};

export default AdminMenu;
