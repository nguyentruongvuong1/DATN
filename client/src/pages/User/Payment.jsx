import styles from'../../styles/User/payment.module.css'
export default function Payment(){
    return(
        <div className={styles.container}>
        <h2>THANH TOÁN</h2>

        <div className={styles.checkout}>
            <div className={styles.info}>
                <h3>THÔNG TIN THANH TOÁN</h3>
                <label>Tên *</label>
                <input type="text" placeholder="Họ và tên" />
                
                <label>Địa chỉ giao sản phẩm *</label>
                <input type="text" placeholder="Địa chỉ" />
                
                <label>Số điện thoại *</label>
                <input type="text" placeholder="Số điện thoại" />
                
                <label>Ghi chú đơn hàng</label>
                <textarea placeholder="Ghi chú để có thể dễ dàng giao hàng"></textarea>
            </div>
            <div className={styles["order-summary"]}>
                <h3>ĐƠN HÀNG CỦA BẠN</h3>
                <p><strong>Cây ngũ gia bì cắm thạch x 1</strong> <span>150.000 VND</span></p>
                <p>Phí giao hàng <span>50.000 VND</span></p>
                <p><strong>Tổng tiền</strong> <span className={styles.total}>200.000 VND</span></p>

                <div className={styles.payment}>
                <label><input type="radio" name="payment" /> Thanh toán khi nhận hàng</label>


                    <label><input type="radio" name="payment" /> Thanh toán online</label>


                </div>

                <button className={styles["checkout-btn"]}>THANH TOÁN</button>
            </div>
        </div>
    </div>
    )
}