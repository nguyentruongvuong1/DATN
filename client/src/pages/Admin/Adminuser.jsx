import React, { useState, useEffect } from "react";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";
import ReactPaginate from "react-paginate";

const AdminUser = () => {
    const [users, setUsers] = useState([]);
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage] = useState(8);
    const [totalUsers, setTotalUsers] = useState(0);

    useEffect(() => {
        fetchUsers();
    }, [currentPage, itemsPerPage]);

    const fetchUsers = async () => {
        try {
            const { data } = await axios.get(
                `${import.meta.env.VITE_API_URL}/admin/users?page=${currentPage}&limit=${itemsPerPage}`
            );
            setUsers(data.users || []);
            setTotalUsers(data.total || 0);
        } catch (error) {
            console.error("Lỗi khi lấy dữ liệu:", error);
        }
    };





    const handlePageChange = (selectedItem) => {
        setCurrentPage(selectedItem.selected + 1);
    };
    
    const handleStatusChange = async (userId, newStatus) => {
        try {
            await axios.put(`${import.meta.env.VITE_API_URL}/admin/user/${userId}`, { status: newStatus });
            // Cập nhật lại danh sách người dùng
            fetchUsers();
        } catch (error) {
            console.error("Lỗi khi cập nhật trạng thái người dùng:", error);
        }
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
                        <h2>Quản Lý Người Dùng</h2>

                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên đăng nhập</th>
                                <th>Tên</th>
                                <th>Điện thoại</th>
                                <th>Email</th>
                                <th>Địa chỉ</th>
                                <th>Số lượng đã mua</th>
                                <th>Tổng tiền đã mua</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Avatar</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {users.map((user) => (
                                <tr key={user.id}>
                                    <td>{user.id}</td>
                                    <td>{user.username}</td>
                                    <td>{user.name}</td>
                                    <td>{user.phone}</td>
                                    <td>{user.email}</td>
                                    <td>{user.address}</td>
                                    <td>{user.quantity_pr_buy}</td>
                                    <td>{user.total_buy}</td>
                                    <td>{user.role === 1 ? "Người dùng" : "Admin"}</td>
                                    <td>
                                        <select
                                            className={`status-select ${user.status === 2 ? 'locked' : 'active'}`}
                                            value={user.status}
                                            onChange={(e) => handleStatusChange(user.id, parseInt(e.target.value))}
                                        >
                                            <option value={1}>Bình thường</option>
                                            <option value={2}>Khóa</option>
                                        </select>
                                    </td>
                                    <td>{user.create_date}</td>
                                    <td><img src={user.avatar} alt="avatar" width={40} /></td>

                                </tr>
                            ))}
                        </tbody>
                    </table>
                    {totalUsers > itemsPerPage && (
                        <div className="paginationContainer">
                            <ReactPaginate
                                breakLabel="⋯"
                                nextLabel=">"
                                previousLabel="<"
                                onPageChange={handlePageChange}
                                pageRangeDisplayed={2}
                                marginPagesDisplayed={1}
                                pageCount={Math.ceil(totalUsers / itemsPerPage)}
                                containerClassName="pagination"
                                pageClassName="pageItem"
                                pageLinkClassName="pageLink"
                                previousClassName="pageItem"
                                previousLinkClassName="pageLink previousLink"
                                nextClassName="pageItem"
                                nextLinkClassName="pageLink nextLink"
                                activeClassName="active"
                                breakClassName="breakItem"
                                forcePage={Math.min(Math.max(0, currentPage - 1), Math.ceil(totalUsers / itemsPerPage) - 1)}
                            />
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default AdminUser;
