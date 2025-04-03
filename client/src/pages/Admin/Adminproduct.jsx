import React, { useState, useEffect } from "react";
import ReactPaginate from "react-paginate";
import { Menu, Search } from "lucide-react";
import axios from "axios";
import "../../styles/Admin/styleadmin.css";


const AdminProduct = () => {
    const [products, setProducts] = useState([]);
    const [formData, setFormData] = useState({});
    const [showForm, setShowForm] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [itemsPerPage] = useState(8); // Số sản phẩm mỗi trang
    const [totalProducts, setTotalProducts] = useState(0);
    const [isEdit, setIsEdit] = useState(false);
    const [categories, setCategories] = useState([]);
    const [characteristic, setCharacteristics] = useState([]);
    const [typecate, setTypecates] = useState([]);
    const [filteredTypecate, setFilteredTypecate] = useState([]);


    useEffect(() => {
        const fetchData = async () => {
            try {
                const products = await fetch(
                    `http://localhost:3000/admin/products?page=${currentPage}&limit=${itemsPerPage}`
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

    useEffect(() => {
        const fetchData = async () => {
            try {
                const [categoriesRes, characteristicsRes, typecatesRes] = await Promise.all([
                    axios.get("http://localhost:3000/admin/cate"),
                    axios.get("http://localhost:3000/admin/characteristic"),
                    axios.get("http://localhost:3000/admin/typecate")
                ]);

                setCategories(categoriesRes.data);
                setCharacteristics(characteristicsRes.data);
                setTypecates(typecatesRes.data);

            } catch (error) {
                console.error("Lỗi khi lấy dữ liệu danh mục:", error);
            }
        };
        fetchData();
    }, []);

    useEffect(() => {
        console.log("Danh mục được chọn (category_id):", formData?.category_id);
        console.log("Danh sách thể loại ban đầu:", typecate);
    
        if (formData?.category_id) {
            const relatedTypecate = typecate.filter(tc => Number(tc.cate_id) === Number(formData.category_id));
            console.log("Danh sách thể loại đã lọc:", relatedTypecate);
            setFilteredTypecate(relatedTypecate);
        } else {
            setFilteredTypecate([]); // Nếu chưa chọn danh mục, reset danh sách thể loại
        }
    }, [formData?.category_id, typecate]);
    



    const handleSave = async (e) => {
        e.preventDefault();
        try {
            if (isEdit) {
                await axios.put(`http://localhost:3000/admin/product/${formData.id}`, formData);
            } else {
                await axios.post("http://localhost:3000/admin/product", formData);
            }
            setShowForm(false);
        } catch (error) {
            console.error("Lỗi khi lưu sản phẩm:", error);
        }
    };

    const handlePageChange = (page) => {
        setCurrentPage(Math.max(1, page)); // Đảm bảo trang nhỏ nhất là 1
    };

    const handleDelete = async (id) => {
        if (window.confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
            try {
                await axios.delete(`http://localhost:3000/admin/product/${id}`);
                setProducts(products.filter(product => product.id !== id));
            } catch (error) {
                console.error("Lỗi khi xóa sản phẩm:", error);
            }
        }
    };

    const handleCategoryChange = (e) => {
        const categoryId = e.target.value ? Number(e.target.value) : null;
        console.log("Danh mục được chọn (category_id):", categoryId);

        setFormData(prevData => ({
            ...prevData,
            category_id: categoryId,
            type_id: "",  // Reset type_id khi đổi danh mục
        }));
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
                        <h2>Danh sách sản phẩm</h2>
                        <button className="buttonAdd" onClick={() => { setShowForm(true); setIsEdit(false); setFormData({ code: '', discount_type: 'fixed', discount_value: 0, quantity: 1, end_date: '', status: 1 }); }}>Thêm Voucher</button>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Danh mục</th>
                                <th>Đặc điểm</th>
                                <th>Thể loại</th>
                                <th>Tên</th>
                                <th>Giá</th>
                                <th>Giảm giá</th>
                                <th>Giá sau giảm</th>
                                <th>Hình ảnh</th>
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
                                        <td>{product.category_name}</td>
                                        <td>{product.characteristic_name || "Không có"}</td>
                                        <td>{product.type_name || "Không có"}</td>
                                        <td>{product.name}</td>
                                        <td>{product.price}</td>
                                        <td>{product.sale}</td>
                                        <td>{product.price_sale}</td>
                                        <td>
                                            <img src={product.images?.split(',')[0]} alt={product.name} style={{ width: "50px", height: "50px", objectFit: "cover" }} />
                                        </td>
                                        <td>{product.discription?.length > 30 ? product.discription.slice(0, 30) + '...' : product.discription}</td>
                                        <td>{product.inventory_quantity}</td>
                                        <td>{product.view}</td>
                                        <td>{product.create_date}</td>
                                        <td>
                                            <button onClick={() => { setShowForm(true); setIsEdit(true); setFormData(product); }}>Sửa</button>
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
                    {showForm && (
                        <div className="modal-overlay" onClick={(e) => {
                            if (e.target.classList.contains("modal-overlay")) {
                                setShowForm(false);
                            }
                        }}>
                            <div className="modal-container">
                                <h3>{isEdit ? "Sửa" : "Thêm"} Sản phẩm</h3>
                                <form onSubmit={handleSave}>
                                    <label>Tên sản phẩm:</label>
                                    <input type="text" value={formData.name || ""} onChange={(e) => setFormData({ ...formData, name: e.target.value })} required />

                                    <label>Danh mục:</label>
                                    <select
                                        value={formData?.category_id || ""}
                                        onChange={handleCategoryChange}
                                        required
                                    >
                                        <option value="">Chọn danh mục</option>
                                        {categories.map(cat => (
                                            <option key={cat.id} value={cat.id}>{cat.name}</option>
                                        ))}
                                    </select>


                                    <label>Đặc điểm:</label>
                                    <select
                                        value={formData.characteristic_id || ""} // Hiển thị giá trị characteristic_id đã chọn
                                        onChange={(e) => {
                                            const characteristicId = e.target.value;
                                            console.log("Đặc điểm được chọn:", characteristicId);
                                            setFormData({ ...formData, characteristic_id: characteristicId, type_id: "" }); // Cập nhật formData khi chọn đặc điểm
                                        }}
                                        disabled={!formData.category_id} // Vô hiệu hóa dropdown nếu chưa chọn danh mục
                                    >
                                        <option value="">Chọn đặc điểm</option>
                                        {characteristic
                                            .filter(item => item.cate_name === categories.find(cat => cat.id === formData.category_id)?.name)
                                            .map(item => (
                                                <option key={item.id} value={item.id}>
                                                    {item.name}
                                                </option>
                                            ))}
                                    </select>

                                    <label>Thể loại:</label>
                                    <select
                                        value={formData?.type_id || ""}
                                        onChange={(e) => setFormData({ ...formData, type_id: e.target.value })}
                                        disabled={!formData?.category_id}
                                    >
                                        <option value="">Chọn thể loại</option>
                                        {filteredTypecate.map(item => (
                                            <option key={item.id} value={item.id}>{item.name}</option>
                                        ))}
                                    </select>


                                    <label>Giá:</label>
                                    <input type="number" value={formData.price || ""} onChange={(e) => setFormData({ ...formData, price: e.target.value })} required />

                                    <button type="submit">Lưu</button>
                                    <button type="button" className="cancel-btn" onClick={() => setShowForm(false)}>Hủy</button>
                                </form>
                            </div>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default AdminProduct;
