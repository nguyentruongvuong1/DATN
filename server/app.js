const express = require('express');
const cors = require('cors');
const path = require('path');
const app = express();
const port = 3000;


// Cấu hình CORS
const corsOptionsDelegate = function (req, callback) {
    const corsOptions = { origin: true };
    callback(null, corsOptions);
};

// Middleware
app.use(express.json());
app.use(cors(corsOptionsDelegate));
app.use('/public', express.static(path.join(__dirname, 'public')));

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'OPTIONS, GET, POST, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.setHeader('Access-Control-Expose-Headers', 'Authorization');
    next();
});



// Import routes (✅ Đảm bảo các file này export đúng kiểu router)
const indexRouter = require('./router/User/index');
const productRouter = require('./router/User/product');
const cateRouter = require('./router/User/cate');
const userRouter = require('./router/User/user');
const bannerRouter = require('./router/User/banner');
const reviewsRouter = require('./router/User/reviews');
const PaymentRouter = require('./router/User/payment');

const adminRouter = require('./router/Admin/admin');
const adminPrRouter = require('./router/Admin/admin_product');
const adminCateRouter = require('./router/Admin/admin_cate');

// Gắn các router
app.use('/', indexRouter);
app.use('/pr', productRouter);
app.use('/c', cateRouter);
app.use('/user', userRouter);
app.use('/banner', bannerRouter);
app.use('/reviews', reviewsRouter);
app.use('/payment', PaymentRouter);


app.use('/admin', adminRouter);
app.use('/adminpr', adminPrRouter);
app.use('/adminc', adminCateRouter);

// Bắt đầu server
app.listen(port, () => {
    console.log(`✅ Server đang chạy tại http://localhost:${port}`);
});
