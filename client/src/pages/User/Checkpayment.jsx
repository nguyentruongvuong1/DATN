import React,{  useEffect, useState } from "react";
import axios from "axios";
import { useSearchParams, Navigate, useNavigate } from "react-router-dom";
import "@ant-design/v5-patch-for-react-19"
import { message } from "antd";
import { XoaGH } from "../../CartSlice";
import { useDispatch } from "react-redux";
function Checkpayment(){
    const [searchParams] = useSearchParams();
    const [status, setstatus] = useState(null);
    const navigate = useNavigate()
    const dispatch = useDispatch()

    useEffect(() => {
        
        const fetchData = async () => {
            try {
                const res = await axios.get(`http://localhost:3000/payment/check_payment?${searchParams.toString()}`);
                if(res.data.success){
                    setstatus('success')
                  message.success(`Chúc mừng bạn đã thanh toán thành công đơn hàng ${res.data.orderId}`)
                    dispatch(XoaGH())
                    setTimeout(() =>{
                        navigate('/')
                    }, 2000)

                  }  else{
                    setstatus('fail');
                    message.error(`Thanh toán thất bại đơn hàng ${res.data.orderId} đã bị hủy`)
                    setTimeout(() =>{
                        navigate('/thanhtoan')
                    }, 2000)

                  }
                    

            } catch (error) {
                console.error("Error fetching data:", error);
            }
        };
        fetchData();
    }, [searchParams]);


    return(
        <div style={{ padding: "50px", textAlign: "center" }}>
            {status === null && <p>Đang xử lý thanh toán...</p>}
            {status === "success" && <p>🎉 Cảm ơn bạn đã mua hàng!</p>}
            {status === "fail" && <p>❌ Thanh toán thất bại!</p>}
            {status === "error" && <p>🚨 Đã xảy ra lỗi hệ thống.</p>}
        </div>
    )


}

export default Checkpayment;