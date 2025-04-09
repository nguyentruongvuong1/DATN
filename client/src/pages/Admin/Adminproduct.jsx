import React, { useState, useEffect } from "react";
import ReactPaginate from "react-paginate";
import { Menu, Search } from "lucide-react";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";
import moment from "moment";
import { useNavigate } from "react-router-dom";
const AdminProduct = () => {
    const navigate = useNavigate();
    const [products, setProducts] = useState([]);
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage] = useState(8); // Số sản phẩm mỗi trang
    const [totalProducts, setTotalProducts] = useState(0);


    useEffect(() => {
        const fetchData = async () => {
            try {
                const products = await fetch(
                    `${import.meta.env.VITE_API_URL}/adminpr/products?page=${currentPage}&limit=${itemsPerPage}`
                );
                const response = await products.json();
                setProducts(response.products || response);
                setTotalProducts(response.total || response.length);
            } catch (error) {
                console.error("Lỗi khi tải sản phẩm:", error);
            }
        };
        fetchData();
    }, [currentPage, itemsPerPage]);


    const handlePageChange = (page) => {
        setCurrentPage(Math.max(1, page)); // Đảm bảo trang nhỏ nhất là 1
    };

    const handleDelete = async (id) => {
        if (!window.confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) return;
            { 
            try{
                   await axios.delete(`${import.meta.env.VITE_API_URL}/adminpr/product/${id}`);
                   alert("Xóa sản phẩm thành công!");
                     setProducts(products.filter(product => product.id !== id));
            }catch (error) {
                console.error("Lỗi khi xóa sản phẩm:", error);
            }
           }
        }





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
                        <h2>Danh sách sản phẩm</h2>
                        <button className="buttonAdd" onClick={() => navigate('/admin/addsp') }>Thêm Sản Phẩm</button>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Hình ảnh</th>
                                <th>Tên</th>
                                <th>Danh mục</th>
                                {/* <th>Đặc điểm</th>
                                <th>Thể loại</th> */}
                                <th>Giá</th>
                                <th>Giảm giá</th>
                                <th>Giá sau giảm</th>
                                <th>Mô tả</th>
                                <th>Số lượng</th>
                                <th>Lượt xem</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {products && products.length > 0 ? (
                                products.map((product, index) => (
                                    <tr key={`${product.id}-${index}`}>
                                        <td>{product.id}</td>
                                        <td>
                                            <img src={product.images?.split(',')[0]} alt={product.name} style={{ width: "50px", height: "50px", objectFit: "cover" }} />
                                        </td>
                                        <td>{product.name}</td>

                                        <td>{product.category_name}</td>
                                        {/* <td>{product.characteristic_name || "Không có"}</td>
                                        <td>{product.type_name || "Không có"}</td> */}
                                        <td>{product.price}</td>
                                        <td>{product.sale}</td>
                                        <td>{product.price_sale}</td>
                                   
                                        <td>{product.discription?.length > 30 ? product.discription.slice(0, 30) + '...' : product.discription}</td>
                                        <td>{product.inventory_quantity}</td>
                                        <td>{product.view}</td>
                                        <td>{moment(product.create_date).format('DD-MM-YYYY')}</td>
                                        <td>
                                            <button onClick={() => {}}>Sửa</button>
                                            <button onClick={() => handleDelete(product.id)}>Xóa</button>
                                        </td>
                                    </tr>
                                ))
                            ) : (
                                <tr>
                                    <td colSpan="12" style={{ textAlign: "center" }}>Không có sản phẩm nào</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                    {totalProducts > itemsPerPage && (
                        <div className="paginationContainer">
                            <ReactPaginate
                                breakLabel="⋯"
                                nextLabel=">"
                                previousLabel="<"
                                onPageChange={(selectedItem) => handlePageChange(selectedItem.selected + 1)}
                                pageRangeDisplayed={2}
                                marginPagesDisplayed={1}
                                pageCount={Math.ceil(totalProducts / itemsPerPage)}
                                containerClassName="pagination"
                                pageClassName="pageItem"
                                pageLinkClassName="pageLink"
                                previousClassName="pageItem"
                                previousLinkClassName="pageLink previousLink"
                                nextClassName="pageItem"
                                nextLinkClassName="pageLink nextLink"
                                activeClassName="active"
                                breakClassName="breakItem"
                                forcePage={Math.min(Math.max(0, currentPage - 1), Math.ceil(totalProducts / itemsPerPage) - 1)}
                            />
                        </div>
                    )}

                   
                </div>
            </div>
        </div>
    );
};

export default AdminProduct;
