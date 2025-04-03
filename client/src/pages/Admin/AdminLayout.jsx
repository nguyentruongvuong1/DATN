import React from "react";
import { Outlet } from "react-router-dom"; // Import Outlet
import AdminMenu from "../components/Adminmenu"; 
import "../../styles/Admin/styleadmin.css";

import AdminDashboard from "../pages/Admindashboard";

const AdminLayout = () => {
  return (
    <div className="admin-container">
      <AdminMenu /> {/* Menu xuất hiện trên tất cả các trang admin */}
      <div className="content">
        <Outlet /> {/* Hiển thị nội dung trang con */}
      </div>
    </div>
  );
};

export default AdminLayout;
