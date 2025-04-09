import { Navigate } from "react-router-dom";
import { useSelector } from "react-redux";

function ProtectAdmin({ children }) {
    const user = useSelector((state) => state.auth.user);
    const token = useSelector((state) => state.auth.token);
    
    if (!token) {
        return <Navigate to="/dangnhap" replace />;
    }
    
    if (user && user.role !== 0) {
        return <Navigate to="/" replace />;
    }
    
    return children;
}

export default ProtectAdmin;