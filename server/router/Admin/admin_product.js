require('dotenv').config();
var express = require('express');
var router = express.Router();
var pool = require('../../database/db'); // Đảm bảo đã sử dụng mysql2/promise
var upload = require('../../multerConfig');
const path = require('path');
const fs = require('fs');
const baseUrl = process.env.BASE_URL; // Lấy từ .env

// up nhiều sản phẩm
router.post('/upload', upload.array('images', 10), (req, res) => {
    const urls = req.files.map(file => `${baseUrl}/public/images/${file.filename}`);
    res.json({ urls });
  });

router.get("/products", async (req, res) => {
    const { sort, page = 1, limit = 8 } = req.query;

    // Validate input
    const pageNumber = parseInt(page);
    const limitNumber = parseInt(limit);
    if (isNaN(pageNumber) || isNaN(limitNumber) || pageNumber < 1 || limitNumber < 1) {
        return res.status(400).json({ message: "Tham số phân trang không hợp lệ" });
    }

    const offset = (pageNumber - 1) * limitNumber;

    try {
        const [products] = await pool.query(`
            SELECT p.*, c.name AS category_name
            FROM product p
            LEFT JOIN cate c ON p.cate_id = c.id
            ORDER BY p.create_date DESC
            LIMIT ? OFFSET ?
        `, [limitNumber, offset]);

        const [[totalResult]] = await pool.query(`
            SELECT COUNT(*) as total FROM product
        `);

        res.json({
            products,
            total: totalResult.total,
            page: pageNumber,
            totalPages: Math.ceil(totalResult.total / limitNumber),
            limit: limitNumber
        });

    } catch (err) {
        console.error("Lỗi lấy sản phẩm:", err);
        res.status(500).json({ message: "Lỗi lấy sản phẩm", error: err.message });
    }
});

//Lấy đặc điểm và loại cây
router.get('/product_type_cate', async (req, res) => {
    
})

// API thêm sản phẩm
router.post('/products', async (req, res) => {
    const conn = await pool.getConnection();
    try {
      const {
        name, price, cate_id, images, type_cate_ids, inventory_quantity, description
      } = req.body;
      console.log(req.body);
      // 1. Thêm vào bảng product
      const [result] = await conn.query(`
        INSERT INTO product (name, price, cate_id, images, inventory_quantity, discription, status)
        VALUES (?, ?, ?, ?, ?, ?, 1)
      `, [name, price, cate_id, images, inventory_quantity, description]);
  
      const productId = result.insertId;
  
      // 2. Thêm vào bảng product_type_cate
      for (const typeId of type_cate_ids) {
        await conn.query(`
          INSERT INTO product_type_cate (pr_id, type_cate_id)
          VALUES (?, ?)
        `, [productId, typeId]);
      }
  
      res.status(201).json({ message: 'Success' });
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error' });
    } finally {
      conn.release();
    }
  });

// API xóa sản phẩm
router.delete('/product/:id', async (req, res) => {
    const conn = await pool.getConnection();
    const { id } = req.params;
    const sql = "DELETE FROM product WHERE id = ?";

    try {
        // Lấy thông tin ảnh của sản phẩm
        const [rows] = await conn.query("SELECT images FROM product WHERE id = ?", [id]);

        if (rows.length === 0) {
            return res.status(404).json({ message: "Sản phẩm không tồn tại" });
        }

        const images = rows[0].images ? rows[0].images.split(',') : [];

        // Xóa các ảnh trên server
        images.forEach(imageurl => {
            const imageName = imageurl.split('/').pop(); // Tên file
            const filePath = path.join(__dirname, '../../public/images', imageName); // Đúng đường dẫn

            fs.unlink(filePath, (err) => {
                if (err) {
                    console.error("Lỗi xóa ảnh:", err);
                } else {
                    console.log("Đã xóa ảnh:", imageName);
                }
            });
        });

        // Xóa bản ghi liên quan
        await conn.query('DELETE FROM product_type_cate WHERE pr_id = ?', [id]);
        await conn.query(sql, [id]);

        res.json({ message: "Xóa sản phẩm thành công!" });

    } catch (err) {
        console.error("Lỗi xóa sản phẩm:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    } finally {
        conn.release();
    }
});

module.exports = router;
