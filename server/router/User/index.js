var express = require('express');
var router = express.Router();
var pool = require('../../database/db')
const bcrypt = require('bcrypt')
const saltRounds = 10;
const jwt = require('node-jsonwebtoken')
const fs = require('fs');
const { userInfo } = require('os');
const PRIVATE_KEY = fs.readFileSync('private-key.txt')
const maxAge = 3 *60 *60;
const multer = require('multer')
const nodemailer = require('nodemailer')



// Cấu hình Nodemailer
const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: "nguyentruongvuong11@gmail.com",
        pass: "dubg blqu sruj xtbs",
    },
});

// Middleware kiểm tra và xóa OTP hết hạn
const cleanupExpiredOTP = async (req, res, next) => {
    try {
      await pool.execute('DELETE FROM otp_codes WHERE expires_at < NOW()');
      next();
    } catch (err) {
      console.error('Lỗi khi dọn dẹp OTP hết hạn:', err);
      next();
    }
  };
// Đăng ký và gửi OTP
router.post('/dangky', cleanupExpiredOTP, async (req, res) => {
    try {
      const { username, email, password, phone } = req.body;
  
      // Validate input
      if (!username || !email || !password || !phone) {
        return res.status(400).json({ success: false, message: 'Vui lòng nhập đầy đủ thông tin' });
      }
  
      // Kiểm tra email tồn tại
      const [user] = await pool.execute('SELECT id FROM user WHERE email = ?', [email]);
      if (user.length && users.length > 0) {
        return res.status(400).json({ success: false, message: 'Email đã tồn tại' });
      }
  
      // Tạo và lưu OTP
      const otp = Math.floor(100000 + Math.random() * 900000).toString();
      const expiresAt = new Date(Date.now() + 3 * 60 * 1000); // 3 phút
  
      // Xóa OTP cũ nếu có
      await pool.execute('DELETE FROM otp_codes WHERE email = ?', [email]);
  
      // Lưu OTP mới
      await pool.execute(
        'INSERT INTO otp_codes (email, otp_code, expires_at) VALUES (?, ?, ?)',
        [email, otp, expiresAt]
      );
  
      // Gửi email
      await transporter.sendMail({
        from: `"Hệ thống xác minh" <${process.env.EMAIL_USER}>`,
        to: email,
        subject: 'Mã OTP đăng ký tài khoản',
        html: `
          <p>Xin chào ${username},</p>
          <p>Mã OTP của bạn là: <strong>${otp}</strong></p>
          <p>Mã có hiệu lực trong 3 phút.</p>
        `
      });
  
      res.json({ 
        success: true, 
        message: 'Mã OTP đã được gửi tới email của bạn',
        expiresAt: expiresAt.toISOString()
      });
    } catch (err) {
      console.error('Lỗi khi gửi OTP:', err);
      res.status(500).json({ success: false, message: 'Lỗi máy chủ' });
    }
  });

// Gửi lại OTP
router.post('/dangky/resend-otp', cleanupExpiredOTP, async (req, res) => {
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();
  
      const { email } = req.body;
      
      if (!email) {
        return res.status(400).json({ success: false, message: 'Email là bắt buộc' });
      }
  
      // Tạo OTP mới
      const otp = Math.floor(100000 + Math.random() * 900000).toString();
      const expiresAt = new Date(Date.now() + 1 * 60 * 1000); // 1 phút
  
      // Luôn INSERT mới thay vì UPDATE
      await connection.execute(
        'INSERT INTO otp_codes (email, otp_code, expires_at) VALUES (?, ?, ?) ' +
        'ON DUPLICATE KEY UPDATE otp_code = VALUES(otp_code), expires_at = VALUES(expires_at)',
        [email, otp, expiresAt]
      );
  
      // Gửi email
      await transporter.sendMail({
        from: `"Hệ thống xác minh" <${process.env.EMAIL_USER}>`,
        to: email,
        subject: 'Mã OTP mới của bạn',
        html: `
          <p>Mã OTP mới của bạn là: <strong>${otp}</strong></p>
          <p>Mã có hiệu lực trong 1 phút.</p>
        `
      });
  
      await connection.commit();
  
      console.log(`[OTP Resend] Đã tạo mới OTP ${otp} cho ${email}`);
  
      res.json({ 
        success: true, 
        message: 'Đã gửi lại mã OTP thành công',
        expiresAt: expiresAt.toISOString()
      });
    } catch (err) {
      await connection.rollback();
      console.error('Lỗi khi gửi lại OTP:', err);
      res.status(500).json({ success: false, message: 'Lỗi máy chủ' });
    } finally {
      connection.release();
    }
  });
  
