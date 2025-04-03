import React, { useState, useEffect } from "react";
import { Menu, Search } from "lucide-react";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";


const AdminComment = () => {
    const [comment, setcomment] = useState([]);

    useEffect(() => {
        fetchcomment();
    }, []);

    const fetchcomment = async () => {
        try {
            const response = await axios.get("http://localhost:3000/admin/comment");
            setcomment(response.data);
        } catch (error) {
            console.error("Lỗi khi lấy dữ liệu bình luận:", error);
        }
    };

    const handleToggleStatus = async (id, currentStatus) => {
        try {
            const newStatus = currentStatus === 1 ? 0 : 1;
            await axios.put(`http://localhost:3000/admin/comment/${id}/status`, { status: newStatus });
            fetchcomment();
        } catch (error) {
            console.error("Lỗi khi cập nhật trạng thái bình luận:", error);
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
                        <h2>Quản Lý Bình Luận</h2>
                    </div>
                    <table className="comment-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người Dùng</th>
                                <th>Sản Phẩm</th>
                                <th>Nội dung</th>
                                <th>Ngày bình luận</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {comment.map((comment) => (
                                <tr key={comment.id}>
                                    <td>{comment.id}</td>
                                    <td>{comment.user_name}</td>
                                    <td>{comment.product_name}</td>
                                    <td>{comment.content}</td>
                                    <td>{comment.comment_date}</td>
                                    <td>{comment.status === 1 ? "Hiện" : "Ẩn"}</td>
                                    <td>
                                        <button
                                            className={comment.status === 1 ? "btn-show" : "btn-hide"}
                                            
                                            onClick={() => handleToggleStatus(comment.id, comment.status)}
                                            
                                        >
                                            {comment.status === 1 ? "Ẩn" : "Hiện"}
                                        </button>
                                        


                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default AdminComment;
