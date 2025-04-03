var express = require('express');
var cors = require('cors');
var app = express();
var port = 3000;
var path = require('path');


// Middleware
var corsOptionsDelegate = function (req, callback) {
    var corsOptions= { origin: true };
    callback(null, corsOptions);
  }




// Sử dụng các router đã tạo
var indexRouter = require('./router/index');
var productRouter = require('./router/product');
var cateRouter = require('./router/cate');
var userRouter = require('./router/user');
var adminRouter = require('./router/admin');
var bannerRouter = require('./router/banner');
var reviewsRouter = require('./router/reviews');

app.use(express.json());
app.use(cors(corsOptionsDelegate))

app.use('/public', express.static(path.join(__dirname, 'public')));

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'OPTIONS, GET, POST, PUT, PATCH , DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.setHeader('Access-Control-Expose-Headers', 'Authorization');
    next();
  
  })


app.use('/', indexRouter);
app.use('/pr', productRouter);
app.use('/c', cateRouter);
app.use('/user', userRouter);
app.use('/admin', adminRouter);
app.use('/banner', bannerRouter);
app.use('/reviews', reviewsRouter);

// Bắt đầu server
app.listen(port, () => {
    console.log(`Server đang chạy ở Port ${port}`);
});
