import React, { useState, useEffect } from "react";
import { Menu, Search } from "lucide-react";
import ReactPaginate from "react-paginate";

import axios from "axios";
import "../../styles/Admin/styleadmin.css";

const AdminTypecate = () => {
    const [typecate, setTypecate] = useState([]);
    const [editTypecate, setEditTypecate] = useState(null);
    const [showAddForm, setShowAddForm] = useState(false);
    const [totalItems, setTotalItems] = useState(0);
    const [currentPage, setCurrentPage] = useState(0);
    const itemsPerPage = 8;
    const [newTypecate, setNewTypecate] = useState({
        characteristic_id: "",
        name: "",
        image: "",
        content: "",
    });

    useEffect(() => {
        fetchTypecate();
    }, [currentPage]); // Không có setState trong cùng useEffect này


    const [characteristic, setCharacteristics] = useState([]);

    useEffect(() => {
        fetchCharacteristics();
    }, []);

    const fetchCharacteristics = async () => {
        try {
            const response = await axios.get("http://localhost:3000/adminc/characteristic");
            setCharacteristics(response.data);
        } catch (error) {
            console.error("Lỗi khi lấy đặc điểm:", error);
        }
    };

    const fetchTypecate = async () => {
        try {
            const response = await axios.get(`http://localhost:3000/adminc/typecate?page=${currentPage + 1}&limit=${itemsPerPage}`);
            setTypecate(response.data.typecates);
            setTotalItems(response.data.total);
        } catch (error) {
            console.error("Lỗi khi lấy dữ liệu:", error);
        }
    };

    const handleDelete = async (id) => {
        if (!window.confirm("Bạn có chắc muốn xóa không?")) return;
        try {
            await axios.delete(`http://localhost:3000/adminc/typecate/${id}`);
            alert("Xóa thành công!");
            fetchTypecate();
        } catch (error) {
            console.error("Lỗi khi xóa:", error);
        }
    };

    const handleNewTypecateChange = (e) => {
        setNewTypecate({ ...newTypecate, [e.target.name]: e.target.value });
    };



    const handleAddTypecate = async (e) => {
        e.preventDefault();

        const formData = new FormData();
        formData.append("characteristic_id", newTypecate.characteristic_id);
        formData.append("name", newTypecate.name);
        formData.append("content", newTypecate.content);

        if (newTypecate.imageFile) {
            formData.append("image", newTypecate.imageFile);
        }

        try {
            await axios.post("http://localhost:3000/adminc/typecate", formData, {
                headers: {
                    "Content-Type": "multipart/form-data"
                }
            });
            alert("Thêm thành công!");
            setNewTypecate({
                characteristic_id: "",
                name: "",
                imageFile: null,
                content: "",
            });
            fetchTypecate();
            setShowAddForm(false);
        } catch (error) {
            console.error("Lỗi khi thêm:", error.response?.data || error.message);
        }
    };



    const handleEdit = (typecate) => {
        setEditTypecate(typecate);
    };

    const handleChange = (e) => {
        setEditTypecate({ ...editTypecate, [e.target.name]: e.target.value });
    };

    const handleSave = async (e) => {
        e.preventDefault();
        const formData = new FormData();
        formData.append("name", editTypecate.name);
        formData.append("content", editTypecate.content);
        formData.append("characteristic_id", editTypecate.characteristic_id || "");
        formData.append("create_at", new Date().toISOString());
        if (editTypecate.imageFile) {
            formData.append("image", editTypecate.imageFile);
        }

        try {
            const res = await axios.put(`http://localhost:3000/adminc/typecate/${editTypecate.id}`, formData, {
                headers: { "Content-Type": "multipart/form-data" },
            });
            alert(res.data.message);
            setEditTypecate(null);
            fetchTypecate();
        } catch (err) {
            console.error("Lỗi khi cập nhật:", err);
            alert("Cập nhật thất bại!");
        }
    };


    const handlePageChange = ({ selected }) => {
        setCurrentPage(selected);
    };

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (editTypecate) {
            setEditTypecate({ ...editTypecate, imageFile: file });
        } else {
            setNewTypecate({ ...newTypecate, imageFile: file });
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
                        <h2>Quản Lý Loại Cây</h2>
                        <button className="buttonAdd" onClick={() => setShowAddForm(true)}>Thêm Loại Cây</button>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên Loại Cây</th>
                                <th>Đặc Điểm</th>
                                <th>Ảnh</th>
                                <th>Content</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {typecate?.map((item, index) => (
                                <tr key={item.id || index}>
                                    <td>{item.id}</td>
                                    <td>{item.name}</td>
                                    <td>{item.characteristic_name || "Không có đặc điểm"}</td>
                                    <td>
                                        <img
                                            src={
                                                item.image?.startsWith("../../public/images")
                                                  ? `http://localhost:3000/public/${item.image.replace("../../public/", "")}`
                                                  : item.image
                                              }
                                            alt={item.name}
                                            width="80"
                                        />
                                    </td>
                                    <td width={'350px'}>{item.content}</td>
                                    <td>
                                        <button onClick={() => handleEdit(item)}>Sửa</button>
                                        <button className="btn-delete" onClick={() => handleDelete(item.id)}>Xóa</button>

                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                    {totalItems > itemsPerPage && (
                        <div className="paginationContainer">
                            <ReactPaginate
                                breakLabel="⋯"
                                nextLabel=">"
                                previousLabel="<"
                                onPageChange={handlePageChange}
                                pageRangeDisplayed={2}
                                marginPagesDisplayed={1}
                                pageCount={Math.ceil(totalItems / itemsPerPage)}
                                containerClassName="pagination"
                                pageClassName="pageItem"
                                pageLinkClassName="pageLink"
                                previousClassName="pageItem"
                                previousLinkClassName="pageLink previousLink"
                                nextClassName="pageItem"
                                nextLinkClassName="pageLink nextLink"
                                activeClassName="active"
                                breakClassName="breakItem"
                                forcePage={currentPage}
                            />
                        </div>
                    )}

                    {editTypecate && (
                        <>
                            <div className="modal-overlay" onClick={() => setEditTypecate(null)}></div>
                            <div className="modal-container">
                                <span className="modal-close-btn" onClick={() => setEditTypecate(null)}>&times;</span>
                                <h3>Sửa Loại Cây</h3>
                                <form onSubmit={handleSave}>
                                    <label>Tên:</label>
                                    <input
                                        type="text"
                                        name="name"
                                        value={editTypecate.name}
                                        onChange={handleChange}
                                        required
                                    />

                                    <label>Ảnh:</label>
                                    <input type="file" name="image" accept="image/*" onChange={handleImageChange} />
                                    {editTypecate.image && (
                                        <img
                                        src={
                                            typeof editTypecate.image === "string"
                                              ? `http://localhost:3000/public/${editTypecate.image}`
                                              : URL.createObjectURL(editTypecate.image) // Nếu là File object
                                          }
                                        alt="preview"
                                        width="100"
                                    />
                                    )}

                                    <label>Content:</label>
                                    <textarea
                                        name="content"
                                        value={editTypecate.content}
                                        onChange={handleChange}
                                        required
                                    ></textarea>

                                    <button type="submit">Lưu</button>
                                    <button type="button" className="cancel-btn" onClick={() => setEditTypecate(null)}>
                                        Hủy
                                    </button>
                                </form>
                            </div>
                        </>
                    )}

                    {showAddForm && (
                        <>
                            <div className="modal-overlay" onClick={() => setShowAddForm(false)}></div>
                            <div className="modal-container">
                                <span className="modal-close-btn" onClick={() => setShowAddForm(false)}>&times;</span>
                                <h3>Thêm Loại Cây</h3>
                                <form onSubmit={handleAddTypecate}>
                                    <label>Đặc Điểm:</label>
                                    <select
                                        name="characteristic_id"
                                        value={newTypecate.characteristic_id}
                                        onChange={handleNewTypecateChange}
                                        required
                                    >
                                        <option value="">-- Chọn đặc điểm --</option>
                                        {characteristic.map((charac) => (
                                            <option key={charac.id} value={charac.id}>
                                                {charac.name}
                                            </option>
                                        ))}
                                    </select>

                                    <label>Tên:</label>
                                    <input
                                        type="text"
                                        name="name"
                                        value={newTypecate.name}
                                        onChange={handleNewTypecateChange}
                                        required
                                    />

                                    <label>Ảnh:</label>
                                    <input type="file" name="image" accept="image/*" onChange={handleImageChange} />
                                    {newTypecate.imageFile && (
                                        <img src={URL.createObjectURL(newTypecate.imageFile)} alt="preview" width="100" />
                                    )}

                                    <label>Content:</label>
                                    <input
                                        type="text"
                                        name="content"
                                        value={newTypecate.content}
                                        onChange={handleNewTypecateChange}
                                        required
                                    />

                                    <button type="submit">Lưu</button>
                                    <button type="button" className="cancel-btn" onClick={() => setShowAddForm(false)}>
                                        Hủy
                                    </button>
                                </form>
                            </div>
                        </>
                    )}


                </div>

            </div>

        </div>

    );
};

export default AdminTypecate;
