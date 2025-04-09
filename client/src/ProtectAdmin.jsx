import { useSelector } from "react-redux";
import { Navigate } from "react-router-dom";

export default function ProtectAdmin({ children }) {
  const { token, user, DaDangNhap, isChecked } = useSelector((state) => state.auth);

  if (!isChecked) {
    return null; // hoặc spinner/loading nếu muốn
  }

  if (!token || !user || DaDangNhap === false) {
    return <Navigate to="/dangnhap" replace />;
  }

  if (user.role !== 0) {
    return <Navigate to="/" replace />;
  }

  return children;
}