// Xác minh OTP
router.post('/xacminhotp', cleanupExpiredOTP, async (req, res) => {
    try {
      const { username, email, password, phone, otp } = req.body;
  
      // Validate input
      if (!username || !email || !password || !phone || !otp) {
        return res.status(400).json({ success: false, message: 'Vui lòng nhập đầy đủ thông tin' });
      }
  
      // Kiểm tra OTP
      const [otpRecord] = await pool.execute(
        'SELECT otp_code, expires_at FROM otp_codes WHERE email = ? ORDER BY id DESC LIMIT 1',
        [email]
      );
  
      if (otpRecord.length === 0) {
        return res.status(400).json({ success: false, message: 'Không tìm thấy mã OTP' });
      }
  
      const { otp_code, expires_at } = otpRecord[0];
  
      // Kiểm tra hết hạn
      if (new Date(expires_at) < new Date()) {
        return res.status(400).json({ success: false, message: 'Mã OTP đã hết hạn' });
      }
  
      // Kiểm tra OTP
      if (otp !== otp_code) {
        return res.status(400).json({ success: false, message: 'Mã OTP không đúng' });
      }
  
      // Hash password
      const hashedPassword = await bcrypt.hash(password, 10);
  
      // Tạo user mới
      await pool.execute(
        'INSERT INTO user (username, email, phone, password) VALUES (?, ?, ?, ?)',
        [username, email, phone, hashedPassword]
      );
  
      // Xóa OTP đã sử dụng
      await pool.execute('DELETE FROM otp_codes WHERE email = ?', [email]);
  
      res.json({ success: true, message: 'Đăng ký thành công!' });
    } catch (err) {
      console.error('Lỗi khi xác minh OTP:', err);
      res.status(500).json({ success: false, message: 'Lỗi máy chủ' });
    }
  });

  // Kiểm tra trạng thái OTP
router.post('/xacminhotp/check-status', cleanupExpiredOTP, async (req, res) => {
    try {
      const { email } = req.body;
  
      if (!email) {
        return res.status(400).json({ success: false, message: 'Email là bắt buộc' });
      }
  
      const [otpRecord] = await pool.execute(
        'SELECT expires_at FROM otp_codes WHERE email = ? ORDER BY id DESC LIMIT 1',
        [email]
      );
  
      if (otpRecord.length === 0) {
        return res.json({ success: true, expired: true, message: 'Không tìm thấy mã OTP' });
      }
  
      const { expires_at } = otpRecord[0];
      const isExpired = new Date(expires_at) < new Date();
      const remainingTime = isExpired ? 0 : Math.round((new Date(expires_at) - new Date()) / 1000);
  
      res.json({
        success: true,
        expired: isExpired,
        remainingTime,
        message: isExpired 
          ? 'Mã OTP đã hết hạn' 
          : `Mã OTP còn hiệu lực trong ${remainingTime} giây`
      });
    } catch (err) {
      console.error('Lỗi khi kiểm tra OTP:', err);
      res.status(500).json({ success: false, message: 'Lỗi máy chủ' });
    }
  });

// Chức năng đăng nhập
router.post('/dangnhap', async (req, res) => {
    try {
        const { email, password } = req.body;

        // Kiểm tra xem email có tồn tại không
        const sql = `SELECT * FROM user WHERE email = ?`;
        const [rows] = await pool.execute(sql, [email]);

        if (rows.length === 0) {
            return res.status(401).json({ "thongbao": "Người dùng không tồn tại" });
        }

        const userInfo = rows[0];

        // So sánh mật khẩu
        const match = await bcrypt.compare(password, userInfo.password);
        if (!match) {
            return res.status(401).json({ "thongbao": "Đăng nhập thất bại" });
        }

        // Tạo JWT token
        const jwtBearToken = jwt.sign(
            { id: userInfo.id, role: userInfo.role },
            PRIVATE_KEY,
            { algorithm: 'RS256', expiresIn: maxAge, subject: userInfo.id.toString() }
        );

        res.status(200).json({
            token: jwtBearToken,
            expiresIn: maxAge,
            userInfo
        });

    } catch (err) {
        console.error("Lỗi khi đăng nhập:", err);
        res.status(500).json({ "thongbao": "Lỗi máy chủ", err });
    }
});

