var express = require('express');
var router = express.Router();
var pool = require('../../database/db')

//lấy toàn bộ bài viết
router.get('/', async (req, res, next) => {
    try {
        const [rows] = await pool.query(`SELECT * FROM blog ORDER BY id DESC`);
        return res.status(200).json({
            message: "Lấy danh sách blog thành công",
            data: rows
        });
    } catch (error) {
        console.error("Lỗi khi lấy danh sách blog:", error);
        res.status(500).json({ error: error.message });
    }
});


//Lấy chi tiết bài viết
router.get('/:id', async (req, res, next) => {
    try {
        const { id } = req.params;
        const [rows] = await pool.query(`SELECT * FROM blog WHERE id = ?`, [id]);

        if (rows.length === 0) {
            return res.status(404).json({ message: "Không tìm thấy blog" });
        }

        return res.status(200).json({
            message: "Lấy chi tiết blog thành công",
            data: rows[0]
        });
    } catch (error) {
        console.error("Lỗi khi lấy chi tiết blog:", error);
        res.status(500).json({ error: error.message });
    }
});

//Tạo bài viết
router.post('/create', async (req, res, next) => {
    try {
        const { title, content, description, logo } = req.body;
        const [result] = await pool.query(`INSERT INTO blog (title,content,description,logo) VALUES (?,?,?,?)`, [title, content, description, logo]);
        return res.status(200).json({ message: "Da tao thanh cong blog", result: result })
    } catch (error) {
        console.error("Lỗi khi tao blog:", error);
        res.status(500).json({ error: error.message });
    }
});

// fake data -- k lien quan
router.post('/create-multiple', async (req, res) => {
    const blogs = req.body; // expect array of blogs

    const query = `INSERT INTO blog (title, content, description, logo) VALUES ?`;
    const values = blogs.map(blog => [blog.title, blog.content, blog.description, blog.logo]);

    try {
        const [result] = await pool.query(query, [values]);
        res.status(200).json({ message: "Đã thêm thành công!", inserted: result.affectedRows });
    } catch (err) {
        console.error("Lỗi khi thêm blog:", err);
        res.status(500).json({ error: err.message });
    }
});

//cập nhật bài viết theo Id
router.put('/:id', async (req, res, next) => {
    try {
        const { id } = req.params;
        const { title, content, description, logo } = req.body;

        const [result] = await pool.query(
            `UPDATE blog SET title = ?, content = ?, description = ?, logo = ? WHERE id = ?`,
            [title, content, description, logo, id]
        );

        return res.status(200).json({
            message: "Đã cập nhật thành công blog",
            affectedRows: result.affectedRows
        });
    } catch (error) {
        console.error("Lỗi khi cập nhật blog:", error);
        res.status(500).json({ error: error.message });
    }
});

//Xóa bài viets theo ID
router.delete('/:id', async (req, res, next) => {
    try {
        const { id } = req.params;

        const [result] = await pool.query(
            `DELETE FROM blog WHERE id = ?`,
            [id]
        );

        return res.status(200).json({
            message: "Đã xoá thành công blog",
            affectedRows: result.affectedRows
        });
    } catch (error) {
        console.error("Lỗi khi xoá blog:", error);
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;