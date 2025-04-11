var express = require("express");
var router = express.Router();
var pool = require("../../database/db");
const qs = require("querystring");
const crypto = require("crypto");
const moment = require("moment");
// API tạo đơn hàng mới

function sortObject(obj) {
    let sorted = {};
    let keys = Object.keys(obj).sort();
    keys.forEach(function (key) {
      sorted[key] = obj[key];
    });
    return sorted;
  }

router.post("/checkout", async (req, res) => {
  const connection = await pool.getConnection();

  try {
    await connection.beginTransaction();

    const {
        id,
      user_id,
      order_status = 1, // Mặc định là chờ xử lý
      transaction_status,
      payment_method,
      customer_info,
      transaction_code,
      items,
      total_amount,
    } = req.body;

    if (payment_method === 1) {
      // 1. Tạo đơn hàng chính
      const [orderResult] = await connection.query(
        `INSERT INTO \`order\` 
    (id, user_id, name, phone,address, note, voucher_id, order_status, transaction_status, payment_method) 
    VALUES (?, ?, ?, ?, ?, ?, NULL, ?, ?, ?)`,
        [
            id,
          user_id,
          customer_info.name,
          customer_info.phone,
          customer_info.address,
          customer_info.note,
          order_status,
          transaction_status,
          payment_method,
        ]
      );

    

      // 2. Thêm các sản phẩm vào order_detail
      const orderDetails = items.map((item) => [
        id,
        item.pr_id,
        item.quantity,
        item.price,
        item.total,
      ]);

      await connection.query(
        `INSERT INTO order_detail 
    (order_id, pr_id, quantity, price, total) 
    VALUES ?`,
        [
          orderDetails.map((item) => [
            item[0], // orderId
            item[1], // pr_id
            item[2], // quantity
            item[3], // price
            item[4], // total
          ]),
        ]
      );

      for (const item of items) {
        await connection.query(
          `UPDATE product SET inventory_quantity = inventory_quantity - ? WHERE id = ?`,
          [item.quantity, item.pr_id]
        );
      }

      // 3. Cập nhật thông tin người dùng nếu có user_id
      if (user_id) {
        console.log("Cập nhật thông tin người dùng:", user_id);
        await connection.query(
          `UPDATE user 
            SET quantity_pr_buy = quantity_pr_buy + ?, 
                total_buy = total_buy + ?
            WHERE id = ?`,
          [items.length, total_amount, user_id]
        );
      }

      await connection.commit();

      res.status(200).json({
        success: true,
        order_id: orderId,
        message: "Đơn hàng đã được tạo thành công",
      });
    }

    if (payment_method === 2) {
        try {
          await connection.beginTransaction(); // 💥 Bắt đầu transaction
      
          // 1. Tạo đơn hàng chính
          const [orderResult] = await connection.query(
            `INSERT INTO \`order\` 
            (id, user_id, name, phone, address, note, voucher_id, order_status, transaction_status, transaction_code, payment_method) 
            VALUES (?, ?, ?, ?, ?, ?, NULL, ?, ?, ?, ?)`,
            [
              id,
              user_id,
              customer_info.name,
              customer_info.phone,
              customer_info.address,
              customer_info.note,
              0, // chờ thanh toán
              0, // chưa thanh toán
              transaction_code,
              payment_method,
            ]
          );       

          const orderDetails = items.map((item) => [
            id,
            item.pr_id,
            item.quantity,
            item.price,
            item.total,
          ]);
    
          await connection.query(
            `INSERT INTO order_detail 
        (order_id, pr_id, quantity, price, total) 
        VALUES ?`,
            [
              orderDetails.map((item) => [
                item[0], // orderId
                item[1], // pr_id
                item[2], // quantity
                item[3], // price
                item[4], // total
              ]),
            ]
          );
      
          await connection.commit(); // 💥 Xác nhận lưu đơn hàng trước khi redirect
      
          // 4. Redirect đến VNPAY
          const amount = total_amount;
          const tmnCode = '7R8LR6W2';
          const secretKey = '398O7J307B716VWNQZ7AM2L3JSGOLBIZ';
          const returnUrl = 'http://localhost:3500/check_payment';
          const vnp_Url = 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html';
      
          let ipAddr = req.ip || '127.0.0.1';
          const orderId = id;
          const txnRef = orderId;
          let bankCode = req.query.bankCode || "NCB";
      
          let createDate = moment().format("YYYYMMDDHHmmss");
          let locale = req.query.language || "vn";
          let currCode = 'VND';
          let orderInfo = `Thanh_toan_don_hang_${orderId}`;
      
          let vnp_Params = {
            vnp_Version: "2.1.0",
            vnp_Command: 'pay',
            vnp_TmnCode: tmnCode,
            vnp_Locale: locale,
            vnp_CurrCode: currCode,
            vnp_TxnRef: txnRef,
            vnp_OrderInfo: orderInfo,
            vnp_OrderType: "billpayment",
            vnp_Amount: amount * 100,
            vnp_ReturnUrl: returnUrl,
            vnp_IpAddr: ipAddr,
            vnp_CreateDate: createDate,
          };
      
          if (bankCode !== '') {
            vnp_Params["vnp_BankCode"] = bankCode;
          }
      
          vnp_Params = sortObject(vnp_Params);
          let signData = qs.stringify(vnp_Params);
          let hmac = crypto.createHmac("sha512", secretKey);
          let signed = hmac.update(Buffer.from(signData, "utf-8")).digest("hex");
          vnp_Params["vnp_SecureHash"] = signed;
      
          let paymentUrl = vnp_Url + "?" + qs.stringify(vnp_Params);
          res.json({ paymentUrl });
      
        } catch (err) {
          await connection.rollback(); // 💥 Nếu lỗi thì rollback
          console.error("Lỗi tạo đơn hàng VNPAY:", err);
          res.status(500).json({ message: "Tạo đơn hàng thất bại" });
        }
      }


    
  } catch (error) {
    await connection.rollback();
    console.error("Error during checkout:", error);
    res.status(500).json({
      success: false,
      message: error.message || "Có lỗi xảy ra khi tạo đơn hàng",
    });
  } finally {
    connection.release();
  }
});

