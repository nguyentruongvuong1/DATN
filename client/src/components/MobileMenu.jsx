import { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  
  faMagnifyingGlass
} from "@fortawesome/free-solid-svg-icons";
export default function MobileMenu() {
    const [isOpen, setIsOpen] = useState(false);
    const [cate, setcate] = useState([])
    const toggleMenu = () => {
        setIsOpen(!isOpen);
    };


      // Fetch danh mục
      useEffect(() => {
        fetch("http://localhost:3000/c/cate")
          .then((res) => res.json())
          .then((data) => setcate(data));
      }, []); 

    return (
        <>
            {/* Nút mở menu */}
            <div className="menu-icon" onClick={toggleMenu}>
                ☰
            </div>

            {/* Overlay khi menu mở */}
            {isOpen && <div className="overlay" onClick={toggleMenu}></div>}

            {/* Menu ẩn */}
            <div className={`mobile-menu ${isOpen ? "active" : ""}`}>
                <span className="close-menu" onClick={toggleMenu}>✖</span>
                <div className="finding">
               
                
                <input type="text" placeholder="Tìm kiếm sản phẩm" />
                <FontAwesomeIcon icon={faMagnifyingGlass} className="search-icon" />
                </div>
                {cate.map((c, index) =>(
                <div className="menumini" key={index} >
                    <Link to={`/pr_by_cate/${c.id}`}>{c.name}</Link>
                    
                </div>
                ))}
                <div className="menumini">
                <Link to={''}>Hướng dẫn</Link><br/>
                <Link to={''}>Login</Link><br/>
                    
                    <Link to={''}>0đ</Link>
                </div>
             
            </div>

            {/* CSS nội bộ */}
            <style jsx>{`
               .menu-icon {
        font-size: 24px;
        cursor: pointer;
        display: none;
    }

    .mobile-menu {
        position: fixed;
        top: 0;
        left: -100%;
        width: 100%; /* ✅ Sửa từ 75% thành 100% */
        max-width: none; /* ✅ Loại bỏ giới hạn chiều rộng */
        height: 100%;
        background: rgba(0, 0, 0, 0.9);
        color: white;
        padding: 20px;
        transition: left 0.3s ease-in-out;
        z-index: 1000;
    }

    .mobile-menu.active {
        left: 0;
    }

    .close-menu {
        position: absolute;
        top: 15px;
        right: 20px;
        font-size: 24px;
        cursor: pointer;
    }

    .overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
    }
           
               
    @media screen and (max-width: 768px) {
        .menu-icon {
            display: block;
            margin-right: 35px;
        }
    }

    @media screen and (max-width: 480px) {
        .mobile-menu {
            display: block;
            position: fixed;
            top: 0;
            left: -100%;
            width: 100%; /* ✅ Sửa từ 80% thành 100% */
            max-width: none;
            height: 100%;
            background: #1a1a1a;
            color: white;
            padding: 20px 16px;
            transition: left 0.3s ease-in-out;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.4);
                
            }
 
               a{
                text-decoration:none;
                color:white;
                line-height:70px;
                font-size:30px;
                text-align:center;
                color:#FFFFFFCC
                
                }

                .menumini{
                text-align:center
                
                }

                a:hover{
                color:white
                }
        .mobile-menu.active {
            left: 0;
            
        }
            input{
            background-color:#FFFFFF33;
        
           
            }
        .close-menu {
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            top: 16px;
            right: 20px;
            color: gray;
            
        }   
        .close-menu:hover{
        color:white;
        }

        .mobile-menu input[type="text"] {
            width: 70%;
            padding:10px;

            margin: 50px 0 15px 50px;
            
            border-radius: 20px;
            border: none;
            font-size: 16px;
            
        }

        .mobile-menu ul {
            list-style: none;
            padding: 0;
            margin: 0;
            
        }

        .mobile-menu ul li {
            margin-bottom: 16px;
            
        }

        .mobile-menu ul li a {
            text-decoration: none;
            color: #fff;
            font-size: 18px;
            display: block;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background 0.2s;
           
        }

        .mobile-menu ul li a:hover {
            background: rgba(255, 255, 255, 0.1);
        }
            input[placeholder="Tìm kiếm sản phẩm"]::placeholder {
  color: white;
}

    }

            }
            `}</style>
        </>
    );
}
