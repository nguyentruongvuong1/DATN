import styles from '../../styles/User/userprofile.module.css';
import { useState, useEffect } from 'react';
import Profile from '../../components/User/User_profile/Profile';
import { useSelector } from 'react-redux';
import { Navigate } from 'react-router-dom';
import {thoat} from '../../AuthSlice'
import { useDispatch } from 'react-redux';
import "@ant-design/v5-patch-for-react-19";
import { message } from "antd";
export default function Userprofile() {
    const [activeTab, setActiveTab] = useState('profile');
    const user = useSelector((state) => state.auth.user);
    const DaDangNhap = useSelector((state) => state.auth.DaDangNhap);
    const isChecked = useSelector((state) => state.auth.isChecked);
    const dispatch = useDispatch();
    const [userData, setUserData] = useState(null);

    useEffect(() => {
        const fetchUser = async () => {
            try {
                if (user?.id) {
                    const res = await fetch(`${import.meta.env.VITE_API_URL}/user/user/${user.id}`);
                    const data = await res.json();
                    setUserData(data);
                }
            } catch (error) {
                console.error("Lỗi khi tải thông tin người dùng:", error);
            }
        };
        fetchUser();
    }, [user?.id]);

    const renderContent = () => {
        switch (activeTab) {
            case 'profile':
                return <Profile />;
            case 'change-password':
                return <div className={styles["tab-content"]}>Đổi mật khẩu</div>;
            case 'orders':
                return <div className={styles["tab-content"]}>Đơn hàng của tôi</div>;
            default:
                return null;
        }
    };

    if (!isChecked) {
        // Nếu chưa kiểm tra đăng nhập xong thì chưa render gì cả
        return null; // hoặc có thể là spinner
    }

    if (!DaDangNhap) {
        return <Navigate to="/dangnhap" replace={true} />;
    }

    return (
        <div className={styles.container}>
            <div className={styles.sidebar}>
                <div className={styles["profile-header"]}>
                    <img src={userData?.avatar || '/default-avatar.png'} alt="User Avatar" className={styles.avatar} />
                    <h3 className={styles.username}>{userData?.username || 'Người dùng'}</h3>
                    <p className={styles["user-email"]}>{user?.email}</p>
                </div>

                <div className={styles.menu}>
                    <button 
                        onClick={() => setActiveTab('profile')} 
                        className={`${styles["menu-item"]} ${activeTab === 'profile' ? styles.active : ''}`}
                    >
                        Thông tin tài khoản
                    </button>
                    <button 
                        onClick={() => setActiveTab('change-password')} 
                        className={`${styles["menu-item"]} ${activeTab === 'change-password' ? styles.active : ''}`}
                    >
                        Đổi mật khẩu
                    </button>
                    <button 
                        onClick={() => setActiveTab('orders')} 
                        className={`${styles["menu-item"]} ${activeTab === 'orders' ? styles.active : ''}`}
                    >
                        Đơn hàng của tôi
                    </button>
                    <button onClick={() => {
                        const hoi = confirm("Bạn có chắc chắn muốn đăng xuất tài khoản không?");
                        if(hoi){
                            dispatch(thoat());
                            message.success("Đăng xuất thành công!");
                            setTimeout(() => {
                                window.location.href = "/";
                            }, 1000);
                        }
                        else{
                            return;
                        }
                        
                    }} className={styles["menu-item"]}>
                        Đăng xuất
                    </button>
                </div>
            </div>

            <div className={styles.content}>
                {renderContent()}
            </div>
        </div>
    );
}
