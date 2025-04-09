const mysql = require('mysql2/promise');

const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'greentree',
    waitForConnections: true,
    connectionLimit: 10, // Giới hạn tối đa 10 kết nối đồng thời
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