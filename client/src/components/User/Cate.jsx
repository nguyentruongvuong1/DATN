import styles from'../../styles/User/cate.module.css'

export default function Cate(){
  return(
    <>
  <nav className={styles.bgnav}>
    <div className={styles.container}>
      <div className={styles.titledanhmuc}>
        <h1>DANH MỤC NỔI BẬT</h1>
      </div>

      <div className={styles.fullcate}>
        <div className={styles.cate}>
          <img src="/images/dmsp9.jpg" alt="" />
          <p>CÂY DỄ CHĂM</p>
        </div>

        <div className={styles.cate}>
          <img src="/images/dmsp1.jpg" alt="" />
          <p>CÂY VĂN PHÒNG</p>
        </div>

        <div className={styles.cate}>
          <img src="/images/dmsp2.jpg" alt="" />
          <p>CÂY PHONG THỦY</p>
        </div>

        <div className={styles.cate}>
          <img src="/images/dmsp3.jpg" alt="" />
          <p>CÂY ĐỂ BÀN</p>
        </div>

        <div className={styles.cate}>
          <img src="/images/dmsp4.jpg" alt="" />
          <p>CÂY TRONG NƯỚC</p>
        </div>

        <div className={styles.cate}>
          <img src="/images/dmsp5.jpg" alt="" />
          <p>CÂY CAO CẤP</p>
        </div>

        <div className={styles.cate}>
          <img src="/images/dmsp7.jpg" alt="" />
          <p>CHẬU ĐẤT NUNG</p>
        </div>

        <div className={styles.cate}>
          <img src="/images/dmsp8.jpg" alt="" />
          <p>CHẬU XI MĂNG</p>
        </div>
      </div>
    </div>
  </nav>
  </>
  )

}