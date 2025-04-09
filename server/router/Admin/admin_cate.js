var express = require('express');
var router = express.Router();
var pool = require('../../database/db'); // Đảm bảo đã sử dụng mysql2/promise
var upload = require('../../multerConfig');
require('dotenv').config();
const baseUrl = process.env.BASE_URL; // Lấy từ .env

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
router.put('/cate/:id', upload.fields([
    { name: 'image', maxCount: 1 },
    { name: 'image_content', maxCount: 1 }
]), async (req, res) => {
    const { id } = req.params;
    const { name, content, status } = req.body;
    const files = req.files;

    const imageDir = path.join(__dirname, '../../public/images');

    try {
        const [rows] = await pool.query("SELECT * FROM cate WHERE id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "Danh mục không tồn tại" });
        }

        const oldData = rows[0];
        let image = oldData.image;
        let image_content = oldData.image_content;

        // --- Xử lý ảnh 'image' ---
        if (files?.image?.[0]) {
            const newFilename = path.basename(files.image[0].filename); // chỉ lấy tên file
            const oldFilename = path.basename(oldData.image); // lấy tên file cũ nếu có
            const oldImagePath = path.join(imageDir, oldFilename);

            // Xóa ảnh cũ nếu tồn tại
            if (fs.existsSync(oldImagePath)) {
                fs.unlinkSync(oldImagePath);
            }

            image = `${baseUrl}/public/images/${newFilename}`; // chỉ lưu path tương đối vào DB
        }

        // --- Xử lý ảnh 'image_content' ---
        if (files?.image_content?.[0]) {
            const newFilename = path.basename(files.image_content[0].filename);
            const oldFilename = path.basename(oldData.image_content);
            const oldImagePath = path.join(imageDir, oldFilename);

            if (fs.existsSync(oldImagePath)) {
                fs.unlinkSync(oldImagePath);
            }

            image_content = `${baseUrl}/public/images/${newFilename}`;
        }

        // --- Update DB ---
        await pool.query(
            "UPDATE cate SET name = ?, content = ?, image = ?, image_content = ?, status = ? WHERE id = ?",
            [
                name || oldData.name,
                content || oldData.content,
                image,
                image_content,
                status ?? oldData.status,
                id,
            ]
        );

        res.json({ message: "Cập nhật danh mục thành công!" });
    } catch (err) {
        console.error("Lỗi khi cập nhật danh mục:", err);
        res.status(500).json({ message: "Lỗi server", error: err.message });
    }
});


// Thêm danh mục với ảnh
router.post('/cate', upload.fields([
    { name: 'image', maxCount: 1 },
    { name: 'image_content', maxCount: 1 }
]), async (req, res) => {
    try {
        const { name, content, status } = req.body;
        const image = req.files?.image?.[0];
        const image_content = req.files?.image_content?.[0];

        // ✅ Lưu đúng chuẩn path tương đối (giống PUT)
        const imagePath = image ? `${baseUrl}/public/images/${image.filename}` : null;
        const imageContentPath = image_content ? `${baseUrl}/public/images/${image_content.filename}` : null;

        // const imagePath = image ? `../../public/images/${image.filename}` : null;
        // const imageContentPath = image_content ? `../../public/images/${image_content.filename}` : null;

        if (!name || !content) {
            return res.status(400).json({ message: "Vui lòng nhập đầy đủ tên và nội dung." });
        }

        const sql = `
            INSERT INTO cate (name, content, status, image, image_content)
            VALUES (?, ?, ?, ?, ?)
        `;

        const [result] = await pool.query(sql, [
            name,
            content,
            status ?? 1,
            imagePath,
            imageContentPath
        ]);

        return res.json({ message: "Thêm danh mục thành công!", id: result.insertId });
    } catch (err) {
        console.error("Lỗi khi thêm danh mục:", err);
        return res.status(500).json({ message: "Lỗi server", error: err.message });
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

// Lấy danh sách characteristic theo cate_id
router.get('/characteristic/:cate_id', async (req, res) => {    
    const { cate_id } = req.params;

    try {
        const [results] = await pool.execute(`
            SELECT characteristic.id, cate.name AS cate_name, characteristic.name, characteristic.create_at 
            FROM characteristic 
            JOIN cate ON characteristic.cate_id = cate.id
            WHERE characteristic.cate_id = ?
        `, [cate_id]);

        res.json(results);
    } catch (err) {
        console.error('Lỗi truy vấn dữ liệu:', err);
        res.status(500).json({ error: 'Không thể lấy dữ liệu' });
    }

})

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
        const { page = 1, limit = 8 } = req.query;
        const offset = (page - 1) * limit;

        const [results] = await pool.execute(`
            SELECT 
                type_cate.id, 
                characteristic.name AS characteristic_name, 
                type_cate.name, 
                type_cate.image, 
                type_cate.create_at, 
                type_cate.content 
            FROM type_cate
            JOIN characteristic ON type_cate.characteristic_id = characteristic.id
            LIMIT ? OFFSET ?;
        `, [parseInt(limit), parseInt(offset)]);

        const [[{ total }]] = await pool.query(`SELECT COUNT(*) AS total FROM type_cate`);

        res.json({ typecates: results, total });
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

// API lấy typecate theo characteristic_id
router.get('/type_cates/:characteristic_id', async (req, res) => {
    const { characteristic_id } = req.params;
    try {
      const [rows] = await pool.execute(
        `SELECT id, name FROM type_cate WHERE characteristic_id = ?`,
        [characteristic_id]
      );
      res.json(rows); // Trả về danh sách { id, name }
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });


// API cập nhật typecate
router.put('/typecate/:id', upload.single("image"), async (req, res) => {
    const { id } = req.params;
    const { characteristic_id, name, create_at, content } = req.body;
    const file = req.file;

    try {
        const [rows] = await pool.query("SELECT * FROM type_cate WHERE id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "typecate không tồn tại" });
        }

        const oldData = rows[0];
        const updatedImage = file ? `${baseUrl}/public/images/${file.filename}` : oldData.image;
        // Nếu có ảnh mới -> xóa ảnh cũ
        if (file && oldData.image) {
            try {
                const oldImageFileName = path.basename(oldData.image);
                const oldImagePath = path.resolve(__dirname, "../../public/images", oldImageFileName);

                if (fs.existsSync(oldImagePath)) {
                    fs.unlinkSync(oldImagePath);
                } else {
                }
            } catch (err) {
                console.error("Lỗi khi xóa ảnh cũ:", err);
            }
        }

        await pool.query(
            "UPDATE type_cate SET characteristic_id=?, name=?, image=?, create_at=?, content=? WHERE id=?",
            [
                characteristic_id || oldData.characteristic_id,
                name || oldData.name,
                updatedImage,
                create_at || oldData.create_at,
                content || oldData.content,
                id,
            ]
        );

        res.json({ message: "Cập nhật thành công", image: updatedImage });
    } catch (err) {
        console.error("Lỗi cập nhật typecate:", err);
        res.status(500).json({ message: "Lỗi server", error: err });
    }
});

// API thêm typecate
router.post('/typecate', upload.single('image'), async (req, res) => {
    const { characteristic_id, name, content } = req.body;
    const image = req.file ? `${baseUrl}/public/images/${req.file.filename}` : null;

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

module.exports = router;