var express = require('express');
var router = express.Router();
var pool = require('../../database/db')


// Lấy danh mục
router.get("/cate", async (req, res) => {
    const sql = `SELECT * FROM cate`;

    try {
        const [data] = await pool.query(sql);

        res.json(data);
    } catch (err) {
        console.error("Lỗi lấy danh mục:", err);
        res.status(500).json({ thongbao: "Lỗi lấy danh mục", error: err });
    }
});

// lấy danh mục dựa trên id pr
router.get("/namecate/:productId", async (req, res) => {
    const { productId } = req.params; // Lấy ID sản phẩm từ URL

    const sql = `
        SELECT c.id AS cate_id, c.name AS cate_name
        FROM product p
        JOIN cate c ON p.cate_id = c.id
        WHERE p.id = ?`;

    try {
        const [data] = await pool.query(sql, [productId]);

        if (data.length === 0) {
            return res.status(404).json({ thongbao: "Không tìm thấy danh mục cho sản phẩm này" });
        }

        res.json(data[0]); // Trả về thông tin danh mục
    } catch (err) {
        console.error("Lỗi lấy danh mục:", err);
        res.status(500).json({ thongbao: "Lỗi lấy danh mục", error: err });
    }
});


// Lấy danh mục theo id

router.get("/cate/:id", async (req, res) => {
    const {id} = req.params;

    try {
    const sql = `SELECT * FROM cate WHERE id = ? `;
        const [data] = await pool.query(sql, [id]);

        res.json(data[0]);
    } catch (err) {
        console.error("Lỗi lấy danh mục:", err);
        res.status(500).json({ thongbao: "Lỗi lấy danh mục", error: err });
    }
});

// Lấy type_cate dựa trrn id  cate

router.get("/type_cate_by_cate/:cate_id", async (req, res) => {
    const { cate_id } = req.params;

    const sql = `
        SELECT 
            tc.id AS type_cate_id, 
            tc.name AS type_cate_name,
            tc.image,
            tc.content
        FROM type_cate tc
        INNER JOIN characteristic ch ON tc.characteristic_id = ch.id
        WHERE ch.cate_id = ?
    `;

    try {
        const [data] = await pool.query(sql, [cate_id]);
        res.json(data);
    } catch (err) {
        console.error("Lỗi lấy type_cate:", err);
        res.status(500).json({ message: "Lỗi lấy type_cate", error: err });
    }
});



// lấy loại cây của danh mục dụa trên id của type_cate
router.get("/categories_with_type_cate", async (req, res) => {
    const sql = `
        SELECT 
            c.id AS cate_id, 
            c.name AS cate_name, 
            tc.id AS type_cate_id, 
            tc.name AS type_cate_name
        FROM cate c
        LEFT JOIN characteristic ch ON c.id = ch.cate_id
        LEFT JOIN type_cate tc ON ch.id = tc.characteristic_id
    `;

    try {
        const [data] = await pool.query(sql);
        // Nhóm theo danh mục cha (cate)
        let categories = {};
        data.forEach(row => {
            if (!categories[row.cate_id]) {
                categories[row.cate_id] = {
                    id: row.cate_id,
                    name: row.cate_name,
                    type_cate: []
                };
            }
            if (row.type_cate_id) {
                categories[row.cate_id].type_cate.push({
                    id: row.type_cate_id,
                    name: row.type_cate_name
                });
            }
        });

        res.json(Object.values(categories));
    } catch (err) {
        console.error("Lỗi lấy danh mục:", err);
        res.status(500).json({ message: "Lỗi lấy danh mục", error: err });
    }
});

// Lấy loại cây

