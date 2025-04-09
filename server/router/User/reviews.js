var express = require('express');
var router = express.Router();
var pool = require('../../database/db')


// Đánh giá sản phẩm dựa khi mua sản phẩm thành công
router.get('/check-purchase', async (req, res) => {
  const { userId, productId } = req.query;

  try {
      const [rows] = await pool.query(`
          SELECT 1 AS hasPurchased
          FROM \`order\` o
          JOIN order_detail od ON o.id = od.order_id
          WHERE o.user_id = ?
          AND od.pr_id = ?
          AND o.order_status = 4  -- Đã hoàn thành
          AND o.transaction_status = 2  -- Đã thanh toán
          LIMIT 1
      `, [userId, productId]);

      res.json({ 
          hasPurchased: rows.length > 0 
      });
  } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Lỗi server' });
  }
});
// API Submit đánh giá
router.post('/submit-review', async (req, res) => {
  const { userId, productId, content, stars } = req.body;
  console.log('Received data:', req.body);
  try {
      // Kiểm tra lại quyền (đảm bảo an toàn)
      const [checkRows] = await pool.query(`
          SELECT od.id 
          FROM \`order\` o
          JOIN order_detail od ON o.id = od.order_id
          WHERE o.user_id = ? 
          AND od.pr_id = ?
          AND o.order_status = 4
          AND o.transaction_status = 2
          LIMIT 1
      `, [userId, productId]);

      if (checkRows.length === 0) {
          return res.status(403).json({ error: 'Không có quyền đánh giá' });
      }

      // Lưu đánh giá
      await pool.query(`
          INSERT INTO reviews (id_order_detail, content, start, create_date)
          VALUES (?, ?, ?, NOW())
      `, [checkRows[0].id, content, stars]);

      res.json({ success: true });
  } catch (error) {
      res.status(500).json({ error: 'Lỗi server' });
  }
});

// Kiểm tra người dùng đã đánh giá sản phẩm chưa
router.get("/check-reviewed", async (req, res) => {
  const { userId, productId } = req.query;
  
  if (!userId || !productId) {
      return res.status(400).json({ error: "Thiếu userId hoặc productId" });
  }

  try {
      const [rows] = await pool.execute(
          "SELECT id_order_detail FROM reviews WHERE id_order_detail IN (SELECT id FROM order_detail WHERE pr_id = ? AND order_id IN (SELECT id FROM `order` WHERE user_id = ?))",
          [productId, userId]
      );

      if (rows.length > 0) {
          return res.json({ reviewed: true });
      }

      res.json({ reviewed: false });
  } catch (error) {
      console.error("Lỗi kiểm tra đánh giá:", error);
      res.status(500).json({ error: "Lỗi server" });
  }
});

// Lấy danh sách review
router.get('/product-reviews', async (req, res) => {
  const { productId } = req.query;

  try {
      const [reviews] = await pool.query(`
          SELECT 
              r.content,
              r.start AS rating,
              r.create_date AS reviewDate,
              od.pr_id AS productId,
              p.name AS productName,
              u.username AS userName,
              u.avatar AS userAvatar
          FROM 
              reviews r
          JOIN 
              order_detail od ON r.id_order_detail = od.id
          JOIN 
              product p ON od.pr_id = p.id
          JOIN 
              \`order\` o ON od.order_id = o.id
          JOIN 
              user u ON o.user_id = u.id
          WHERE 
              od.pr_id = ?
              AND r.status = 1  -- Chỉ lấy review đã được duyệt (nếu có)
          ORDER BY 
              r.create_date DESC
      `, [productId]);

      res.json({
          success: true,
          data: reviews
      });
  } catch (error) {
      console.error('Lỗi khi lấy đánh giá:', error);
      res.status(500).json({ 
          success: false,
          error: 'Đã xảy ra lỗi khi lấy đánh giá sản phẩm' 
      });
  }
});

// API lấy tổng số sao của sản phẩm
router.get("/average-rating/:productId", async (req, res) => {
    const productId = req.params.productId;
  
    if (!productId || isNaN(productId)) {
      return res.status(400).json({ error: "productId không hợp lệ" });
    }
  
    const sql = `
    SELECT 
        SUM(r.start) / COUNT(*) AS average_rating, 
        COUNT(*) AS total_reviews
    FROM reviews r
    JOIN order_detail od ON r.id_order_detail = od.id
    WHERE od.pr_id = ?;
  `;
  
    try {
      const [rows] = await pool.query(sql, [productId]);
  
      // Nếu không có đánh giá nào
      if (rows.length === 0) {
        return res.json({ average_rating: 0, total_reviews: 0 });
      }
  
      // Lấy giá trị trung bình sao & tổng số đánh giá
      const averageRating = parseFloat(rows[0].average_rating).toFixed(1);
      const totalReviews = rows[0].total_reviews;
  
      res.json({ average_rating: averageRating, total_reviews: totalReviews });
  
    } catch (err) {
      console.error("Lỗi truy vấn:", err);
      res.status(500).json({ error: "Lỗi server" });
    }
  });


module.exports = router;
