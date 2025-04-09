import React, { useState, useEffect } from "react";
import axios from "axios";
import { Link } from "react-router-dom";
import { Menu, Search } from "lucide-react";
import { FaArrowRight } from "react-icons/fa"; // Import icon mũi tên
import moment from "moment"; // Import thư viện moment.js để định dạng ngày tháng
import "../../styles/Admin/styleadmin.css";

const Admincate = () => {
  const [cate, setcates] = useState([]);
  const [editcate, setEditcate] = useState(null); // Lưu cate đang chỉnh sửa
  const [showAddForm, setShowAddForm] = useState(false); // Ẩn/hiện form
  const [searchTerm, setSearchTerm] = useState('');

  const [newcate, setNewcate] = useState({
    name: "",
    content: "",
    status: "1",
    image: null,
    image_content: null
  });

  useEffect(() => {
    axios.get(`${import.meta.env.VITE_API_URL}/adminc/cate`)
      .then((response) => {
        setcates(response.data);
      })
      .catch((error) => {
        console.error("Lỗi khi lấy dữ liệu:", error);
      });
  }, []);

  const fetchcates = async () => {
    try {
      const response = await axios.get(`${import.meta.env.VITE_API_URL}/adminc/cate`);
      setcates(response.data);
    } catch (error) {
      console.error("Lỗi khi lấy dữ liệu:", error);
    }
  };

  useEffect(() => {
    const delayDebounce = setTimeout(() => {
      axios
        .get(`${import.meta.env.VITE_API_URL}/adminc/cate?search=${encodeURIComponent(searchTerm)}`)
        .then((res) => setcates(res.data))
        .catch((err) => console.error("Lỗi tìm kiếm:", err));
    }, 300); // debounce 300ms
  
    return () => clearTimeout(delayDebounce);
  }, [searchTerm]);
  const handleDelete = async (id) => {
    if (!window.confirm("Bạn có chắc muốn xóa cate này không?")) return;

    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/adminc/cate/${id}`, {
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
    const { name, value } = e.target;
    setNewcate((prev) => ({
      ...prev,
      [name]: value,
    }));
  };



  const handleAddcate = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    formData.append("name", newcate.name);
    formData.append("content", newcate.content);
    formData.append("status", newcate.status);
    if (newcate.image) formData.append("image", newcate.image);
    if (newcate.image_content) formData.append("image_content", newcate.image_content);

    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/adminc/cate`, {
        method: "POST",
        body: formData,
      });

      const data = await response.json();

      if (response.ok) {
        alert("Thêm danh mục thành công!");
        setNewcate({
          name: "",
          content: "",
          status: "1",
          image: null,
          image_content: null,
        });
        fetchcates();
        setShowAddForm(false);
      } else {
        alert("Thêm thất bại: " + data.message);
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
      const formData = new FormData();
      formData.append("name", editcate.name);
      formData.append("content", editcate.content);
      formData.append("status", editcate.status);

      if (editcate.newImage) {
        formData.append("image", editcate.newImage);
      }

      if (editcate.newImageContent) {
        formData.append("image_content", editcate.newImageContent);
      }

      const response = await fetch(`${import.meta.env.VITE_API_URL}/adminc/cate/${editcate.id}`, {
        method: "PUT",
        body: formData,
      });

      if (!response.ok) throw new Error("Cập nhật thất bại");

      alert("Cập nhật thành công!");
      fetchcates();
      setEditcate(null);

    } catch (error) {
      console.error("Lỗi khi cập nhật cate:", error);
      alert("Đã có lỗi xảy ra khi cập nhật danh mục.");
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
    <input
      type="text"
      placeholder="Tìm kiếm"
      value={searchTerm}
      onChange={(e) => setSearchTerm(e.target.value)}
    />
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
                <th>Ảnh</th>
                <th>Tên Danh Mục</th>
                <th>Nội dung</th>
                <th>Ảnh nội dung</th>
                <th>Ngày Tạo</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {cate.map((cate) => (
                <tr key={cate.id}>
                  <td>{cate.id}</td>
                  <td><img style={{ width: '50px', height: '50px' }} src={
                        cate.image &&
                        cate.image.startsWith("../../public/images")
                          ? `${import.meta.env.VITE_API_URL}/${cate.image}`
                          : cate.image 
                      } alt="" /></td>
                  <td>{cate.name}</td>
                  <td width={'250px'}>{cate.content.length > 30 ? cate.content.slice(0, 30) + '...' : cate.content}</td>
                  <td><img style={{ width: '50px', height: '50px' }} src={
                        cate.image_content &&
                        cate.image_content.startsWith("../../public/images")
                          ? `${import.meta.env.VITE_API_URL}/${cate.image_content}`
                          : cate.image_content 
                      }
                    alt="" /></td>
                  <td>{moment(cate.create_date).format('DD-MM-YYYY')}</td>
                  <td>
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
                <h3>Sửa danh mục</h3>

                <form onSubmit={handleSave} encType="multipart/form-data">
                  <label>Tên danh mục:</label>
                  <input type="text" name="name" value={editcate.name || ""} onChange={handleChange} required />

                  <label>Nội dung:</label>
                  <input type="text" name="content" value={editcate.content || ""} onChange={handleChange} required />

                  <label>Ảnh hiện tại:</label>
                  <img src={`${import.meta.env.VITE_API_URL}/public/${editcate.image}`} alt="Ảnh" width="60" />
                  <input type="file" name="image" accept="image/*" onChange={(e) => setEditcate({ ...editcate, newImage: e.target.files[0] })} />

                  <label>Ảnh nội dung hiện tại:</label>
                  <img src={`${import.meta.env.VITE_API_URL}/public/${editcate.image_content}`} alt="Ảnh ND" width="60" />
                  <input type="file" name="image_content" accept="image/*" onChange={(e) => setEditcate({ ...editcate, newImageContent: e.target.files[0] })} />

                  <label>Trạng thái:</label>
                  <select name="status" value={editcate.status} onChange={handleChange}>
                    <option value="1">Hiện</option>
                    <option value="0">Ẩn</option>
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

                <form onSubmit={handleAddcate} encType="multipart/form-data">
                  <label>Tên danh mục:</label>
                  <input type="text" name="name" value={newcate.name} onChange={handleNewcateChange} required />

                  <label>Nội dung:</label>
                  <input type="text" name="content" value={newcate.content} onChange={handleNewcateChange} required />

                  <label>Ảnh:</label>
                  <input type="file" name="image" accept="image/*" onChange={(e) => setNewcate({ ...newcate, image: e.target.files[0] })} />

                  <label>Ảnh nội dung:</label>
                  <input type="file" name="image_content" accept="image/*" onChange={(e) => setNewcate({ ...newcate, image_content: e.target.files[0] })} />

                  <label>Trạng thái:</label>
                  <select name="status" value={newcate.status} onChange={handleNewcateChange}>
                    <option value="1">Hiện</option>
                    <option value="0">Ẩn</option>
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
