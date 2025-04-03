import styles from'../../styles/User/notfound.module.css'
export default function NotFound() {
    return(
        <div className={styles["not-found-container"]}>
        <div className={styles.info}>
        <div className={styles["leaf-decoration"]}>🍃</div>
        
        <h1>404</h1>
        <h2>Trang bạn tìm kiếm không tồn tại!</h2>
        <p>Có vẻ như trang này đã "bị mất" giữa rừng cây của chúng tôi. Hãy trở về trang chủ hoặc tìm kiếm sản phẩm khác nhé!</p>
        
        <div className={styles["cta-buttons"]}>
            <a href="/" className={styles["btn-home"]}>Về trang chủ</a>
            <a href="/san-pham" className={styles["btn-shop"]}>Xem sản phẩm</a>
        </div>
        
        {/* <div className={styles["plant-image"]}>
            <img src={"https://cdn.pixabay.com/photo/2020/06/30/10/23/plant-5355182_640.png"} alt="Cây cảnh mini" width={"150px"} />
        </div> */}
        </div>
    </div>
    )
}