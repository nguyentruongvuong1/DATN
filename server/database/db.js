const mysql = require('mysql2/promise');

const db = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'haid5122003',
    database: process.env.DB_NAME || 'greentree',
    waitForConnections: true,
    connectionLimit: parseInt(process.env.DB_CONNECTION_LIMIT, 10),
    queueLimit: 0
});

// Kiểm tra kết nối
db.getConnection()
    .then(conn => {
        console.log('Kết nối MySQL thành công!');
        conn.release(); // Giải phóng kết nối sau khi kiểm tra
    })
    .catch(err => console.error('Lỗi kết nối MySQL:', err));

module.exports = db;