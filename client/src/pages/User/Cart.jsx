import styles from"../../styles/User/cart.module.css";
import { useSelector } from "react-redux";
import { useDispatch } from "react-redux";
import { SuaSL, XoaPr, XoaGH } from "../../CartSlice";
import { Link } from "react-router-dom";
import "@ant-design/v5-patch-for-react-19";
import { message, Modal } from "antd";
import { useEffect, useState } from "react";
import axios from "axios";

export default function Cart() {
  const dispatch = useDispatch();
  const cart = useSelector((state) => state.cart.listPr);
  const [modal, contextHolder] = Modal.useModal();
  const shippingFee = 50000;
  const Tongtien = cart.reduce((tong, pr) => {
    return tong + pr.so_luong * pr.price;
  }, 0);
  const handleKeyPress = (event) => {
    // Chỉ cho phép nhập số dương và phím Backspace
    const charCode = event.which ? event.which : event.keyCode;
    if (charCode <= 31 || (charCode >= 48 && charCode <= 57)) {
      return true;
    } else {
      event.preventDefault();
      return false;
    }
  };

  const handleBlur = (event, id, maxQuantity) => {
    let value = parseInt(event.target.value) || 1;
    if (value <= 0) {
      value = 1;
    } else if (value > maxQuantity) {
      value = maxQuantity;
      message.warning(`Số lượng tối đa có thể mua là ${maxQuantity}`);
    }
    event.target.value = value;
    dispatch(SuaSL([id, value]));
  };

  const XoaAllCart = () => {
    modal.confirm({
      title: (
        <span style={{ fontSize: "18px", fontWeight: "500" }}>
          Xác nhận xóa giỏ hàng
        </span>
      ),
      content: (
        <div style={{ margin: "16px 0" }}>
          Bạn có chắc muốn xóa tất cả sản phẩm trong giỏ hàng?
        </div>
      ),
      okText: "Xóa",
      cancelText: "Hủy",
      okButtonProps: {
        danger: true,
        style: {
          width: "80px",
          height: "36px",
          borderRadius: "4px",
        },
      },
      cancelButtonProps: {
        style: {
          width: "80px",
          height: "36px",
          borderRadius: "4px",
        },
      },
      centered: true,
      styles: {
        footer: {
          display: "flex",
          justifyContent: "center",
          gap: "16px",
          padding: "16px 0 8px",
        },
      },
      onOk: () => {
        dispatch(XoaGH());
        message.success(
          "Bạn đã xóa toàn bộ sản phẩm trong giỏ hàng thành công"
        );
      },
    });
  };

  const [VoucherCode, setVoucherCode] = useState("");
  const [Discount, setDiscount] = useState(0);
  const [DiscountType, setDiscountType] = useState("");
  const [FinalTotal, setFinalTotal] = useState(0);


  useEffect(() =>{
    let total = Tongtien + shippingFee;
    if(Discount >0){
      total = DiscountType === 'fixed' ? total - Discount : total -(total * Discount) / 100;
    }
    setFinalTotal(Math.max(0, total));
  }, [Tongtien, Discount, DiscountType]);


  const applyVoucher = async () => {
    try {
      const res = await axios.post(`${import.meta.env.VITE_API_URL}/checkvoucher`, 
        { code: VoucherCode });
      const { discount_type, discount_value } = res.data;

      setDiscountType(discount_type);
      setDiscount(discount_value);
      message.success("Voucher áp dụng thành công!");
      
    } catch (error) {
      alert(error.response?.data?.message || "Có lỗi xảy ra");
    }
  };

  return cart && cart.length > 0 ? (
    <div className={styles.bggiohang}>
      <h2 className={styles.title}>GIỎ HÀNG CỦA BẠN</h2>
      <div className={styles.container}>
        <div className={styles.cart}>
          <table className={styles.cart_table}>
            <thead>
              <tr>
                <th>Ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {cart.map((pr, index) => (
                <tr key={index}>
                  <td>
                    {" "}
                    <Link to={`/chi_tiet_san_pham/${pr.id}`}>
                      {" "}
                      <img
                        src={
                          typeof pr.images === "string"
                            ? pr.images.split(",")[0]
                            : pr.images[0]
                        }
                        alt={pr.name}
                        className={styles["product-img"]}
                      />{" "}
                    </Link>
                  </td>
                  <td>
                    {pr.name.length > 20
                      ? pr.name.slice(0, 30) + "..."
                      : pr.name}
                  </td>
                  <td>{Number(pr.price).toLocaleString("vi")} VNĐ</td>
                  <td className={styles.cart_sl}>
                    <input
                      type="number"
                      min={1}
                      max={pr.inventory_quantity}
                      defaultValue={pr.so_luong}
                      onChange={(e) => {
                        let value = parseInt(e.target.value) || 1;
                        if (value > pr.inventory_quantity) {
                          value = pr.inventory_quantity;
                          message.warning(
                            `Số lượng tối đa có thể mua là ${pr.inventory_quantity}`
                          );
                        }
                        dispatch(SuaSL([pr.id, value]));
                      }}
                      onBlur={(e) => {
                        handleBlur(e, pr.id, pr.inventory_quantity);
                      }}
                      onKeyPress={handleKeyPress}
                    />
                  </td>
                  <td>
                    {Number(pr.so_luong * pr.price).toLocaleString("vi")} VNĐ
                  </td>
                  <td>
                    <button
                      className={styles.delete}
                      onClick={() => {
                        dispatch(XoaPr(pr.id));
                        message.success(
                          `Bạn đã xóa sản phẩm ${pr.name} khỏi giỏ hàng`
                        );
                      }}
                    >
                      Xóa
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <div className={styles.button}>
            {contextHolder}
            <button className={styles["delete-all"]} onClick={XoaAllCart}>
              Xóa tất cả
            </button>
          </div>
        </div>
  
        <div className={styles.container_tongdonhang}>
        <h3>Tổng đơn hàng</h3>
        <div className={styles.voucher}>
            <p> <strong> Nhập mã giảm giá</strong></p>
            <input type="text" value={VoucherCode} onChange={(e) => setVoucherCode(e.target.value)} />
            <button onClick={applyVoucher}>Nhập mã</button>
          </div>
          <p> <strong> Thành tiền:</strong> {Number(Tongtien).toLocaleString("vi")} VNĐ</p>
          <p> <strong> Phí giao hàng: </strong> {Number(shippingFee).toLocaleString("vi")} VNĐ</p>
          {Discount > 0 && (
            <p> <strong>Đã giảm:</strong> {DiscountType === "fixed" ? `${Discount.toLocaleString()} VNĐ` : `${Discount}%`}</p>
          )}
         <strong> Tổng tiền: {Number(FinalTotal).toLocaleString("vi")} VNĐ </strong>
          
          <div className={styles.btn_thanhtoan}>
         <button><Link to={'/thanhtoan'}>Thanh toán</Link></button>
         </div>

        </div>
        </div>
      </div>
  ) : (
    <div className={styles.bggiohang}>
      <div className={styles.container}>
        <h2 className={styles.title_no}>GIỎ HÀNG CỦA BẠN</h2>
      </div>
      <div className={styles.cart_content}>
          <h3>
            Bạn chưa có sản phẩm trong giỏ hàng. {" "}
            <Link to={"/"}>Nhấn để mua sản phẩm ngay.</Link>
          </h3>
        </div>
    </div>
  );
}
