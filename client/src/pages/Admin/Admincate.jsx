import React, { useState, useEffect } from "react";
import axios from "axios";
import { Link } from "react-router-dom";
import { Menu, Search } from "lucide-react";
import { FaArrowRight } from "react-icons/fa"; // Import icon mũi tên

import "../../styles/Admin/styleadmin.css";



const Admincate = () => {
  const [cate, setcates] = useState([]);
  const [editcate, setEditcate] = useState(null); // Lưu cate đang chỉnh sửa
  const [showAddForm, setShowAddForm] = useState(false); // Ẩn/hiện form
  const [newcate, setNewcate] = useState({
    name: "",
    status: "1",
  });

  useEffect(() => {
    axios.get("http://localhost:3000/admin/cate")
      .then((response) => {
        setcates(response.data);
      })
      .catch((error) => {
        console.error("Lỗi khi lấy dữ liệu:", error);
      });
  }, []);

  const fetchcates = async () => {
    try {
      const response = await axios.get("http://localhost:3000/admin/cate");
      setcates(response.data);
    } catch (error) {
      console.error("Lỗi khi lấy dữ liệu:", error);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Bạn có chắc muốn xóa cate này không?")) return;

    try {
      const response = await fetch(`http://localhost:3000/admin/cate/${id}`, {
        method: "DELETE",
      });

      const data = await response.json();
      console.log("Response:", data);

      if (response.ok) {
        alert("Xóa thành công!");
        fetchcates(); // Load lại danh sách
      } else {
        alert("Xóa thất bại: " + data.message);
      }
    } catch (error) {
      console.error("Lỗi khi xóa cate:", error);
    }
  };

  const handleNewcateChange = (e) => {
    setNewcate({ ...newcate, [e.target.name]: e.target.value });
  };

  const handleAddcate = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch(`http://localhost:3000/admin/cate`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name: newcate.name, status: newcate.status || "1" }),
      });

      const data = await response.json();

      if (response.ok) {
        alert("Thêm danh mục thành công!");
        setNewcate({ code: "", status: "1" }); // Reset lại form
        fetchcates();
        setShowAddForm(false);
      } else {
        alert("Thêm danh mục thất bại: " + data.message);
      }
    } catch (error) {
      console.error("Lỗi khi thêm danh mục:", error);
    }
  };



  // Hàm mở form sửa
  const handleEdit = (cate) => {
    setEditcate(cate);
  };

  // Hàm cập nhật dữ liệu khi nhập vào form
  const handleChange = (e) => {
    setEditcate({ ...editcate, [e.target.name]: e.target.value });
  };

  // Hàm lưu dữ liệu sau khi chỉnh sửa
  const handleSave = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch(`http://localhost:3000/admin/cate/${editcate.id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(editcate),
      });

      if (!response.ok) throw new Error("Cập nhật thất bại");

      alert("Cập nhật thành công!");

      // Cập nhật danh mục ngay thay vì chờ fetch từ server
      setcates((prevCates) =>
        prevCates.map((c) =>
          c.id === editcate.id ? { ...c, name: editcate.name } : c
        )
      );

      setEditcate(null);
    } catch (error) {
      console.error("Lỗi khi cập nhật cate:", error);
    }
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
            <h2>Quản Lý Danh Mục</h2>
            <button className="buttonAdd" onClick={() => setShowAddForm(true)}>Thêm Danh Mục</button>
          </div>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Tên Danh Mục</th>
                <th>Ngày Tạo</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {cate.map((cate) => (
                <tr key={cate.id}>
                  <td>{cate.id}</td>
                  <td>{cate.name}</td>
                  <td>{cate.create_date}</td>
                  <td>
                    <button className="btn-navigate" onClick={() => window.location.href = "/admin/characteristic"}>Quản lí đặc điểm <FaArrowRight /></button>                    
                    <button className="btn-edit" onClick={() => handleEdit(cate)}>Sửa</button>
                    <button className="btn-delete" onClick={() => handleDelete(cate.id)}>Xóa</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {/* Form chỉnh sửa cate */}
          {editcate && (
            <>
              <div className="modal-overlay" onClick={() => setEditcate(null)}></div>
              <div className="modal-container">
                <span className="modal-close-btn" onClick={() => setEditcate(null)}>&times;</span>
                <h3>Sửa cate</h3>

                <form onSubmit={handleSave}>
                  <label>Tên danh mục:</label>
                  <input type="text" name="name" value={editcate?.name || ""} onChange={handleChange} required />



                  <label>Trạng thái:</label>
                  <select name="status" value={editcate.status} onChange={handleChange}>
                    <option value="1">Hoạt động</option>
                    <option value="0">Hết hạn</option>
                  </select>

                  <button type="submit">Lưu</button>
                  <button type="button" className="cancel-btn" onClick={() => setEditcate(null)}>Hủy</button>
                </form>
              </div>
            </>
          )}

          {/* Form thêm cate */}

          {showAddForm && (
            <>
              <div className="modal-overlay" onClick={() => setShowAddForm(false)}></div>
              <div className="modal-container">
                <span className="modal-close-btn" onClick={() => setShowAddForm(false)}>&times;</span>
                <h3>Thêm danh mục</h3>

                <form onSubmit={handleAddcate}>
                  <label>Tên danh mục:</label>
                  <input type="text" name="name" value={newcate.name} onChange={handleNewcateChange} required />



                  <label>Trạng thái:</label>
                  <select name="status" value={newcate.status} onChange={handleNewcateChange}>
                    <option value="1">Hoạt động</option>
                    <option value="0">Hết hạn</option>
                  </select>

                  <button type="submit">Lưu</button>
                  <button type="button" className="cancel-btn" onClick={() => setShowAddForm(false)}>Hủy</button>
                </form>
              </div>
            </>
          )}


        </div>
      </div>
    </div>
  );
};

export default Admincate;
