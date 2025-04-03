var express = require('express');
var router = express.Router();
var pool = require('../../database/db')

router.get('/', async (req, res) => {
    try {
        const [result] = await pool.query("SELECT image FROM banner WHERE status = 1 ORDER BY create_date DESC");
        res.json(result);
    } catch (error) {
        console.error("Lỗi truy vấn banner:", error);
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;