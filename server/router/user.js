var express = require('express');
var router = express.Router();
var pool = require('../database/db');

router.get('/user/:id', async (req , res) =>{
    const id = req.params.id;

    try{
        let sql = `SELECT * FROM user WHERE id =? `;
        const [user] = await pool.query(sql, [id]);
        res.json(user[0]);
    }
    catch(error){
        console.error("Lỗi truy vấn:", error);
        res.status(500).json({ message: "Lỗi server" });
    }
  
})


// Lấy danh sách dơn hàng của người dùng
router.get('/order_user/:id', async(req, res) =>{
    let id = req.params.id;

    try{
        const sql = `SELECT * FROM \`order\` WHERE user_id = ?`;
        const [result] = await pool.query(sql, [id]);
        res.json(result);
    }

    catch(error){
        console.error("Lỗi truy vấn:", error);
        res.status(500).json({ message: "Lỗi server" });
    }
})

// Lấy đơn hàng chi tiết
router.get('/orderdetail_user/:order_id', async (req, res) => {
    const order_id = req.params.order_id;

    try {
        const sql = `SELECT * FROM order_detail WHERE order_id = ?`;
        const [result] = await pool.query(sql, [order_id]);

        if (result.length === 0) {
            return res.status(404).json({ message: "Không tìm thấy chi tiết đơn hàng" });
        }

        res.json(result);
    } catch (error) {
        console.error("Lỗi truy vấn:", error);
        res.status(500).json({ message: "Lỗi server" });
    }
});


module.exports = router;
