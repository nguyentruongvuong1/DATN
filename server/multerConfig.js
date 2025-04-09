const multer = require('multer');
const path = require('path');
const fs = require('fs');
const crypto = require('crypto');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = 'public/images';
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    cb(null, dir);
  },

  filename: (req, file, cb) => {
  const originalName = file.originalname;
  const ext = path.extname(originalName);
  const name = path.basename(originalName, ext);

  const now = new Date();
  const month = String(now.getMonth() + 1).padStart(2, '0'); // Tháng (01-12)
  const year = now.getFullYear(); // Năm

  const newFileName = `${month}-${year}_${name}${ext}`;
  cb(null, newFileName);
}

});

const allowedTypes = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];

const fileFilter = (req, file, cb) => {
  const ext = path.extname(file.originalname).toLowerCase();
  if (file.mimetype.startsWith('image/') && allowedTypes.includes(ext)) {
    cb(null, true);
  } else {
    cb(new Error('Chỉ cho phép file ảnh JPG, PNG, GIF, WEBP'), false);
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 5 * 1024 * 1024 } // 5MB
});



module.exports = upload;
