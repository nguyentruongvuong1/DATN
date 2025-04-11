import React, { useState, useEffect } from "react";
import axios from "axios";
import ReactPaginate from "react-paginate";
import "../../styles/Admin/styleadmin.css";

const AdminBlog = () => {
    const [blogs, setBlogs] = useState([]);
    const [formData, setFormData] = useState({
        title: "",
        content: "",
        description: "",
        logo: "",
    });
    const [showForm, setShowForm] = useState(false);
    const [isEdit, setIsEdit] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage] = useState(8);
    const [totalBlogs, setTotalBlogs] = useState(0);

    useEffect(() => {
        fetchBlogs();
    }, [currentPage]);

    const fetchBlogs = async () => {
        try {
            const response = await axios.get(
                `${import.meta.env.VITE_API_URL}/blog?page=${currentPage}&limit=${itemsPerPage}`
            );
            setBlogs(response.data.data);
            setTotalBlogs(response.data.total);
        } catch (error) {
            console.error("Lỗi khi tải blog:", error);
        }
    };

    const handleDelete = async (id) => {
        if (!window.confirm("Bạn có chắc muốn xóa blog này không?")) return;
        try {
            await axios.delete(`${import.meta.env.VITE_API_URL}/blog/${id}`);
            fetchBlogs();
        } catch (error) {
            console.error("Lỗi khi xóa blog:", error);
        }
    };

    const handleSave = async (e) => {
        e.preventDefault();
        try {
            const payload = {
                title: formData.title,
                content: formData.content,
                description: formData.description,
                logo: formData.logo, // chỉ là URL
            };

            if (isEdit) {
                await axios.put(
                    `${import.meta.env.VITE_API_URL}/blog/${formData.id}`,
                    payload
                );
            } else {
                await axios.post(`${import.meta.env.VITE_API_URL}/blog/create`, payload);
            }

            fetchBlogs();
            setShowForm(false);
        } catch (error) {
            console.error("Lỗi khi lưu blog:", error);
        }
    };

    const handlePageChange = (selectedItem) => {
        setCurrentPage(selectedItem.selected + 1);
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
                        <h2>Quản Lý Tin tức</h2>
                        <button
                            className="buttonAdd"
                            onClick={() => {
                                setShowForm(true);
                                setIsEdit(false);
                                setFormData({
                                    title: "",
                                    content: "",
                                    description: "",
                                    logo: "",
                                });
                            }}
                        >
                            Thêm tin tức
                        </button>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tiêu đề</th>
                                <th>Mô tả</th>
                                <th>Nội dung</th>
                                <th>Logo</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {blogs.map((blog) => (
                                <tr key={blog.id}>
                                    <td>{blog.id}</td>
                                    <td>{blog.title}</td>
                                    <td>Cây xanh đóng vai trò vô cùng quan trọng trong việc bảo vệ môi trường và nâng cao chất lượng sống của con người</td>
                                    <td>{blog.content}</td>
                                    <td>
                                        <img
                                            src={blog.logo}
                                            alt="Logo"
                                            style={{ width: "100px" }}
                                        />
                                    </td>
                                    <td>{blog.create_date}</td>
                                    <td>
                                        <button
                                            onClick={() => {
                                                setShowForm(true);
                                                setIsEdit(true);
                                                setFormData(blog);
                                            }}
                                        >
                                            Sửa
                                        </button>
                                        <button onClick={() => handleDelete(blog.id)}>Xóa</button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>

                    {totalBlogs > itemsPerPage && (
                        <div className="paginationContainer">
                            <ReactPaginate
                                breakLabel="⋯"
                                nextLabel=">"
                                previousLabel="<"
                                onPageChange={handlePageChange}
                                pageRangeDisplayed={2}
                                marginPagesDisplayed={1}
                                pageCount={Math.ceil(totalBlogs / itemsPerPage)}
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
                                    Math.ceil(totalBlogs / itemsPerPage) - 1
                                )}
                            />
                        </div>
                    )}

                    {showForm && (
                        <>
                            <div
                                className="modal-overlay"
                                onClick={() => setShowForm(false)}
                            ></div>
                            <div className="modal-container">
                                <h3>{isEdit ? "Sửa" : "Thêm"} Blog</h3>
                                <form onSubmit={handleSave}>
                                    <label>Tiêu đề:</label>
                                    <input
                                        type="text"
                                        value={formData.title}
                                        onChange={(e) =>
                                            setFormData({ ...formData, title: e.target.value })
                                        }
                                        required
                                    />

                                    <label>Mô tả:</label>
                                    <textarea
                                        value={formData.description}
                                        onChange={(e) =>
                                            setFormData({ ...formData, description: e.target.value })
                                        }
                                        required
                                    ></textarea>

                                    <label>Nội dung:</label>
                                    <textarea
                                        value={formData.content}
                                        onChange={(e) =>
                                            setFormData({ ...formData, content: e.target.value })
                                        }
                                        required
                                    ></textarea>

                                    <label>Logo (URL):</label>
                                    <input
                                        type="text"
                                        value={formData.logo || ""}
                                        onChange={(e) =>
                                            setFormData({ ...formData, logo: e.target.value })
                                        }
                                    />
                                    {formData.logo && (
                                        <img
                                            src={formData.logo}
                                            alt="Preview"
                                            style={{ width: "150px", marginTop: "10px" }}
                                        />
                                    )}

                                    <button type="submit">Lưu</button>
                                    <button
                                        type="button"
                                        className="cancel-btn"
                                        onClick={() => setShowForm(false)}
                                    >
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

export default AdminBlog;
