import styles from "../../styles/User/search.module.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSearch } from "@fortawesome/free-solid-svg-icons";
import { useState, useEffect } from "react";
import { Link } from "react-router-dom";
export default function Search() {
  const [product, setproduct] = useState([]);
  const [searchpr, setsearchpr] = useState("");
  const [prfilter, setprfilter] = useState([]);
  const [isInputFocused, setInputFocused] = useState(false);

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_URL}/pr/pr`)
      .then((res) => res.json())
      .then((data) => setproduct(data));
  }, []);

  // lay du lieu nguoi dung nhap vao
  const onchangeSearch = (e) => {
    setsearchpr(e.target.value);
  };

  useEffect(() => {
    if (searchpr === "") {
      setprfilter("");
    } else {
      const Filterpr = product.filter((pr) =>
        pr.name.toLowerCase().includes(searchpr.toLowerCase())
      );
      setprfilter(Filterpr);
    }
  }, [product, searchpr]);

  // Khi click vào icon, hiển thị ô input và focus vào đó
  // Khi click vào icon tìm kiếm

  return (
    <>
      <div className={styles["search-box"]}>
        <input
          type="text"
          value={searchpr}
          onChange={onchangeSearch}
          onFocus={() => setInputFocused(true)}
          onBlur={() => setInputFocused(false)}
          placeholder="Tìm kiếm sản phẩm..."
        />
        <button>
          <FontAwesomeIcon icon={faSearch} />
        </button>
      </div>
      <div className={styles.pr_search_container}>
        {searchpr && prfilter.length > 0
          ? prfilter.map((pr, index) => (
            <Link to={`/chi_tiet_san_pham/${pr.id}`}>
              <div key={index} className={styles.pr_search}>
                <div className={styles.pr_search_img}>
                  <img src={pr.images.split(",")[0]} alt="" />
                </div>
                <div className={styles.pr_search_info}>
                  <p>
                    {pr.name.length > 40
                      ? pr.name.slice(0, 40) + "..."
                      : pr.name}
                  </p>
                  <p>{Number(pr.price).toLocaleString("vi")}</p>
                </div>
              </div>
              </Link>

            ))
          : searchpr && isInputFocused && <div>Sản phẩm này không tồn tại</div>}
      </div>
    </>
  );
}