router.get("/type_cate/:id", async (req, res) => {
    const id = req.params.id;
    const sql = `
        SELECT tc.*, ch.cate_id 
        FROM type_cate tc
        JOIN characteristic ch ON tc.characteristic_id = ch.id
        WHERE tc.id = ?
    `;

    try {
        const [data] = await pool.query(sql, [id]);
        
        if (data.length === 0) {
            return res.status(404).json({ message: "Không tìm thấy loại danh mục" });
        }

        res.json(data[0]); // Trả về thông tin type_cate kèm cate_id
    } catch (err) {
        console.error("Lỗi lấy loại danh mục:", err);
        res.status(500).json({ message: "Lỗi lấy loại danh mục", error: err });
    }
});
// 



// Lấy đặc điểm danh mục và loại cây

router.get("/characteristics/:cate_id", async (req, res) => {
    const cate_id = req.params.cate_id;

    // Kiểm tra cate_id có hợp lệ không
    if (isNaN(cate_id)) {
        return res.status(400).json({ error: "cate_id không hợp lệ" });
    }

    const sql = `
        SELECT 
            ch.id AS characteristic_id, 
            ch.name AS characteristic_name, 
            tc.id AS type_cate_id, 
            tc.name AS type_cate_name
        FROM characteristic ch
        LEFT JOIN type_cate tc ON ch.id = tc.characteristic_id
        WHERE ch.cate_id = ?;
    `;

    try {
        const [data] = await pool.query(sql, [cate_id]);

        if (data.length === 0) {
            return res.status(404).json({ message: "Không tìm thấy dữ liệu" });
        }

        // Định dạng dữ liệu theo nhóm characteristic
        let result = {};
        data.forEach(row => {
            let { characteristic_id, characteristic_name, type_cate_id, type_cate_name } = row;

            if (!result[characteristic_id]) {
                result[characteristic_id] = {
                    characteristic_id,
                    characteristic_name,
                    type_cates: []
                };
            }

            if (type_cate_id) {
                result[characteristic_id].type_cates.push({
                    type_cate_id,
                    type_cate_name
                });
            }
        });

        res.json(Object.values(result));
    } catch (err) {
        console.error("Lỗi truy vấn:", err);
        res.status(500).json({ error: `Lỗi truy vấn: ${err.message}` });
    }
});


// Lấy loại của cây
// router.get("/type_cate/top", async (req, res) => {
//     const sql = `
//         SELECT 
//             tc.id AS type_cate_id, 
//             tc.name AS type_cate_name, 
//             SUM(od.quantity) AS total_sold
//         FROM order_detail od
//         JOIN product p ON od.pr_id = p.id
//         JOIN product_type_cate ptc ON p.id = ptc.pr_id
//         JOIN type_cate tc ON ptc.type_cate_id = tc.id
//         GROUP BY tc.id, tc.name
//         ORDER BY total_sold DESC
//         LIMIT 1
//     `;

//     try {
//         const [data] = await pool.query(sql);

//         if (data.length === 0) {
//             return res.status(404).json({ message: "Không có loại cây nào được bán" });
//         }

//         res.json(data[0]); // Trả về loại cây bán chạy nhất
//     } catch (err) {
//         console.error("Lỗi truy vấn:", err);
//         res.status(500).json({ error: `Lỗi truy vấn: ${err.message}` });
//     }
// });

// Lấy tất cả  loại cây có trong product

router.get("/type_cate/:id_pr", async (req, res) => {
    const id_pr = req.params.id_pr;
    const sql = `
        SELECT tc.id AS type_cate_id, tc.name AS type_cate_name
        FROM product_type_cate ptc
        JOIN type_cate tc ON ptc.type_cate_id = tc.id
        WHERE ptc.pr_id = ?
    `;

    try {
        const [data] = await pool.query(sql, [id_pr]);

        if (data.length === 0) {
            return res.status(404).json({ message: "Không tìm thấy loại cây cho sản phẩm này" });
        }

        res.json(data);
    } catch (err) {
        console.error("Lỗi truy vấn:", err);
        res.status(500).json({ error: `Lỗi truy vấn: ${err.message}` });
    }
});




module.exports = router;