router.get("/check_payment", async (req, res) => {
    const connection = await pool.getConnection();
    
    try {
      await connection.beginTransaction();
  
      const query = req.query;
      const secretKey = "398O7J307B716VWNQZ7AM2L3JSGOLBIZ";
      const vnp_SecureHash = query.vnp_SecureHash;
  
      // 1. Kiểm tra chữ ký bảo mật
      delete query.vnp_SecureHash;
      const signData = qs.stringify(sortObject(query));
      const checkSum = crypto.createHmac("sha512", secretKey)
                           .update(signData)
                           .digest("hex");
  
      if (vnp_SecureHash !== checkSum) {
        return res.status(400).json({ 
          success: false, 
          message: "Chữ ký không hợp lệ" 
        });
      }
  
      const orderId = query.vnp_TxnRef;
      const isSuccess = query.vnp_ResponseCode === "00";
  
      if (isSuccess) {
        // 2. Xử lý khi thanh toán thành công
        // Cập nhật trạng thái đơn hàng
        const updateResult = await connection.query(
          `UPDATE \`order\` 
           SET transaction_status = 1,
               order_status = 2
               
           WHERE id = ?`,
          [orderId]
        );
  
        if (updateResult[0].affectedRows === 0) {
          await connection.rollback();
          return res.status(404).json({ 
            success: false, 
            message: "Không tìm thấy đơn hàng" 
          });
        }
  
        // Lấy danh sách sản phẩm để cập nhật tồn kho
        const [orderDetails] = await connection.query(
          `SELECT pr_id, quantity FROM order_detail WHERE order_id = ?`,
          [orderId]
        );
  
        // Cập nhật số lượng tồn kho
        for (const item of orderDetails) {
          await connection.query(
            `UPDATE product SET inventory_quantity = inventory_quantity - ? WHERE id = ?`,
            [item.quantity, item.pr_id]
          );
        }
  
        // 3. CẬP NHẬT THỐNG KÊ NGƯỜI DÙNG (PHẦN BỔ SUNG)
        // Lấy thông tin user_id và tổng tiền từ đơn hàng
        const [orderInfo] = await connection.query(
          `SELECT user_id, (SELECT SUM(total) FROM order_detail WHERE order_id = ?) as total_amount 
           FROM \`order\` WHERE id = ?`,
          [orderId, orderId]
        );
  
        if (orderInfo[0].user_id) {
          await connection.query(
            `UPDATE user 
             SET quantity_pr_buy = quantity_pr_buy + ?,
                 total_buy = total_buy + ?
             WHERE id = ?`,
            [orderDetails.length, orderInfo[0].total_amount, orderInfo[0].user_id]
          );
        }
  
        await connection.commit();
        return res.json({
          success: true,
          orderId: orderId,
          message: "Thanh toán thành công",
          statsUpdated: orderInfo[0].user_id ? true : false // Thêm trạng thái cập nhật thống kê
        });
      } else {
        // 4. Xử lý khi thanh toán thất bại - XÓA ĐƠN HÀNG
        // Xóa chi tiết đơn hàng trước
        await connection.query(
          `DELETE FROM order_detail WHERE order_id = ?`,
          [orderId]
        );
        
        // Sau đó xóa đơn hàng chính
        const deleteResult = await connection.query(
          `DELETE FROM \`order\` WHERE id = ?`,
          [orderId]
        );
  
        if (deleteResult[0].affectedRows === 0) {
          await connection.rollback();
          return res.status(404).json({ 
            success: false, 
            message: "Không tìm thấy đơn hàng để xóa" 
          });
        }
  
        await connection.commit();
        return res.json({
          success: false,
          orderId: orderId,
          message: "Thanh toán thất bại, đơn hàng đã được hủy"
        });
      }
    } catch (error) {
      await connection.rollback();
      console.error("Lỗi khi xử lý thanh toán:", error);
      res.status(500).json({ 
        success: false, 
        message: "Lỗi hệ thống khi xử lý thanh toán",
        error: error.message 
      });
    } finally {
      connection.release();
    }
  });
  



module.exports = router;
