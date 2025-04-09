var express = require('express');
var router = express.Router();
var pool = require('../../database/db'); // Đảm bảo đã sử dụng mysql2/promise
var upload = require('../../multerConfig');
const path = require('path');
const fs = require('fs');
require('dotenv').config(); // Đảm bảo dotenv đã được cài đặt và cấu hình
const baseUrl = process.env.BASE_URL; // Lấy từ .env

// Import multer config


// API VOUCHER------------------------------------------------------------------------------------------------------------------------------------------
// API lấy danh sách voucher
router.get("/vouchers", async (req, res) => {
    const { page = 1, limit = 8 } = req.query;

    // Validate input
    const pageNumber = parseInt(page);
    const limitNumber = parseInt(limit);
    if (isNaN(pageNumber) || isNaN(limitNumber) || pageNumber < 1 || limitNumber < 1) {
        return res.status(400).json({ message: "Tham số phân trang không hợp lệ" });
    }

    const offset = (pageNumber - 1) * limitNumber;

    try {
        // Query lấy danh sách voucher có phân trang
        const [vouchers] = await pool.query(`
            SELECT * FROM voucher
            LIMIT ? OFFSET ?
        `, [limitNumber, offset]);

        // Query lấy tổng số voucher
        const [[totalResult]] = await pool.query(`
            SELECT COUNT(*) as total FROM voucher
        `);

        res.json({
            vouchers,
            total: totalResult.total,
            page: pageNumber,
            totalPages: Math.ceil(totalResult.total / limitNumber),
            limit: limitNumber
        });

    } catch (err) {
        console.error("Lỗi lấy voucher:", err);
        res.status(500).json({ message: "Lỗi lấy voucher", error: err.message });
    }
});



// API cập nhật voucher
router.put('/voucher/:id', async (req, res) => {
    const { id } = req.params;
    const { code, discount_type, discount_value, quantity, end_date, status } = req.body;

    try {
        // Kiểm tra voucher có tồn tại không
        const [rows] = await pool.query("SELECT * FROM voucher WHERE id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "Voucher không tồn tại" });
        }

        // Cập nhật voucher
        const [updateResult] = await pool.query(
            "UPDATE voucher SET code=?, discount_type=?, discount_value=?, quantity=?, end_date=?, status=? WHERE id=?",
            [code, discount_type, discount_value, quantity, end_date, status, id]
        );

        res.json({ message: "Cập nhật voucher thành công!", affectedRows: updateResult.affectedRows });
    } catch (err) {
        console.error("Lỗi cập nhật voucher:", err);
        res.status(500).json({ message: "Lỗi server", error: err });
    }
});


