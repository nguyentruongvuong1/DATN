var express = require('express');
var router = express.Router();
var pool = require('../../database/db')





// API tạo đơn hàng mới
router.post('/checkout', async (req, res) => {
    const connection = await pool.getConnection();
    
    try {
        await connection.beginTransaction();

        const {
            user_id,
            order_status = 1, // Mặc định là chờ xử lý
            transaction_status,
            payment_method,
            customer_info,
            items,
            total_amount
        } = req.body;

    

        // 1. Tạo đơn hàng chính
        const [orderResult] = await connection.query(
            `INSERT INTO \`order\` 
            (user_id, name, phone,address, note, voucher_id, order_status, transaction_status, payment_method) 
            VALUES (?, ?, ?, ?, ?, NULL, ?, ?, ?)`,
            [user_id, customer_info.name, customer_info.phone, customer_info.address, customer_info.note, order_status, transaction_status, payment_method]
        );

        const orderId = orderResult.insertId;

        // 2. Thêm các sản phẩm vào order_detail
        const orderDetails = items.map(item => [
            orderId,
            item.pr_id,
            item.quantity,
            item.price,
            item.total,
           
        ]);
       
    
        await connection.query(
            `INSERT INTO order_detail 
            (order_id, pr_id, quantity, price, total) 
            VALUES ?`,
            [orderDetails.map(item => [
                item[0],  // orderId
                item[1],  // pr_id
                item[2],  // quantity
                item[3],  // price
                item[4],  // total
             
            ])]
        );

        for (const item of items) {
            await connection.query(
                `UPDATE product SET inventory_quantity = inventory_quantity - ? WHERE id = ?`,
                [item.quantity, item.pr_id]
            );
        }

        // 3. Cập nhật thông tin người dùng nếu có user_id
        if (user_id) {
            console.log('Cập nhật thông tin người dùng:', user_id);
            await connection.query(
                `UPDATE user 
                SET quantity_pr_buy = quantity_pr_buy + ?, 
                    total_buy = total_buy + ?
                WHERE id = ?`,
                [
                    items.length, 
                    total_amount, 
                    user_id
                ]
            );
        }

        await connection.commit();

        res.status(200).json({
            success: true,
            order_id: orderId,
            message: 'Đơn hàng đã được tạo thành công'
        });
    } catch (error) {
        await connection.rollback();
        console.error('Error during checkout:', error);
        res.status(500).json({
            success: false,
            message: error.message || 'Có lỗi xảy ra khi tạo đơn hàng'
        });
    } finally {
        connection.release();
    }
});


module.exports = router;