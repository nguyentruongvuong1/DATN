var express = require('express');
var router = express.Router();
var pool = require('../../database/db'); // Đảm bảo đã sử dụng mysql2/promise

// API CATE------------------------------------------------------------------------------------------------------------------------------------------
// API lấy danh sách cate
router.get('/cate', async function (req, res, next) {
    try {
        const [results] = await pool.execute('SELECT * FROM cate'); // Sử dụng execute
        res.json(results);
    } catch (err) {
        console.error('Lỗi truy vấn dữ liệu:', err);
        res.status(500).json({ error: 'Không thể lấy dữ liệu' });
    }
});

// API xóa cate
router.delete('/cate/:id', async (req, res) => {
    const { id } = req.params;
    const sql = "DELETE FROM cate WHERE id = ?";

    try {
        const [result] = await pool.query(sql, [id]); // Dùng query vẫn hoạt động
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Cate không tồn tại!" });
        }
        res.json({ message: "Xóa cate thành công!" });
    } catch (err) {
        console.error("Lỗi xóa cate:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});


// API cập nhật cate
router.put('/cate/:id', async (req, res) => {
    const { id } = req.params;
    const { name, create_date, status } = req.body;

    try {
        // Kiểm tra cate có tồn tại không
        const [rows] = await pool.query("SELECT * FROM cate WHERE id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "Cate không tồn tại" });
        }

        // Lấy dữ liệu cũ nếu không có dữ liệu mới
        const oldData = rows[0]; // Dữ liệu truy vấn được
        const updatedName = name || oldData.name;
        const updatedDate = create_date || oldData.create_date;
        const updatedStatus = status ?? oldData.status;

        // Cập nhật dữ liệu
        const [updateResult] = await pool.query(
            "UPDATE cate SET name=?, create_date=?, status=? WHERE id=?",
            [updatedName, updatedDate, updatedStatus, id]
        );

        res.json({ message: "Cập nhật cate thành công!" });
    } catch (err) {
        console.error("Lỗi cập nhật cate:", err);
        res.status(500).json({ message: "Lỗi server", error: err });
    }
});


// API thêm cate
router.post('/cate', async (req, res) => {
    const { name, status } = req.body;

    if (!name) {
        return res.status(400).json({ message: "Tên danh mục không được để trống" });
    }

    const sql = "INSERT INTO cate (name, status) VALUES (?, ?)";

    try {
        const [result] = await pool.query(sql, [name, status ?? 1]); // Mặc định status = 1 nếu không có
        res.json({ message: "Thêm danh mục thành công!", id: result.insertId });
    } catch (err) {
        console.error("Lỗi khi thêm danh mục:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});

// API characteristic------------------------------------------------------------------------------------------------------------------------------------------
router.get('/characteristic', async function (req, res, next) {
    try {
        const [results] = await pool.execute(`
            SELECT characteristic.id, cate.name AS cate_name, characteristic.name, characteristic.create_at 
            FROM characteristic 
            JOIN cate ON characteristic.cate_id = cate.id
    `);
        res.json(results);
    } catch (err) {
        console.error('Lỗi truy vấn dữ liệu:', err);
        res.status(500).json({ error: 'Không thể lấy dữ liệu' });
    }
});

// API xóa characteristic
router.delete('/characteristic/:id', async (req, res) => {
    const { id } = req.params;
    const sql = "DELETE FROM characteristic WHERE id = ?";

    try {
        const [result] = await pool.query(sql, [id]); // Dùng query vẫn hoạt động
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Cate không tồn tại!" });
        }
        res.json({ message: "Xóa characteristic thành công!" });
    } catch (err) {
        console.error("Lỗi xóa characteristic:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});


// API cập nhật characteristic
router.put('/characteristic/:id', async (req, res) => {
    const { id } = req.params;
    const { name, create_date } = req.body; // Không có status vì bảng không có cột này

    try {
        // Kiểm tra characteristic có tồn tại không
        const [rows] = await pool.query("SELECT * FROM characteristic WHERE id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "characteristic không tồn tại" });
        }

        // Lấy dữ liệu cũ nếu không có dữ liệu mới
        const oldData = rows[0]; // Dữ liệu truy vấn được
        const updatedName = name || oldData.name;
        const updatedDate = create_date || oldData.create_at; // Đổi create_date thành create_at cho đúng

        // Cập nhật dữ liệu
        const [updateResult] = await pool.query(
            "UPDATE characteristic SET name=?, create_at=? WHERE id=?",
            [updatedName, updatedDate, id] // Bỏ status vì không có trong bảng characteristic
        );

        res.json({ message: "Cập nhật characteristic thành công!" });
    } catch (err) {
        console.error("Lỗi cập nhật characteristic:", err);
        res.status(500).json({ message: "Lỗi server", error: err });
    }
});

// API thêm characteristic
router.post('/characteristic', async (req, res) => {
    const { name, cate_id } = req.body;

    if (!name || !cate_id) {
        return res.status(400).json({ message: "Tên và ID danh mục không được để trống" });
    }

    const sql = "INSERT INTO characteristic (name, cate_id, create_at) VALUES (?, ?, NOW())";

    try {
        const [result] = await pool.query(sql, [name, cate_id]);
        res.json({ message: "Thêm characteristic thành công!", id: result.insertId });
    } catch (err) {
        console.error("Lỗi khi thêm characteristic:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});

// API typecate------------------------------------------------------------------------------------------------------------------------------------------
router.get('/typecate', async function (req, res) {
    try {
        const [results] = await pool.execute(`
            SELECT 
                type_cate.id, 
                characteristic.name AS characteristic_name, 
                type_cate.name , 
                type_cate.image, 
                type_cate.create_at, 
                type_cate.content 
            FROM type_cate
            JOIN characteristic ON type_cate.characteristic_id = characteristic.id
        `);
        res.json(results);
    } catch (err) {
        console.error('Lỗi truy vấn dữ liệu:', err);
        res.status(500).json({ error: 'Không thể lấy dữ liệu' });
    }
});



// API xóa typecate
router.delete('/typecate/:id', async (req, res) => {
    const { id } = req.params;
    const sql = "DELETE FROM type_cate WHERE id = ?";

    try {
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Type Cate không tồn tại!" });
        }
        res.json({ message: "Xóa Type Cate thành công!" });
    } catch (err) {
        console.error("Lỗi xóa Type Cate:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});



// API cập nhật typecate
router.put('/typecate/:id', async (req, res) => {
    const { id } = req.params;
    const { characteristic_id, name, image, create_at, content } = req.body;

    try {
        // Kiểm tra typecate có tồn tại không
        const [rows] = await pool.query("SELECT * FROM type_cate WHERE id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "typecate không tồn tại" });
        }

        // Lấy dữ liệu cũ nếu không có dữ liệu mới
        const oldData = rows[0];
        const updatedCharacteristicId = characteristic_id || oldData.characteristic_id;
        const updatedName = name || oldData.name;
        const updatedImage = image || oldData.image;
        const updatedCreateAt = create_at || oldData.create_at;
        const updatedContent = content || oldData.content;

        // Cập nhật dữ liệu
        const [updateResult] = await pool.query(
            "UPDATE type_cate SET characteristic_id=?, name=?, image=?, create_at=?, content=? WHERE id=?",
            [updatedCharacteristicId, updatedName, updatedImage, updatedCreateAt, updatedContent, id]
        );

        res.json({ message: "Cập nhật typecate thành công!" });
    } catch (err) {
        console.error("Lỗi cập nhật typecate:", err);
        res.status(500).json({ message: "Lỗi server", error: err });
    }
});

// API thêm typecate
router.post('/typecate', async (req, res) => {
    const { characteristic_id, name, image, content } = req.body;

    if (!characteristic_id || !name) {
        return res.status(400).json({ message: "ID đặc điểm và tên không được để trống" });
    }

    const sql = "INSERT INTO type_cate (characteristic_id, name, image, create_at, content) VALUES (?, ?, ?, NOW(), ?)";

    try {
        const [result] = await pool.query(sql, [characteristic_id, name, image, content]);
        res.json({ message: "Thêm Type Cate thành công!", id: result.insertId });
    } catch (err) {
        console.error("Lỗi khi thêm Type Cate:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});



// API VOUCHER------------------------------------------------------------------------------------------------------------------------------------------
// API lấy danh sách voucher
router.get('/voucher', async function (req, res, next) {
    try {
        const [results] = await pool.query('SELECT * FROM voucher');
        res.json(results);
    } catch (err) {
        console.error('Lỗi truy vấn dữ liệu:', err);
        res.status(500).json({ error: 'Không thể lấy dữ liệu' });
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

// API COMMENT------------------------------------------------------------------------------------------------------------------------------------------
router.get('/comment', async function (req, res) {
    try {
        const [results] = await pool.query(`
            SELECT 
                comment.id,
                user.username AS user_name,
                product.name AS product_name,
                comment.content,
                comment.comment_date,
                comment.status
            FROM comment
            JOIN user ON comment.user_id = user.id
            JOIN product ON comment.pr_id = product.id;
        `);
        res.json(results);
    } catch (err) {
        console.error('Lỗi truy vấn dữ liệu:', err);
        res.status(500).json({ error: 'Không thể lấy dữ liệu' });
    }
});

// API cập nhật trạng thái comment (ẩn/hiện)
router.put('/comment/:id/status', async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;

    if (status !== 0 && status !== 1) {
        return res.status(400).json({ message: 'Trạng thái không hợp lệ!' });
    }

    try {
        const [rows] = await pool.query('SELECT * FROM comment WHERE id = ?', [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: 'Bình luận không tồn tại' });
        }

        await pool.query('UPDATE comment SET status = ? WHERE id = ?', [status, id]);
        res.json({ message: 'Cập nhật trạng thái thành công!' });
    } catch (err) {
        console.error('Lỗi cập nhật trạng thái:', err);
        res.status(500).json({ message: 'Lỗi server', error: err });
    }
});

// API PRODUCT------------------------------------------------------------------------------------------------------------------------------------------
// API lấy danh sách sản phẩm với phân trang
router.get("/products/", async (req, res) => {
    const { sort, page = 1, limit = 8 } = req.query; // Thêm tham số phân trang
    
    // Validate input
    const pageNumber = parseInt(page);
    const limitNumber = parseInt(limit);
    if (isNaN(pageNumber) || isNaN(limitNumber) || pageNumber < 1 || limitNumber < 1) {
        return res.status(400).json({ message: "Tham số phân trang không hợp lệ" });
    }

    const offset = (pageNumber - 1) * limitNumber;

    try {
        // Query lấy dữ liệu sản phẩm
        const [products] = await pool.query(`
            SELECT p.*, 
                   c.name AS category_name, 
                   ch.name AS characteristic_name, 
                   t.name AS type_name
            FROM product p
            LEFT JOIN cate c ON p.cate_id = c.id
            LEFT JOIN characteristic ch ON ch.cate_id = c.id
            LEFT JOIN type_cate t ON ch.id = t.characteristic_id
            LIMIT ? OFFSET ?
        `, [ limitNumber, offset]);

        // Query lấy tổng số sản phẩm
        const [[totalResult]] = await pool.query(`
            SELECT COUNT(*) as total
            FROM product 
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

// API cập nhật sản phẩm
router.put('/product/:id', async (req, res) => {
    const { id } = req.params;
    const { name, price, sale, price_sale, images, description, inventory_quantity, view, status, category_id, characteristic_id, type_id } = req.body;

    try {
        const [rows] = await pool.query("SELECT * FROM product WHERE id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "Sản phẩm không tồn tại" });
        }

        const [updateResult] = await pool.query(
            "UPDATE product SET name=?, price=?, sale=?, price_sale=?, images=?, description=?, inventory_quantity=?, view=?, status=?, cate_id=?, characteristic_id=?, type_id=? WHERE id=?",
            [name, price, sale, price_sale, images, description, inventory_quantity, view, status, category_id, characteristic_id, type_id, id]
        );

        res.json({ message: "Cập nhật sản phẩm thành công!", affectedRows: updateResult.affectedRows });
    } catch (err) {
        console.error("Lỗi cập nhật sản phẩm:", err);
        res.status(500).json({ message: "Lỗi server", error: err });
    }
});


// API xóa sản phẩm
router.delete('/product/:id', async (req, res) => {
    const { id } = req.params;
    const sql = "DELETE FROM product WHERE id = ?";

    try {
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Sản phẩm không tồn tại!" });
        }

        res.json({ message: "Xóa sản phẩm thành công!", affectedRows: result.affectedRows });
    } catch (err) {
        console.error("Lỗi xóa sản phẩm:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});

// API thêm sản phẩm
router.post('/product', async (req, res) => {
    const { name, price, sale, price_sale, images, description, inventory_quantity, view, status } = req.body;
    if (!name || price == null || sale == null || price_sale == null || !images || !description || inventory_quantity == null || view == null || status == null) {
        return res.status(400).json({ message: "Thiếu dữ liệu đầu vào!" });
    }

    const sql = "INSERT INTO product (name, price, sale, price_sale, images, description, inventory_quantity, view, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try {
        const [result] = await pool.query(sql, [name, price, sale, price_sale, images, description, inventory_quantity, view, status]);
        if (result.affectedRows === 0) {
            return res.status(500).json({ message: "Không thể thêm sản phẩm!" });
        }

        res.json({ message: "Thêm sản phẩm thành công!", id: result.insertId });
    } catch (err) {
        console.error("Lỗi thêm sản phẩm:", err);
        return res.status(500).json({ message: "Lỗi server", error: err });
    }
});

module.exports = router;
