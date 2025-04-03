import { BrowserRouter, Routes, Route } from "react-router-dom";
import UserLayout from "./layouts/UserLayout";
import AdminLayout from "./layouts/AdminLayout";
import Home from "./pages/User/Home";
import AdminDashboard from "./pages/Admin/Admindashboard";
import Login from "./pages/User/Login";
import Register from "./pages/User/Register";
import Cart from "./pages/User/Cart";
import Profcate from "./pages/User/Profcate";
import Prdetail from "./pages/User/Prdetail";
import Favorite_Pr from "./pages/User/Prlike";
import UserInfo from "./UserInfo";
import Profileuser from "./pages/User/ProfileUser";
import NotFound from "./pages/User/Notfound";
import ProductC from "./pages/User/Profc";
import VerifyOTP from "./pages/User/VetiFyOtp";
import Payment from "./pages/User/Payment";


import AdminVoucher from "./pages/Admin/Adminvoucher";
import AdminCate from "./pages/Admin/Admincate";
import AdminCharacteristic from "./pages/Admin/Admincharacteristic";
import AdminTypecate from "./pages/Admin/Admintypecate"
import AdminProduct from "./pages/Admin/Adminproduct";
import AdminComment from "./pages/Admin/Admincomment";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Route dành cho User */}
        <Route path="/" element={<> <UserInfo /> <UserLayout /> </>}>
          <Route index element={<Home />} />
          <Route path="/dangnhap" element={<Login />} />
          <Route path="/dangky" element={<Register />} />
          <Route path="/giohang" element={<Cart />} />
          <Route path="/pr_by_cate/:cate_id" element={<ProductC />} />
          <Route path="/pr_by_typecate/:cate_id" element={<Profcate />} />
          <Route path="/chi_tiet_san_pham/:id" element={<Prdetail />} />
          <Route path="/prlike/:user_id" element={<Favorite_Pr />} />
          <Route path="/user/:user_id" element={<Profileuser />} />
          <Route path="/xacminh-otp" element={<VerifyOTP />} />
          <Route path="/thanhtoan" element={<Payment />} />
          <Route path="*" element={<NotFound />} />
        </Route>

        {/* Route dành cho Admin */}
        <Route path="/admin" element={<AdminLayout />}>
          <Route index element={<AdminDashboard />} />
          <Route path="dashboard" element={<AdminDashboard />} />
          <Route path="voucher" element={<AdminVoucher />} />
          <Route path="cate" element={<AdminCate />} />
          <Route path="characteristic" element={<AdminCharacteristic />} />
          <Route path="typecate" element={<AdminTypecate />} />
          <Route path="product" element={<AdminProduct />} />
          <Route path="comment" element={<AdminComment />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;