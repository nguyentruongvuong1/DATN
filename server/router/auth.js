const jwt = require('jsonwebtoken'); // Đổi thành 'jsonwebtoken'
const fs = require('fs');
const PRIVATE_KEY = fs.readFileSync('private-key.txt', 'utf8');
const roleAdmin = 0;
exports.adminAuth = (req, res, next) => {
    let token = req.headers.authorization;
    if (!token) {
        return res.status(401).json({ thongbao: 'Không có token không phận sự miễn vào' });
    }
    token = token.split(' ')[1];
    jwt.verify(token, PRIVATE_KEY,{ algorithms: ["RS256"] }, (err, datadDecoded) => {
        if (err) return res.status(401).json({ thongbao: 'Lỗi Token: ' + err });
        if (datadDecoded.role !== roleAdmin) {
            return res.status(401).json({ thongbao: 'Bạn không đủ quyền để vào' });
        } else {
            next();
        }
    });
};





