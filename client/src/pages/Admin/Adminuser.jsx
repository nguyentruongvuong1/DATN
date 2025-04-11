import React, { useState, useEffect } from "react";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";
import ReactPaginate from "react-paginate";
import { Search } from "lucide-react";


const AdminUser = () => {
    const [users, setUsers] = useState([]);
    const [allUs, setallUs] = useState([]); // Tất cả để tìm kiếm
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage] = useState(8);
    const [totalUsers, setTotalUsers] = useState(0);
    const [search, setsearch] = useState(''); // Trạng thái tìm kiếm
    const [usfilter, ganusfilter] = useState([]) // Trạng thái tìm kiếm
    const [sortOrder, setSortOrder] = useState("asc"); // Trạng thái sắp xếp (tăng dần hoặc giảm dần)



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
            setallUs(data.users || []); // gán allUs với dữ liệu users
        } catch (error) {
            console.error("Lỗi khi lấy dữ liệu:", error);
        }
    };

    const onchangeSearch = (e) => {
        setsearch(e.target.value)
    }

    useEffect(() => {
        if (search === '') {
            ganusfilter(users)
        } else {
            const FilterUs = allUs.filter(us => us.username.toLowerCase().includes(search.toLowerCase()))
            ganusfilter(FilterUs)
        }

    }, [search, allUs, users])



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

    const handleSort = () => {
        const sortedUser = [...users]; // Tạo một bản sao của mảng vouchers để không làm thay đổi mảng gốc
        if (sortOrder === "asc") {
            sortedUser.sort((a, b) => a.id - b.id); // Sắp xếp tăng dần
            setSortOrder("desc");
        } else {
            sortedUser.sort((a, b) => b.id - a.id); // Sắp xếp giảm dần
            setSortOrder("asc");
        }
        setUsers(sortedUser); // Cập nhật lại vouchers với thứ tự đã sắp xếp
    };


    return (
        <div className="main">
            <div className="topbar">
                <div className="toggle">
                    <ion-icon name="menu-outline"></ion-icon>
                </div>
                <div className="search">
                    <input
                        type="text"
                        value={search}
                        onChange={onchangeSearch} placeholder="Tìm kiếm..."

                    />
                    <Search size={24} />
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
                                <th onClick={handleSort} style={{ cursor: "pointer" }}>
                                    ID {sortOrder === "asc" ? "↑" : "↓"}
                                </th>
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
                            {usfilter.map((user) => (
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
