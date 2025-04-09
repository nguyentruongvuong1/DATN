import React from "react";
import { Link, useLocation } from "react-router-dom";
import { 
  MdDashboard, MdCategory, MdWork, MdLocalOffer, 
  MdReceipt, MdPerson, MdStar, MdImage, MdArrowDropDown  
} from "react-icons/md"; // Import icons từ react-icons
import "../../styles/ADmin/styleadmin.css"; // Đảm bảo đường dẫn đúng

const AdminMenu = () => {
  const location = useLocation(); // Lấy đường dẫn hiện tại

  return (
    <div className="navigation">
      <ul>
        <li>
          <Link to="/">
            <img src="./../images/logwhite.png" alt="" className="logo" width={250} height={40} />
          </Link>
        </li>

        <li className={location.pathname === "/admin/dashboard" ? "hovered" : ""}>
          <Link to="/admin/dashboard">
            <span className="icon"><MdDashboard size={24} /></span>
            <span className="title">Trang quản trị</span>
          </Link>
        </li>

        <li className={`has-submenu ${location.pathname.startsWith("/admin/cate") ? "hovered" : ""}`}>
          <Link to="/admin/cate">
            <span className="icon"><MdCategory size={24} /></span>
            <span className="title">Danh mục </span>
          </Link>
          <div className="submenu">
            <div><Link to="/admin/cate">Danh mục Chính</Link></div>
            <div><Link to="/admin/characteristic">Đặc điểm</Link></div>
            <div><Link to="/admin/typecate">Thể loại</Link></div>
          </div>
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

        <li className={location.pathname === "/admin/reviews" ? "hovered" : ""}>
          <Link to="/admin/reviews">
            <span className="icon"><MdStar size={24} /></span>
            <span className="title">Đánh Giá</span>
          </Link>
        </li>
        <li className={location.pathname === "/admin/banner" ? "hovered" : ""}>
          <Link to="/admin/banner">
            <span className="icon"><MdImage size={24}  /></span>
            <span className="title">Banner</span>
          </Link>
        </li>
      </ul>
    </div>
  );
};

export default AdminMenu;
