import { useState, useEffect } from "react";
import { useSelector } from "react-redux";
import styles from '../../../styles/User/userprofile.module.css'

export default function Profile() {

    const user = useSelector((state) => state.auth.user);
    const [userData, setUserData] = useState(null)

    useEffect(() => {
        const fetchuser = async () =>{
            try{
                const res = await fetch(`${import.meta.env.VITE_API_URL}/user/user/${user?.id}`);
                const data = await res.json();
                setUserData(data);
            }
            catch(error){
                console.error("Lỗi khi tải thông tin người dùng:", error);
            }
        }
        fetchuser();
    }, [user?.id])

return(
    <>
 <div className={styles["content-header"]}>
                <h1 className={styles["content-title"]}>Thông tin tài khoản</h1>
            </div>
            
         
        {userData && (
                   <form>
        <div className={styles["form-group"]}>
        <label >Họ và tên</label>
        <input type="text" id="fullname" className={styles["form-control"]} value={userData.username} />
        </div>

        <div className={styles["form-group"]}>
        <label >Email</label>
        <input type="email" id="email" className={styles["form-control"]} value={userData.email}  />
        </div>

        <div className={styles["form-group"]}>
        <label for="phone">Số điện thoại</label>
        <input type="tel" id="phone" className={styles["form-control"]} value={userData.phone} />
        </div>

        <div className={styles["form-group"]}>
        <label >Địa chỉ</label>
        <textarea id="address" className={styles["form-control"]} rows="3">{userData.address.length > 0 ? userData.address : "Bạn chưa nhập địa chỉ" }</textarea>
        </div>

        <button type="submit" className={styles.btn}>Cập nhật thông tin</button>
        </form>
            )}  
               
          

            </>
)

}