// API xóa voucher
router.delete('/voucher/:id', async (req, res) => {
    const { id } = req.params;
    const sql = "DELETE FROM voucher WHERE id = ?";

    try {
        const [result] = await pool.query(sql, [id]);

        // Kiểm tra xem voucher có tồn tại không trước khi xóa
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Voucher không tồn tại!" });
        }

        res.json({ message: "Xóa voucher thành công!", affectedRows: result.affectedRows });
    } catch (err) {
        console.error("Lỗi xóa voucher:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});


// API thêm voucher
router.post('/voucher', async (req, res) => {
    const { code, discount_type, discount_value, quantity, end_date, status } = req.body;

    // Kiểm tra dữ liệu đầu vào
    if (!code || !discount_type || discount_value == null || quantity == null || !end_date || status == null) {
        return res.status(400).json({ message: "Thiếu dữ liệu đầu vào!" });
    }

    const sql = "INSERT INTO voucher (code, discount_type, discount_value, quantity, end_date, status) VALUES (?, ?, ?, ?, ?, ?)";

    try {
        const [result] = await pool.query(sql, [code, discount_type, discount_value, quantity, end_date, status]);

        // Kiểm tra xem có thực sự thêm được dữ liệu không
        if (result.affectedRows === 0) {
            return res.status(500).json({ message: "Không thể thêm voucher!" });
        }

        res.json({ message: "Thêm voucher thành công!", id: result.insertId });
    } catch (err) {
        console.error("Lỗi thêm voucher:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});

// API REVIEWS------------------------------------------------------------------------------------------------------------------------------------------
router.get('/reviews', async function (req, res) {
    try {
        const { page = 1, limit = 8 } = req.query;
        const offset = (page - 1) * limit;

        const [results] = await pool.query(`
            SELECT 
            reviews.id_order_detail AS id,
            user.username AS user_name,
            product.name AS product_name,
            order_detail.pr_id,
            reviews.content,
            reviews.start,
            reviews.create_date,
            reviews.status
        FROM reviews
        JOIN order_detail ON reviews.id_order_detail = order_detail.id
        JOIN product ON order_detail.pr_id = product.id
        JOIN \`order\` ON order_detail.order_id = \`order\`.id
        JOIN user ON \`order\`.user_id = user.id
        LIMIT 8 OFFSET 0;

        `, [parseInt(limit), parseInt(offset)]);

        const [[{ total }]] = await pool.query(`SELECT COUNT(*) AS total FROM reviews`);

        res.json({ comments: results, total });
    } catch (err) {
        console.error('Lỗi truy vấn dữ liệu:', err);
        res.status(500).json({ error: 'Không thể lấy dữ liệu' });
    }
});

// API BANNER------------------------------------------------------------------------------------------------------------------------------------------
// GET banners with pagination
router.get("/banners", async (req, res) => {
  const { page = 1, limit = 8 } = req.query;
  const offset = (parseInt(page) - 1) * parseInt(limit);

  try {
    const [banners] = await pool.query(`
            SELECT * FROM banner 
            ORDER BY create_date DESC
            LIMIT ? OFFSET ?
        `, [parseInt(limit), offset]);

    const [[{ total }]] = await pool.query(`SELECT COUNT(*) AS total FROM banner`);

    res.json({ banners, total });
  } catch (err) {
    console.error("Lỗi lấy danh sách banner:", err);
    res.status(500).json({ error: "Không thể lấy danh sách banner" });
  }
});

// Thêm banner mới
router.post('/banner', upload.single('image'), async (req, res) => {

  const { status } = req.body;
  const image = req.file ? `${baseUrl}/public/images/${req.file.filename}` : null;

  if (!image) {
    return res.status(400).json({ message: "Ảnh là bắt buộc!" });
  }

  try {
    console.log(req.file);
    const sql = "INSERT INTO banner (image, status) VALUES (?, ?)";
    const [result] = await pool.query(sql, [image, status]);

    if (result.affectedRows > 0) {
      res.json({ message: "Thêm banner thành công!", id: result.insertId });
    } else {
      res.status(500).json({ message: "Không thể thêm banner!" });
    }
  } catch (err) {
    console.error('Lỗi khi thêm banner:', err);
    res.status(500).json({ message: "Lỗi server", error: err.message });
  }
});



// PUT update banner
// Sửa banner
router.put('/banner/:id', upload.single('image'), async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;
  let newImagePath = req.file ? `http://localhost:3000/public/images/${req.file.filename}` : null;

  try {
    const [rows] = await pool.query("SELECT * FROM banner WHERE id = ?", [id]);
    if (rows.length === 0) {
      return res.status(404).json({ message: "Banner không tồn tại!" });
    }

    const oldImagePath = rows[0].image;

    // Nếu có ảnh mới được upload và ảnh cũ tồn tại, thì xóa ảnh cũ
    if (newImagePath && oldImagePath) {
      const fullOldPath = path.join(__dirname, '../../public/images', path.basename(oldImagePath));
      fs.unlink(fullOldPath, (err) => {
        if (err) {
          console.warn(`Không thể xóa ảnh cũ: ${fullOldPath}`, err.message);
        }
      });
    }

    const finalImagePath = newImagePath || oldImagePath;
    const sql = "UPDATE banner SET image = ?, status = ? WHERE id = ?";
    const [result] = await pool.query(sql, [finalImagePath, status, id]);

    if (result.affectedRows > 0) {
      res.json({ message: "Sửa banner thành công!" });
    } else {
      res.status(500).json({ message: "Không thể sửa banner!" });
    }
  } catch (err) {
    console.error('Lỗi khi sửa banner:', err);
    res.status(500).json({ message: "Lỗi server", error: err.message });
  }
});


// Xóa banner
router.delete('/banner/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const [rows] = await pool.query("SELECT * FROM banner WHERE id = ?", [id]);
    if (rows.length === 0) {
      return res.status(404).json({ message: "Banner không tồn tại!" });
    }

    const sql = "DELETE FROM banner WHERE id = ?";
    const [result] = await pool.query(sql, [id]);

    if (result.affectedRows > 0) {
      res.json({ message: "Xóa banner thành công!" });
    } else {
      res.status(500).json({ message: "Không thể xóa banner!" });
    }
  } catch (err) {
    console.error('Lỗi khi xóa banner:', err);
    res.status(500).json({ message: "Lỗi server", error: err.message });
  }
});


  // User API
  router.get('/users', async (req, res) => {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 8;
    const offset = (page - 1) * limit;
  
    try {
      const [users] = await pool.execute(`SELECT * FROM user ORDER BY total_buy DESC LIMIT ? OFFSET ?`, [limit, offset]);
      const [count] = await pool.execute(`SELECT COUNT(*) AS total FROM user`);
      res.json({ users, total: count[0].total });
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Lỗi khi lấy danh sách người dùng' });
    }
  });

  // Cập nhật status người dùng
router.put('/user/:id', async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;
  
    if (typeof status === 'undefined') {
      return res.status(400).json({ error: 'Thiếu trường status' });
    }
  
    try {
      await pool.execute(`UPDATE user SET status = ? WHERE id = ?`, [status, id]);
      res.json({ message: 'Cập nhật trạng thái người dùng thành công' });
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Lỗi khi cập nhật trạng thái người dùng' });
    }
  });
  

// Admin order
router.get('/order', async function (req, res) {
  try {
      const { page = 1, limit = 8 } = req.query;
      const offset = (page - 1) * limit;

      const [results] = await pool.query(`
          SELECT * FROM \`order\` LIMIT 8 OFFSET 0;

      `, [parseInt(limit), parseInt(offset)]);

      const [[{ total }]] = await pool.query(`SELECT COUNT(*) AS total FROM \`order\` `);

      res.json({ order: results, total });
  } catch (err) {
      console.error('Lỗi truy vấn dữ liệu:', err);
      res.status(500).json({ error: 'Không thể lấy dữ liệu' });
  }
});

// Lấy chi tiết đơn hàng
router.get('/order_detail/:order_id', async (req, res) => {
  const { order_id } = req.params;
  try {
    const [result] = await pool.query(`
      SELECT 
        od.*, 
        p.name AS product_name
      FROM 
        order_detail od
      JOIN 
        product p ON od.pr_id = p.id
      WHERE 
        od.order_id = ?
    `, [order_id]);

    res.json(result);
  } catch (error) {
    console.error("Lỗi truy vấn:", error);
    res.status(500).json({ message: "Lỗi server" });
  }
});

// Cập nhật trạng thái đơn hàng
router.put('/order_status/:id', async (req, res) => {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();

    // 1. Kiểm tra đơn hàng tồn tại
    const [order] = await conn.query(
      'SELECT * FROM `order` WHERE id = ? FOR UPDATE',
      [req.params.id]
    );

    if (!order.length) {
      await conn.rollback();
      return res.status(404).json({ error: "Đơn hàng không tồn tại" });
    }

    // 2. Validate trạng thái mới
    const newStatus = Number(req.body.order_status);
    const currentStatus = order[0].order_status;

    if (newStatus <= currentStatus) {
      await conn.rollback();
      return res.status(400).json({ 
        error: `Không thể chuyển từ ${getStatusName(currentStatus)} về ${getStatusName(newStatus)}`
      });
    }

    // 3. Cập nhật trạng thái
    await conn.query(
      'UPDATE `order` SET order_status = ? WHERE id = ?',
      [newStatus, req.params.id]
    );

    await conn.commit();
    res.json({ success: true, message: "Cập nhật thành công!" });

  } catch (err) {
    await conn.rollback();
    console.error("Lỗi server:", err);
    res.status(500).json({ 
      error: "Lỗi khi cập nhật trạng thái",
      detail: err.message  // Gửi chi tiết lỗi về frontend
    });
  } finally {
    conn.release();
  }
});



module.exports = router;
