import React, { useState, useEffect } from "react";
import { Menu, Search, Eye } from "lucide-react";
import ReactPaginate from "react-paginate";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";
import { Link } from "react-router-dom";
import moment from "moment";
// import { useNavigate } from "react-router-dom";


const AdminReviews = () => {
    const [reviews, setReviews] = useState([]);
    const [allRv, setallRv] = useState([]); // Tất cả để tìm kiếm
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage] = useState(8);
    const [totalReviews, setTotalReviews] = useState(0);
    const [sortOrder, setSortOrder] = useState("asc"); // Trạng thái sắp xếp (tăng dần hoặc giảm dần)
    const [search, setsearch] = useState(''); // Trạng thái tìm kiếm
    const [rvfilter, ganrvfilter] = useState([]) // Trạng thái tìm kiếm

    // const navigate = useNavigate();
    // const handleViewReview = (productId) => {
    //     navigate(`/chi_tiet_san_pham/${productId}`);
    // };

    useEffect(() => {
        fetchReviews();

    }, [currentPage]);

    const fetchReviews = async () => {
        try {
            const response = await axios.get(`${import.meta.env.VITE_API_URL}/admin/reviews?page=${currentPage}&limit=${itemsPerPage}`);
            setReviews(response.data.comments || response.data);
            setTotalReviews(response.data.total || response.data.length);
            setallRv(response.data.comments || response.data); // gán allRv với dữ liệu reviews
            console.log(response.data);

        } catch (error) {
            console.error("Lỗi khi lấy dữ liệu bình luận:", error);
        }
    };

    const onchangeSearch = (e) => {
        setsearch(e.target.value)
    }

    useEffect(() => {
        if (search === '') {
            ganrvfilter(reviews)
        } else {
            const FilterRv = allRv.filter(rv => rv.user_name.toLowerCase().includes(search.toLowerCase()))
            ganrvfilter(FilterRv)
        }

    }, [search, allRv, reviews])


    const handlePageChange = (selectedItem) => {
        setCurrentPage(selectedItem.selected + 1);
    };

    const handleSort = () => {
        const sortedReview = [...reviews]; // Tạo một bản sao của mảng vouchers để không làm thay đổi mảng gốc
        if (sortOrder === "asc") {
            sortedReview.sort((a, b) => a.id - b.id); // Sắp xếp tăng dần
            setSortOrder("desc");
        } else {
            sortedReview.sort((a, b) => b.id - a.id); // Sắp xếp giảm dần
            setSortOrder("asc");
        }
        setReviews(sortedReview); // Cập nhật lại vouchers với thứ tự đã sắp xếp
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
                            value={search}
                            onChange={onchangeSearch} placeholder="Tìm kiếm..."

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
                        <h2>Quản Lý Đánh Giá</h2>
                    </div>
                    <table className="comment-table">
                        <thead>
                            <tr>
                                <th onClick={handleSort} style={{ cursor: "pointer" }}>
                                    ID {sortOrder === "asc" ? "↑" : "↓"}
                                </th>
                                <th>Người Dùng</th>
                                <th>Sản Phẩm</th>
                                <th>Nội dung</th>
                                <th>Số Sao</th>
                                <th>Ngày bình luận</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {rvfilter.map((review) => (
                                <tr key={review.id}>
                                    <td>{review.id}</td>
                                    <td>{review.user_name}</td>
                                    <td>{review.product_name.length > 20 ? review.product_name.slice(0, 20) + '...' : review.product_name}</td>
                                    <td width={'200px'}>{review.content}</td>
                                    <td>{review.start}</td>
                                    <td>{moment(review.create_date).format(' DD-MM-YYYY')}</td>
                                    <td>
                                        <button className="xemdanhgia" >
                                            <Link to={`/chi_tiet_san_pham/${review.pr_id}`} >
                                                Xem đánh giá
                                            </Link>
                                        </button>                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                    {totalReviews > itemsPerPage && (
                        <div className="paginationContainer">
                            <ReactPaginate
                                breakLabel="⋯"
                                nextLabel=">"
                                previousLabel="<"
                                onPageChange={handlePageChange}
                                pageRangeDisplayed={2}
                                marginPagesDisplayed={1}
                                pageCount={Math.ceil(totalReviews / itemsPerPage)}
                                containerClassName="pagination"
                                pageClassName="pageItem"
                                pageLinkClassName="pageLink"
                                previousClassName="pageItem"
                                previousLinkClassName="pageLink previousLink"
                                nextClassName="pageItem"
                                nextLinkClassName="pageLink nextLink"
                                activeClassName="active"
                                breakClassName="breakItem"
                                forcePage={Math.min(Math.max(0, currentPage - 1), Math.ceil(totalReviews / itemsPerPage) - 1)}
                            />
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default AdminReviews;