// Chức năng bình luận

router.post('/binh_luan', async(req, res) =>{
    try{
        const {user_id, pr_id, content, comment_date} = req.body;
        const sql = `INSERT INTO comment (user_id, pr_id, content, comment_date) VALUES (?,?,?,?)`;

        const [result] = await pool.query(sql, [user_id, pr_id, content, comment_date])
        res.json({ success: true, message: 'Thêm bình luận thành công' }); // Trả về JSON có success)
    }catch (error) {
        res.status(500).json({ error: err.message });
      }
})


// Lấy bình luận
router.get('/binh_luan/:pr_id', async (req, res) => {
    const { pr_id } = req.params;  // Sửa lỗi destructuring
    try {
        const sql = `
        SELECT c.id, c.user_id, u.username , c.pr_id, c.content, c.comment_date, c.status
        FROM comment c
        JOIN user u ON c.user_id = u.id
        WHERE c.pr_id = ? AND c.status = 1;
    `;
        const [result] = await pool.query(sql, [pr_id]); // Đảm bảo pool hỗ trợ promise
        res.json(result);
    } catch (error) {
        res.status(500).json({ error: error.message }); // Sửa 'err' thành 'error'
    }
});


// check Voucher
router.post('/checkvoucher', async (req, res) => {
    const { code } = req.body;
    const now = new Date();
    try {
        const [rows] = await pool.query(
            `SELECT * FROM voucher WHERE code = ? AND status = 1 
             AND start_date <= ? AND end_date >= ? AND used_count < quantity`, 
            [code, now, now]
        ); 
        
        if (rows.length === 0) {
            return res.status(400).json({ message: "Voucher không hợp lệ hoặc đã hết hạn" });
        }

        const voucher = rows[0]; // Lấy voucher đầu tiên
        res.json({
            discount_type: voucher.discount_type,
            discount_value: voucher.discount_value
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// upload ảnh
const storage = multer.diskStorage({
  destination: function(req,res, cb){
    cb(null, './public/images')    
  },
  filename: function(req, file, cb){
    cb(null, `${Date.now()}_${file.originalname}`)
  }
})

const upload = multer({ storage })
router.post('/upload', upload.single('file'), (req, res) =>{
  const file = req.file;
  if(!req.file){
    return res.status(400).send('No file uploaded.');
  }
  res.json({ filename: file.filename });
})


// Gửi tin nhắn email liên hệ
router.post('/contact', async (req, res) => {
  const { name, email, phone, message } = req.body;

  if (!name || !email || !message) {
    return res.status(400).json({ 
      success: false,
      message: "Vui lòng điền đầy đủ thông tin bắt buộc (tên, email, nội dung)" 
    });
  }

  try {
    const mailOptions = {
      from: '"Green Trees Shop" <nguyentruongvuong11@gmail.com>', // Thay bằng email của bạn
      to: 'vuongntps29902@fpt.edu.vn', // Email nhận thông báo
      subject: `[LIÊN HỆ] ${name} - ${phone || 'No Phone'}`,
      text: `Tên: ${name}\nEmail: ${email}\nSĐT: ${phone || 'Không có'}\nNội dung: ${message}`,
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px;">
          <h2 style="color: #224229;">Green Trees Shop - Thông tin liên hệ mới</h2>
          <p><strong>Tên:</strong> ${name}</p>
          <p><strong>Email:</strong> ${email}</p>
          <p><strong>SĐT:</strong> ${phone || 'Không cung cấp'}</p>
          <p><strong>Nội dung:</strong></p>
          <div style="background: #f5f5f5; padding: 10px; border-radius: 5px;">
            ${message.replace(/\n/g, '<br>')}
          </div>
          <p style="margin-top: 20px; font-size: 12px; color: #777;">
            Thời gian: ${new Date().toLocaleString('vi-VN')}
          </p>
        </div>
      `
    };

    await transporter.sendMail(mailOptions);
    
    res.json({ 
      success: true,
      message: "Cảm ơn bạn! Chúng tôi đã nhận được thông tin và sẽ liên hệ lại sớm." 
    });

  } catch (error) {
    console.error("Lỗi gửi email:", error);
    res.status(500).json({ 
      success: false,
      message: "Lỗi hệ thống! Vui lòng thử lại sau hoặc liên hệ hotline." 
    });
  }
});

module.exports = router;
