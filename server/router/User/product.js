var express = require('express');
var router = express.Router();
var pool = require('../../database/db');
const { route } = require('.');

// lấy sản phẩm
router.get('/pr', async (req, res) =>{
    try{
        
        const [result] = await pool.query(`SELECT * FROM product`);
            res.json(result);

    }catch(error){
        console.error("Lỗi truy vấn:", error);
        res.status(500).json({ message: "Lỗi server" });
    }
})


// Laays sanr phaamr hot
router.get("/prhot", async (req, res) => {
    try {
      const [products] = await pool.query("SELECT * FROM product ORDER BY view DESC LIMIT 8");
      res.json(products);
    } catch (error) {
      console.error("Lỗi truy vấn:", error);
      res.status(500).json({ message: "Lỗi server" });
    }
  });
// Lấy danh mục sản phẩm có sản phẩm
  router.get('/categories-with-products', async (req, res) => {
    try {
      // Lấy tất cả danh mục
      const [categories] = await pool.query('SELECT * FROM cate WHERE status = 1 ORDER BY create_date DESC');
      
      // Lấy sản phẩm cho từng danh mục
      const categoriesWithProducts = await Promise.all(
        categories.map(async (category) => {
          const [products] = await pool.query(`
            SELECT p.* 
            FROM product p 
            WHERE p.cate_id = ? AND p.status = 1 
            ORDER BY p.view DESC 
            LIMIT 4
          `, [category.id]);
          
          return {
            ...category,
            products: products.map(product => ({
              ...product,
              // Format giá nếu cần
              price: Number(product.price),
              price_sale: Number(product.price_sale)
            }))
          };
        })
      );
  
      res.json(categoriesWithProducts);
    } catch (error) {
      console.error('Error fetching categories with products:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

// Lấy sản phẩm mới 
router.get("/prnew", async (req, res) => {
    try {
      const [products] = await pool.query("SELECT * FROM product ORDER BY create_date DESC LIMIT 8");
      res.json(products);
    } catch (error) {
      console.error("Lỗi truy vấn:", error);
      res.status(500).json({ message: "Lỗi server" });
    }
  }); 

  router.get("/prsale", async (req, res) => {
    try {
      const [products] = await pool.query("SELECT * FROM product ORDER BY sale DESC LIMIT 8");
      res.json(products);
    } catch (error) {
      console.error("Lỗi truy vấn:", error);
      res.status(500).json({ message: "Lỗi server" });
    }
  }); 


router.get('/detailPr/:id', async (req, res) => {
    try {
        let id = req.params.id;

        let sql = `
          SELECT p.*, 
            GROUP_CONCAT(DISTINCT JSON_OBJECT('id', tc.id, 'name', tc.name)) AS type_cate
        FROM product p
        LEFT JOIN product_type_cate ptc ON p.id = ptc.pr_id
        LEFT JOIN type_cate tc ON ptc.type_cate_id = tc.id
        WHERE p.id = ?
        GROUP BY p.id
        `;

        const [rows] = await pool.query(sql, [id]);

        if (rows.length === 0) {
            return res.status(404).json({ message: "Sản phẩm không tồn tại" });
        }

        let result = rows[0];
        // Xử lý type_cate
        result.type_cate = result.type_cate ? JSON.parse(`[${result.type_cate}]`) : [];

        res.json(result);

    } catch (err) {
        console.error("Lỗi truy vấn:", err);
        res.status(500).json({ message: "Lỗi lấy chi tiết sản phẩm", error: err.message });
    }
});

// Lấy sản phẩm liên quan
router.get('/prlq/:id', async (req, res) => {
    const id = parseInt(req.params.id, 10); // Đảm bảo id là số nguyên
    
    if (isNaN(id)) {
        return res.status(400).json({ message: "ID sản phẩm không hợp lệ" });
    }

    try {
        const sql = `
            SELECT * FROM product 
            WHERE cate_id = (SELECT cate_id FROM product WHERE id = ?) 
            AND id != ? 
            AND status = 1 
            ORDER BY view DESC 
            LIMIT 8
        `;

        const [result] = await pool.query(sql, [id, id]);
        res.json(result);
    } catch (err) {
        console.error("Lỗi truy vấn:", err);
        res.status(500).json({ message: "Lỗi lấy chi tiết sản phẩm", error: err.message });
    }
});

// 
 router.get('/pr/:cate_id', async(req, res) =>{
    const {cate_id} = req.params;
    
    try{
        const sql = `SELECT * FROM product WHERE cate_id = ? AND status = 1 ORDER BY view desc `;
        const [result] = await pool.query(sql, [cate_id]);
         res.json(result)
        
    }catch (err) {
        console.error("Lỗi truy vấn:", err);
        res.status(500).json({ message: "Lỗi lấy chi tiết sản phẩm", error: err.message });
    }
})

// Lấy sản phẩm theo type_cate
router.get("/products-by-type/:type_cate_id", async (req, res) => {
    const { type_cate_id } = req.params;
    const { sort, page = 1, limit = 8, minPrice, maxPrice } = req.query; // Thêm tham số lọc giá
    
    // Validate input
    const pageNumber = parseInt(page);
    const limitNumber = parseInt(limit);
    if (isNaN(pageNumber) || isNaN(limitNumber) || pageNumber < 1 || limitNumber < 1) {
        return res.status(400).json({ message: "Tham số phân trang không hợp lệ" });
    }

    // Validate price filter
    let minPriceValue = minPrice ? parseFloat(minPrice) : null;
    let maxPriceValue = maxPrice ? parseFloat(maxPrice) : null;
    
    if ((minPrice && isNaN(minPriceValue))) {
        return res.status(400).json({ message: "Giá tối thiểu không hợp lệ" });
    }
    if ((maxPrice && isNaN(maxPriceValue))) {
        return res.status(400).json({ message: "Giá tối đa không hợp lệ" });
    }
    if (minPriceValue !== null && maxPriceValue !== null && minPriceValue > maxPriceValue) {
        return res.status(400).json({ message: "Khoảng giá không hợp lệ" });
    }

    const offset = (pageNumber - 1) * limitNumber;

    let orderBy = "p.create_date DESC";
    if (sort === "price_asc") orderBy = "p.price ASC";
    else if (sort === "price_desc") orderBy = "p.price DESC";
    else if (sort === "view") orderBy = "p.view DESC";

    try {
        // Base query conditions
        let queryConditions = "ptc.type_cate_id = ?";
        const queryParams = [type_cate_id];
        
        // Add price filter conditions if provided
        if (minPriceValue !== null && maxPriceValue !== null) {
            queryConditions += " AND p.price BETWEEN ? AND ?";
            queryParams.push(minPriceValue, maxPriceValue);
        } else if (minPriceValue !== null) {
            queryConditions += " AND p.price >= ?";
            queryParams.push(minPriceValue);
        } else if (maxPriceValue !== null) {
            queryConditions += " AND p.price <= ?";
            queryParams.push(maxPriceValue);
        }

        // Query lấy dữ liệu sản phẩm
        const [products] = await pool.query(`
            SELECT p.*
            FROM product p
            JOIN product_type_cate ptc ON p.id = ptc.pr_id
            WHERE ${queryConditions}
            ORDER BY ${orderBy}
            LIMIT ? OFFSET ?
        `, [...queryParams, limitNumber, offset]);

        // Query lấy tổng số sản phẩm
        const [[totalResult]] = await pool.query(`
            SELECT COUNT(*) as total
            FROM product p
            JOIN product_type_cate ptc ON p.id = ptc.pr_id
            WHERE ${queryConditions}
        `, queryParams);

        res.json({
            products,
            total: totalResult.total,
            page: pageNumber,
            totalPages: Math.ceil(totalResult.total / limitNumber),
            limit: limitNumber,
            minPrice: minPriceValue,
            maxPrice: maxPriceValue
        });
        
    } catch (err) {
        console.error("Lỗi lấy sản phẩm:", err);
        res.status(500).json({ message: "Lỗi lấy sản phẩm", error: err.message });
    }
});

// Lấy sản phẩm theo danh muc
router.get("/products-by-cate/:cate_id", async (req, res) => {
    const { cate_id } = req.params;
    const { sort, page = 1, limit = 8, minPrice, maxPrice } = req.query; // Thêm tham số lọc giá
    
    // Validate input
    const pageNumber = parseInt(page);
    const limitNumber = parseInt(limit);
    if (isNaN(pageNumber) || isNaN(limitNumber) || pageNumber < 1 || limitNumber < 1) {
        return res.status(400).json({ message: "Tham số phân trang không hợp lệ" });
    }

    // Validate price filter
    let minPriceValue = minPrice ? parseFloat(minPrice) : null;
    let maxPriceValue = maxPrice ? parseFloat(maxPrice) : null;
    
    if ((minPrice && isNaN(minPriceValue))) {
        return res.status(400).json({ message: "Giá tối thiểu không hợp lệ" });
    }
    if ((maxPrice && isNaN(maxPriceValue))) {
        return res.status(400).json({ message: "Giá tối đa không hợp lệ" });
    }
    if (minPriceValue !== null && maxPriceValue !== null && minPriceValue > maxPriceValue) {
        return res.status(400).json({ message: "Khoảng giá không hợp lệ" });
    }

    const offset = (pageNumber - 1) * limitNumber;

    let orderBy = "p.create_date DESC";
    if (sort === "price_asc") orderBy = "p.price ASC";
    else if (sort === "price_desc") orderBy = "p.price DESC";
    else if (sort === "view") orderBy = "p.view DESC";

    try {
        // Base query conditions
        let queryConditions = "p.cate_id = ?";
        const queryParams = [cate_id];
        
        // Add price filter conditions if provided
        if (minPriceValue !== null && maxPriceValue !== null) {
            queryConditions += " AND p.price BETWEEN ? AND ?";
            queryParams.push(minPriceValue, maxPriceValue);
        } else if (minPriceValue !== null) {
            queryConditions += " AND p.price >= ?";
            queryParams.push(minPriceValue);
        } else if (maxPriceValue !== null) {
            queryConditions += " AND p.price <= ?";
            queryParams.push(maxPriceValue);
        }

        // Query lấy dữ liệu sản phẩm theo danh mục
        const [products] = await pool.query(`
            SELECT p.*
            FROM product p
            WHERE ${queryConditions}
            ORDER BY ${orderBy}
            LIMIT ? OFFSET ?
        `, [...queryParams, limitNumber, offset]);

        // Query lấy tổng số sản phẩm trong danh mục
        const [[totalResult]] = await pool.query(`
            SELECT COUNT(*) as total
            FROM product p
            WHERE ${queryConditions}
        `, queryParams);

        res.json({
            products,
            total: totalResult.total,
            page: pageNumber,
            totalPages: Math.ceil(totalResult.total / limitNumber),
            limit: limitNumber,
            minPrice: minPriceValue,
            maxPrice: maxPriceValue
        });
        
    } catch (err) {
        console.error("Lỗi lấy sản phẩm:", err);
        res.status(500).json({ message: "Lỗi lấy sản phẩm", error: err.message });
    }
});


// trang sản phẩm yêu thích
router.post("/toggle-favorite", async (req, res) => {
    const { user_id, pr_id } = req.body;
    if (!user_id || !pr_id) return res.status(400).json({ message: "Thiếu dữ liệu" });

    try {
        // Kiểm tra xem sản phẩm đã được thích chưa
        const [rows] = await pool.execute(
            "SELECT * FROM products_favorite WHERE user_id = ? AND pr_id = ?",
            [user_id, pr_id]
        );

        if (rows.length > 0) {
            // Nếu đã thích -> Xóa
            await pool.execute("DELETE FROM products_favorite WHERE user_id = ? AND pr_id = ?", [user_id, pr_id]);
            return res.json({ success: true, message: "Đã bỏ thích", liked: false });
        } else {
            // Nếu chưa thích -> Thêm
            await pool.execute("INSERT INTO products_favorite (user_id, pr_id) VALUES (?, ?)", [user_id, pr_id]);
            return res.json({ success: true, message: "Đã thích", liked: true });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Lỗi server" });
    }
});

// ID Sản phẩm được user like
router.get('/user-favorite/:user_id', async (req, res) => {
    try {
        const user_id = req.params.user_id;
        const [likePr] = await pool.query(`SELECT pr_id FROM products_favorite WHERE user_id = ?`, [user_id]);
        res.json(likePr.map(pr => pr.pr_id)); // Đảm bảo chỉ trả về danh sách ID sản phẩm
    } catch (error) {
        console.error("Lỗi khi lấy danh sách sản phẩm yêu thích:", error);
        res.status(500).json({ message: "Lỗi server" });
    }
});

// Đếm tất cả sản phẩm có trong favorit-product
router.get('/count-pr-like/:user_id', async (req, res) =>{
    try{
        const user_id = req.params.user_id;
        const [result] = await pool.query(`SELECT COUNT(*) AS total FROM products_favorite WHERE user_id = ?`, [user_id]);
        res.json({count: result[0].total});
    }
    catch(errpr){
        console.error("Lỗi khi đếm số sản phẩm yêu thích:", error);
        res.status(500).json({ message: "Lỗi server" });
    }
})

// Lấy tất cả sản phẩm yêu thích của người dùng
router.get('/favorite_user/:user_id', async (req, res) =>{
        const user_id = req.params.user_id;    
    try{
            const sql = `SELECT p.* FROM product p INNER JOIN products_favorite pf ON p.id = pf.pr_id WHERE pf.user_id = ?`;

            const [FavoritePr] = await pool.query(sql, [user_id]);
            res.json(FavoritePr)
        }
        catch{
            console.error("Lỗi truy vấn:", error);
            res.status(500).json({ message: "Lỗi server" });
        }
});


// Lấy giá lấy nhất và nhỏ nhất của sản phẩm thuộc danh mục
router.get("/price-range_typecate/:type_cate_id", async (req, res) => {
    const { type_cate_id } = req.params;
    
    try {
        const [[result]] = await pool.query(`
            SELECT 
                MIN(p.price) as min_price, 
                MAX(p.price) as max_price
            FROM product p
            JOIN product_type_cate ptc ON p.id = ptc.pr_id
            WHERE ptc.type_cate_id = ?
        `, [type_cate_id]);
        
        res.json({
            min_price: result.min_price || 0,
            max_price: result.max_price || 0
        });
    } catch (err) {
        console.error("Lỗi lấy khoảng giá:", err);
        res.status(500).json({ message: "Lỗi lấy khoảng giá", error: err.message });
    }
});

// Giá lớn nhất và nhỏ nhất của sản phẩm thep cate
router.get("/price-range-cate/:cate_id", async (req, res) => {
    const { cate_id } = req.params;
    
    try {
        const [[result]] = await pool.query(`
            SELECT 
                MIN(p.price) as min_price, 
                MAX(p.price) as max_price
            FROM product p
            WHERE p.cate_id = ? AND p.status = 1
        `, [cate_id]);
        
        res.json({
            min_price: result.min_price || 0,
            max_price: result.max_price || 0
        });
    } catch (err) {
        console.error("Lỗi lấy khoảng giá:", err);
        res.status(500).json({ message: "Lỗi lấy khoảng giá", error: err.message });
    }
});

// Tăng lượt xem sản phẩm
router.post('/view/:id_pr', async (req, res) =>{
    const {id_pr} = req.params;
    try{
          const [result] = await pool.query(`UPDATE product SET view = view + 1 WHERE id = ?`, [id_pr]);
          res.json({message : "Đã tăng lượt xem thành công"})
  
    }catch (error) {
          res.status(500).json({ message: 'Lỗi server khi tăng lượt xem', error: error.message });
    }
  })




module.exports = router;