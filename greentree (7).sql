-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 27, 2025 lúc 08:07 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `greentree`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `banner`
--

CREATE TABLE `banner` (
  `id` int(11) NOT NULL,
  `image` varchar(250) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 la hien 0 la an',
  `create_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `banner`
--

INSERT INTO `banner` (`id`, `image`, `status`, `create_date`) VALUES
(1, '/images/banner1.jpg', 1, '2025-03-31 04:26:19'),
(2, '/images/banner2.png', 1, '2025-03-31 04:26:19'),
(3, 'https://mowgarden.com/wp-content/uploads/2022/09/mowgarden-shop-ban-cay-canh.jpg', 1, '2025-03-31 04:57:44');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cate`
--

CREATE TABLE `cate` (
  `id` int(10) NOT NULL,
  `name` varchar(150) NOT NULL,
  `image` varchar(250) NOT NULL,
  `content` varchar(250) NOT NULL,
  `image_content` varchar(250) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 la hien 0 la an'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cate`
--

INSERT INTO `cate` (`id`, `name`, `image`, `content`, `image_content`, `create_date`, `status`) VALUES
(1, 'Cây trong nhà', 'https://mowgarden.com/wp-content/uploads/2022/01/menu-cay-canh-trong-nha.jpg', 'Giúp cho ngôi nhà của bạn thêm tươi mới và xanh với những sản phẩm cây trong nhà của MOW Garden. Thật tuyệt vời mang đến cho bạn những phút giây thư giãn bên canh nhữngsản phẩm cây xanh chất lượng.', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-canh-trong-trong-nha.jpg', '2025-03-06 05:15:00', 1),
(2, 'Cây ngoài trời', 'https://mowgarden.com/wp-content/uploads/2022/01/menu-cay-ngoai-troi-533x800.jpg', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua. Hãy để MOW Garden giúp bạn tạo nên một khu vườn thật tuyệt vời nhé.', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-ngoai-troi.jpg', '2025-03-06 12:15:00', 1),
(3, 'Chậu cây', 'https://mowgarden.com/wp-content/uploads/2022/01/menu-chau-cay-kieng.jpg', '', '/images/chaucaycontent.jpg', '2025-03-06 12:15:21', 1),
(4, 'Phụ kiện', 'https://hatalandscape.com/public/uploads/files/dung-cu-lam-vuon.jpg', 'Phụ kiện làm vườn giúp tối ưu hóa công việc chăm sóc cây cối, tăng hiệu quả và mang lại trải nghiệm làm vườn dễ dàng và thú vị hơn.', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-03-06 12:15:21', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `characteristic`
--

CREATE TABLE `characteristic` (
  `id` int(10) NOT NULL,
  `cate_id` int(10) NOT NULL,
  `name` varchar(250) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `characteristic`
--

INSERT INTO `characteristic` (`id`, `cate_id`, `name`, `create_at`) VALUES
(10, 1, 'Theo kiểu dáng cây', '2025-03-06 13:01:11'),
(11, 1, 'Theo vị trí đặt', '2025-03-06 13:01:11'),
(12, 1, 'Theo chức năng', '2025-03-06 13:01:43'),
(13, 2, 'Theo kiểu dáng', '2025-03-06 13:01:43'),
(14, 2, 'Theo đặc điểm', '2025-03-06 13:02:08'),
(15, 2, 'Theo chức năng', '2025-03-06 13:02:08'),
(16, 3, 'Theo kiểu dáng', '2025-03-06 13:02:43'),
(17, 3, 'Theo vật liệu', '2025-03-06 13:02:43'),
(18, 3, 'Theo kích thước', '2025-03-06 13:03:06'),
(19, 4, 'Dụng cụ làm vườn', '2025-04-05 04:22:35'),
(20, 4, 'Dụng cụ tưới cây', '2025-04-05 04:22:35'),
(22, 4, 'Vật tư nông nghiệp\r\n', '2025-04-05 04:22:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` varchar(255) NOT NULL,
  `user_id` int(10) NOT NULL,
  `name` varchar(250) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` varchar(250) NOT NULL,
  `note` text NOT NULL,
  `voucher_id` int(10) DEFAULT NULL,
  `order_status` tinyint(4) NOT NULL,
  `transaction_status` tinyint(4) NOT NULL,
  `transaction_code` varchar(250) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `total_amount` int(10) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order`
--

INSERT INTO `order` (`id`, `user_id`, `name`, `phone`, `address`, `note`, `voucher_id`, `order_status`, `transaction_status`, `transaction_code`, `payment_method`, `total_amount`, `create_at`) VALUES
('GTS-1744903813374-629', 2, 'test', 364185395, '135 Dông Bắc', '', NULL, 4, 2, '', 1, 310000, '2025-04-17 22:30:13'),
('GTS-1745032912091-546', 2, 'test', 364185395, '135 Dông Bắc', '', NULL, 4, 2, '', 1, 260000, '2025-04-19 10:21:52'),
('GTS-1745042513948-519', 27, 'vuongadmin', 364185395, '135 Dông Bắc', '', NULL, 4, 2, '', 1, 950000, '2025-04-19 13:01:53'),
('GTS-1745044123773-93', 27, 'vuongadmin', 364185395, '135 Dông Bắc', '', NULL, 4, 2, '', 1, 10930000, '2025-04-19 13:28:43'),
('GTS-1745044617101-746', 27, 'vuongadmin', 364185395, '135 Dông Bắc', '', NULL, 4, 2, '', 1, 90000, '2025-04-19 13:36:57'),
('GTS-1745334005198-54', 27, 'vuongadmin', 364185395, '135 Dông Bắc', '', NULL, 4, 2, '', 1, 178000, '2025-04-22 22:00:05'),
('GTS-1745334021581-265', 27, 'vuongadmin', 364185395, '135 Dông Bắc', '', NULL, 1, 1, '', 1, 178000, '2025-04-22 22:00:21'),
('GTS-1745334038853-95', 27, 'vuongadmin', 364185395, '135 Dông Bắc', '', NULL, 1, 1, '', 1, 220000, '2025-04-22 22:00:38'),
('GTS-1745416183101-147', 29, 'Tran Ba Ho', 364185395, '13 CÔng viên phần mền quang trung', 'Gọi điện cho em rồi hẳn giao nhé', NULL, 4, 2, '', 1, 270000, '2025-04-23 20:49:43'),
('GTS-1745416226040-114', 29, 'Tran Ba Ho', 364185395, '13 CÔng viên phần mền quang trung', '', NULL, 4, 2, 'GTSCODE-1745416226040-415', 2, 398000, '2025-04-23 20:50:26'),
('GTS-1745416967499-369', 30, 'Lê Nguyễn Hoàng Oanh', 987234631, '80 Hoàng Hoa Thám F13, Tân Bình', 'Giao hỏa tốc hôm nay', NULL, 4, 2, 'GTSCODE-1745416967499-871', 2, 1155000, '2024-12-15 21:02:47'),
('GTS-1745417946165-468', 30, 'Lê Nguyễn Hoàng Oanh', 987234631, '80 Hoàng Hoa Thám F13, Tân Bình', 'Alo trước khi giao giúp tôi', NULL, 4, 2, 'GTSCODE-1745417946165-50', 2, 1158000, '2024-12-16 21:19:06'),
('GTS-1745418526564-300', 31, 'Đinh Hữu Huy', 902486301, 'Đường số `17, An Lạc A', '', NULL, 4, 2, '', 1, 390000, '2024-12-24 21:28:46'),
('GTS-1745418701334-268', 31, 'Đinh Hữu Huy', 902486301, 'Đường số `17, An Lạc A', 'giao 12h trưa', NULL, 4, 2, '', 1, 275000, '2024-12-22 21:31:41'),
('GTS-1745419413684-195', 31, 'Đinh Hữu Huy', 902486301, 'Đường số `17, An Lạc A', '3 ngày nữa hãy giao', NULL, 4, 2, 'GTSCODE-1745419413684-273', 2, 2100000, '2024-12-20 21:43:33'),
('GTS-1745419520172-871', 31, 'Đinh Hữu Huy', 902486301, 'Đường số `17, An Lạc A', '', NULL, 4, 2, 'GTSCODE-1745419520172-62', 2, 230000, '2024-12-12 21:45:20'),
('GTS-1745419736118-375', 30, 'Lê Nguyễn Hoàng Oanh', 987234631, '80 Hoàng Hoa Thám F13, Tân Bình', 'giao gấp trong ngày', NULL, 4, 2, '', 1, 600000, '2024-12-16 19:48:56'),
('GTS-1745419824231-425', 30, 'Lê Nguyễn Hoàng Oanh', 0, '80 Hoàng Hoa Thám F13, Tân Bình', '', NULL, 4, 2, '', 1, 2900000, '2024-12-14 21:50:24'),
('GTS-1745420440738-95', 32, 'Nguyễn Phan Yến Nhi', 909234123, '415 Tên Lửa, Bình tân', 'giao sớm trước 5h chiều', NULL, 4, 2, '', 1, 1200000, '2024-12-10 22:00:40'),
('GTS-1745420526942-145', 32, 'Nguyễn Phan Yến Nhi', 909234123, '415 Tên Lửa, Bình tân', '', NULL, 4, 2, '', 1, 1260000, '2024-12-07 22:02:06'),
('GTS-1745420588745-741', 32, 'Nguyễn Phan Yến Nhi', 909234123, '415 Tên Lửa, Bình tân', '', NULL, 4, 2, 'GTSCODE-1745420588745-190', 2, 218000, '2024-12-25 22:03:08'),
('GTS-1745420871633-221', 32, 'Nguyễn Phan Yến Nhi', 909234123, '415 Tên Lửa, Bình tân', 'giao về nhà lúc 5h chiều', NULL, 4, 2, 'GTSCODE-1745420871633-671', 2, 185000, '2024-12-26 22:07:51'),
('GTS-1745456104410-147', 33, 'Nguyễn Đức Thuận', 973245126, '78, Hoa Lan, Phú nhuận', 'giao hỏa tốc 30p giúp tôi', NULL, 4, 2, '', 1, 2110000, '2025-01-03 07:55:04'),
('GTS-1745456177434-30', 33, 'Nguyễn Đức Thuận', 973245126, '78, Hoa Lan, Phú nhuận', '', NULL, 4, 2, '', 1, 340000, '2025-01-14 07:56:17'),
('GTS-1745456295633-662', 33, 'Nguyễn Đức Thuận', 973245126, '78, Hoa Lan, Phú nhuận', 'Giao ngày thứ 7 giúp tôi', NULL, 4, 2, 'GTSCODE-1745456295633-521', 2, 1406000, '2025-01-19 07:58:15'),
('GTS-1745456606165-362', 33, 'Nguyễn Đức Thuận', 973245126, '78, Hoa Lan, Phú nhuận', '', NULL, 4, 2, 'GTSCODE-1745456606165-157', 2, 2226000, '2025-01-22 08:03:26'),
('GTS-1745457051781-657', 34, 'Phạm Nguyên Ngọc', 945123234, '123, An Dương Vương, Q8', 'giao thứ 6 giúp mình', NULL, 4, 2, '', 1, 27350000, '2025-01-24 08:10:51'),
('GTS-1745457361220-661', 34, 'Phạm Nguyên Ngọc', 945123234, '123, An Dương Vương, Q8', '', NULL, 4, 2, '', 1, 2581000, '2025-01-27 08:16:01'),
('GTS-1745457488492-281', 34, 'Phạm Nguyên Ngọc', 945123234, '123, An Dương Vương, Q8', 'gọi trước khi giao 30p', NULL, 4, 2, 'GTSCODE-1745457488492-701', 2, 3870000, '2025-01-26 08:18:08'),
('GTS-1745457701996-392', 34, 'Phạm Nguyên Ngọc', 945123234, '123, An Dương Vương, Q8', '', NULL, 4, 2, 'GTSCODE-1745457701996-456', 2, 1310000, '2025-01-17 08:21:42'),
('GTS-1745459322612-169', 35, 'Vương Quỳnh Giang', 987123678, '113, Tân Hải, f13, tân bình', 'giao lúc 17h ', NULL, 4, 2, '', 1, 4748000, '2025-02-04 08:48:42'),
('GTS-1745459377625-877', 35, 'Vương Quỳnh Giang', 987123678, '113, Tân Hải, f13, tân bình', '', NULL, 4, 2, '', 1, 2470000, '2025-02-12 08:49:37'),
('GTS-1745461494266-316', 35, 'Vương Quỳnh Giang', 987123678, '113, Tân Hải, f13, tân bình', 'giao buổi tối 20h', NULL, 4, 2, 'GTSCODE-1745461494266-325', 2, 1406000, '2025-02-20 09:24:54'),
('GTS-1745461628349-14', 35, 'Vương Quỳnh Giang', 987123678, '113, Tân Hải, f13, tân bình', '', NULL, 4, 2, 'GTSCODE-1745461628349-855', 2, 1260000, '2025-02-27 09:27:08'),
('GTS-1745466320933-909', 36, 'Bùi Minh Trung', 912345672, '390 Kinh Dương Vương, An Lạc', 'Giao hàng nhớ gọi trước', NULL, 4, 2, '', 1, 160000, '2025-02-03 10:45:20'),
('GTS-1745466384533-481', 36, 'Bùi Minh Trung', 912345672, '390 Kinh Dương Vương, An Lạc', '', NULL, 4, 2, '', 1, 5090000, '2025-02-16 10:46:24'),
('GTS-1745466506484-130', 36, 'Bùi Minh Trung', 912345672, '390 Kinh Dương Vương, An Lạc', 'Chuyển khoản trước cọc 50%', NULL, 4, 2, 'GTSCODE-1745466506484-403', 2, 5315000, '2025-02-08 10:48:26'),
('GTS-1745466864008-943', 36, 'Bùi Minh Trung', 912345672, '390 Kinh Dương Vương, An Lạc', '', NULL, 4, 2, 'GTSCODE-1745466864008-468', 2, 590000, '2025-02-19 10:54:24'),
('GTS-1745467664758-716', 37, 'Lê Trần Hồng Nhi', 945389987, 'An Phú Đông, Q12', 'Giao hàng trước 15h giúp tôi', NULL, 4, 2, '', 1, 666000, '2025-03-24 11:07:44'),
('GTS-1745467722698-966', 37, 'Lê Trần Hồng Nhi', 945389987, 'An Phú Đông, Q12', '', NULL, 4, 2, '', 1, 11150000, '2025-03-17 11:08:42'),
('GTS-1745467854831-306', 37, 'Lê Trần Hồng Nhi', 945389987, 'An Phú Đông, Q12', 'Cọc trước 50% tiền hàng', NULL, 4, 2, 'GTSCODE-1745467854831-25', 2, 3700000, '2025-03-10 11:10:54'),
('GTS-1745468027142-916', 37, 'Lê Trần Hồng Nhi', 945389987, 'An Phú Đông, Q12', '', NULL, 4, 2, 'GTSCODE-1745468027142-555', 2, 8350000, '2025-03-14 11:13:47'),
('GTS-1745468740377-686', 38, 'Nguyễn Hoàng Quyên', 976565623, 'Nguyễn Kiệm, F3, Phú nhuận 0', 'giao gần công viên gia định', NULL, 4, 2, '', 1, 1170000, '2025-03-21 11:25:40'),
('GTS-1745468791077-834', 38, 'Nguyễn Hoàng Quyên', 976565623, 'Nguyễn Kiệm, F3, Phú nhuận ', '', NULL, 4, 2, '', 1, 1340000, '2025-03-11 11:26:31'),
('GTS-1745468878820-236', 38, 'Nguyễn Hoàng Quyên', 976565623, 'Nguyễn Kiệm, F3, Phú nhuận ', 'cọc full tiền hàng', NULL, 4, 2, 'GTSCODE-1745468878820-266', 2, 2080000, '2025-03-27 11:27:58'),
('GTS-1745469157704-728', 38, 'Nguyễn Hoàng Quyên', 976565623, 'Nguyễn Kiệm, F3, Phú nhuận ', '', NULL, 4, 2, 'GTSCODE-1745469157704-998', 2, 2780000, '2025-03-31 11:32:37'),
('GTS-1745469944643-627', 39, 'Trần Duy Hòa', 937673345, 'ấp 17, Long trung, Cai lậy, Tiền Giang', 'giao sáng thứ 2 tuần sau', NULL, 4, 2, '', 1, 3450000, '2025-04-20 11:45:44'),
('GTS-1745470003079-775', 39, 'Trần Duy Hòa', 937673345, 'ấp 17, Long trung, Cai lậy, Tiền Giang', '', NULL, 4, 2, '', 1, 6950000, '2025-04-19 11:46:43'),
('GTS-1745470109438-445', 39, 'Trần Duy Hòa', 937673345, 'ấp 17, Long trung, Cai lậy, Tiền Giang', 'Chuyển khoản 50% tiền hàng', NULL, 4, 2, 'GTSCODE-1745470109438-917', 2, 965000, '2025-04-16 11:48:29'),
('GTS-1745470217035-960', 39, 'Trần Duy Hòa', 937673345, 'ấp 17, Long trung, Cai lậy, Tiền Giang', '', NULL, 4, 2, 'GTSCODE-1745470217035-581', 2, 1700000, '2025-04-08 11:50:17'),
('GTS-1745470928062-669', 40, 'Trần Huy Bình', 938761216, 'Vĩnh Kim, Châu Thành, Tiền Giang', 'alo trước khi giao nhé', NULL, 4, 2, '', 1, 10670000, '2025-04-26 12:02:08'),
('GTS-1745471226228-580', 40, 'Trần Huy Bình', 938761216, 'Vĩnh Kim, Châu Thành, Tiền Giang', '', NULL, 4, 2, '', 1, 4450000, '2025-04-02 12:07:06'),
('GTS-1745471299820-146', 40, 'Trần Huy Bình', 938761216, 'Vĩnh Kim, Châu Thành, Tiền Giang', 'Chuyên cọc 50% tiền đơn hàng', NULL, 4, 2, 'GTSCODE-1745471299820-492', 2, 2370000, '2025-04-29 12:08:19'),
('GTS-1745471410272-974', 40, 'Trần Huy Bình', 938761216, 'Vĩnh Kim, Châu Thành, Tiền Giang', '', NULL, 4, 2, 'GTSCODE-1745471410272-579', 2, 3650000, '2025-04-13 12:10:10'),
('GTS-1745474764496-76', 27, 'vuongadmin', 364185395, '135 Dông Bắc', '', NULL, 1, 1, '', 1, 950000, '2025-04-24 13:06:04'),
('GTS-1745474972447-516', 37, 'Lê Trần Hồng Nhi', 945389987, 'An Phú Đông, Q12', '', NULL, 1, 2, 'GTSCODE-1745474972447-721', 2, 178000, '2025-04-24 13:09:32');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(10) NOT NULL,
  `order_id` varchar(255) NOT NULL,
  `pr_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `price` int(20) NOT NULL,
  `total` int(20) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_detail`
--

INSERT INTO `order_detail` (`id`, `order_id`, `pr_id`, `quantity`, `price`, `total`, `create_at`) VALUES
(102, 'GTS-1744903813374-629', 201, 1, 220000, 220000, '2025-04-17 22:30:13'),
(103, 'GTS-1744903813374-629', 237, 1, 40000, 40000, '2025-04-17 22:30:13'),
(106, 'GTS-1745032912091-546', 237, 1, 40000, 40000, '2025-04-19 10:21:52'),
(107, 'GTS-1745032912091-546', 290, 1, 170000, 170000, '2025-04-19 10:21:52'),
(108, 'GTS-1745042513948-519', 203, 1, 680000, 680000, '2025-04-19 13:01:53'),
(109, 'GTS-1745042513948-519', 201, 1, 220000, 220000, '2025-04-19 13:01:53'),
(110, 'GTS-1745044123773-93', 203, 16, 680000, 10880000, '2025-04-19 13:28:43'),
(112, 'GTS-1745044617101-746', 237, 1, 40000, 40000, '2025-04-19 13:36:57'),
(124, 'GTS-1745334005198-54', 12, 1, 128000, 128000, '2025-04-22 22:00:05'),
(125, 'GTS-1745334021581-265', 19, 1, 128000, 128000, '2025-04-22 22:00:21'),
(126, 'GTS-1745334038853-95', 290, 1, 170000, 170000, '2025-04-22 22:00:38'),
(129, 'GTS-1745416183101-147', 201, 1, 220000, 220000, '2025-04-23 20:49:43'),
(130, 'GTS-1745416226040-114', 201, 1, 220000, 220000, '2025-04-23 20:50:26'),
(131, 'GTS-1745416226040-114', 12, 1, 128000, 128000, '2025-04-23 20:50:26'),
(132, 'GTS-1745416967499-369', 293, 1, 700000, 700000, '2025-04-23 21:02:47'),
(133, 'GTS-1745416967499-369', 291, 1, 405000, 405000, '2025-04-23 21:02:47'),
(134, 'GTS-1745417946165-468', 287, 1, 858000, 858000, '2025-04-23 21:19:06'),
(135, 'GTS-1745417946165-468', 245, 1, 250000, 250000, '2025-04-23 21:19:06'),
(136, 'GTS-1745418526564-300', 251, 1, 250000, 250000, '2025-04-23 21:28:46'),
(137, 'GTS-1745418526564-300', 82, 1, 90000, 90000, '2025-04-23 21:28:46'),
(138, 'GTS-1745418701334-268', 83, 1, 65000, 65000, '2025-04-23 21:31:41'),
(139, 'GTS-1745418701334-268', 79, 1, 160000, 160000, '2025-04-23 21:31:41'),
(140, 'GTS-1745419413684-195', 251, 1, 250000, 250000, '2025-04-23 21:43:33'),
(141, 'GTS-1745419413684-195', 226, 1, 1800000, 1800000, '2025-04-23 21:43:33'),
(142, 'GTS-1745419520172-871', 52, 1, 90000, 90000, '2025-04-23 21:45:20'),
(143, 'GTS-1745419520172-871', 53, 1, 90000, 90000, '2025-04-23 21:45:20'),
(144, 'GTS-1745419736118-375', 219, 1, 330000, 330000, '2025-04-23 21:48:56'),
(145, 'GTS-1745419736118-375', 218, 1, 220000, 220000, '2025-04-23 21:48:56'),
(146, 'GTS-1745419824231-425', 226, 1, 1800000, 1800000, '2025-04-23 21:50:24'),
(147, 'GTS-1745419824231-425', 225, 1, 1050000, 1050000, '2025-04-23 21:50:24'),
(148, 'GTS-1745420440738-95', 291, 2, 405000, 810000, '2025-04-23 22:00:40'),
(149, 'GTS-1745420440738-95', 290, 2, 170000, 340000, '2025-04-23 22:00:40'),
(150, 'GTS-1745420526942-145', 227, 1, 220000, 220000, '2025-04-23 22:02:06'),
(151, 'GTS-1745420526942-145', 210, 1, 990000, 990000, '2025-04-23 22:02:06'),
(152, 'GTS-1745420588745-741', 9, 1, 84000, 84000, '2025-04-23 22:03:08'),
(153, 'GTS-1745420588745-741', 10, 1, 84000, 84000, '2025-04-23 22:03:08'),
(154, 'GTS-1745420871633-221', 255, 1, 45000, 45000, '2025-04-23 22:07:51'),
(155, 'GTS-1745420871633-221', 52, 1, 90000, 90000, '2025-04-23 22:07:51'),
(156, 'GTS-1745456104410-147', 212, 2, 550000, 1100000, '2025-04-24 07:55:04'),
(157, 'GTS-1745456104410-147', 211, 3, 320000, 960000, '2025-04-24 07:55:04'),
(158, 'GTS-1745456177434-30', 255, 2, 45000, 90000, '2025-04-24 07:56:17'),
(159, 'GTS-1745456177434-30', 252, 1, 200000, 200000, '2025-04-24 07:56:17'),
(160, 'GTS-1745456295633-662', 19, 2, 128000, 256000, '2025-04-24 07:58:15'),
(161, 'GTS-1745456295633-662', 21, 2, 550000, 1100000, '2025-04-24 07:58:15'),
(162, 'GTS-1745456606165-362', 15, 4, 240000, 960000, '2025-04-24 08:03:26'),
(163, 'GTS-1745456606165-362', 22, 4, 304000, 1216000, '2025-04-24 08:03:26'),
(164, 'GTS-1745457051781-657', 224, 5, 4500000, 22500000, '2025-04-24 08:10:51'),
(165, 'GTS-1745457051781-657', 80, 6, 800000, 4800000, '2025-04-24 08:10:51'),
(166, 'GTS-1745457361220-661', 264, 3, 477000, 1431000, '2025-04-24 08:16:01'),
(167, 'GTS-1745457361220-661', 279, 2, 550000, 1100000, '2025-04-24 08:16:01'),
(168, 'GTS-1745457488492-281', 273, 2, 1768000, 3536000, '2025-04-24 08:18:08'),
(169, 'GTS-1745457488492-281', 271, 1, 284000, 284000, '2025-04-24 08:18:08'),
(170, 'GTS-1745457701996-392', 276, 3, 40000, 120000, '2025-04-24 08:21:42'),
(171, 'GTS-1745457701996-392', 277, 3, 380000, 1140000, '2025-04-24 08:21:42'),
(172, 'GTS-1745459322612-169', 282, 2, 1364000, 2728000, '2025-04-24 08:48:42'),
(173, 'GTS-1745459322612-169', 281, 2, 985000, 1970000, '2025-04-24 08:48:42'),
(174, 'GTS-1745459377625-877', 248, 2, 170000, 340000, '2025-04-24 08:49:37'),
(175, 'GTS-1745459377625-877', 51, 4, 520000, 2080000, '2025-04-24 08:49:37'),
(176, 'GTS-1745461494266-316', 22, 2, 304000, 608000, '2025-04-24 09:24:54'),
(177, 'GTS-1745461494266-316', 285, 2, 374000, 748000, '2025-04-24 09:24:54'),
(178, 'GTS-1745461628349-14', 227, 1, 220000, 220000, '2025-04-24 09:27:08'),
(179, 'GTS-1745461628349-14', 210, 1, 990000, 990000, '2025-04-24 09:27:08'),
(180, 'GTS-1745466320933-909', 237, 2, 40000, 80000, '2025-04-24 10:45:20'),
(181, 'GTS-1745466320933-909', 236, 2, 15000, 30000, '2025-04-24 10:45:20'),
(182, 'GTS-1745466384533-481', 48, 6, 500000, 3000000, '2025-04-24 10:46:24'),
(183, 'GTS-1745466384533-481', 49, 6, 340000, 2040000, '2025-04-24 10:46:24'),
(184, 'GTS-1745466506484-130', 207, 3, 105000, 315000, '2025-04-24 10:48:26'),
(185, 'GTS-1745466506484-130', 210, 5, 990000, 4950000, '2025-04-24 10:48:26'),
(186, 'GTS-1745466864008-943', 40, 2, 150000, 300000, '2025-04-24 10:54:24'),
(187, 'GTS-1745466864008-943', 39, 2, 120000, 240000, '2025-04-24 10:54:24'),
(188, 'GTS-1745467664758-716', 200, 2, 180000, 360000, '2025-04-24 11:07:44'),
(189, 'GTS-1745467664758-716', 19, 2, 128000, 256000, '2025-04-24 11:07:44'),
(190, 'GTS-1745467722698-966', 215, 4, 1850000, 7400000, '2025-04-24 11:08:42'),
(191, 'GTS-1745467722698-966', 216, 2, 1850000, 3700000, '2025-04-24 11:08:42'),
(192, 'GTS-1745467854831-306', 42, 2, 850000, 1700000, '2025-04-24 11:10:54'),
(193, 'GTS-1745467854831-306', 37, 3, 650000, 1950000, '2025-04-24 11:10:54'),
(194, 'GTS-1745468027142-916', 203, 10, 680000, 6800000, '2025-04-24 11:13:47'),
(195, 'GTS-1745468027142-916', 241, 10, 150000, 1500000, '2025-04-24 11:13:47'),
(196, 'GTS-1745468740377-686', 41, 4, 160000, 640000, '2025-04-24 11:25:40'),
(197, 'GTS-1745468740377-686', 204, 3, 160000, 480000, '2025-04-24 11:25:40'),
(198, 'GTS-1745468791077-834', 83, 6, 65000, 390000, '2025-04-24 11:26:31'),
(199, 'GTS-1745468791077-834', 35, 5, 180000, 900000, '2025-04-24 11:26:31'),
(200, 'GTS-1745468878820-236', 240, 3, 370000, 1110000, '2025-04-24 11:27:58'),
(201, 'GTS-1745468878820-236', 239, 2, 460000, 920000, '2025-04-24 11:27:58'),
(202, 'GTS-1745469157704-728', 249, 7, 30000, 210000, '2025-04-24 11:32:37'),
(203, 'GTS-1745469157704-728', 230, 9, 280000, 2520000, '2025-04-24 11:32:37'),
(204, 'GTS-1745469944643-627', 82, 10, 90000, 900000, '2025-04-24 11:45:44'),
(205, 'GTS-1745469944643-627', 251, 10, 250000, 2500000, '2025-04-24 11:45:44'),
(206, 'GTS-1745470003079-775', 26, 5, 1200000, 6000000, '2025-04-24 11:46:43'),
(207, 'GTS-1745470003079-775', 292, 2, 450000, 900000, '2025-04-24 11:46:43'),
(208, 'GTS-1745470109438-445', 255, 5, 45000, 225000, '2025-04-24 11:48:29'),
(209, 'GTS-1745470109438-445', 247, 3, 230000, 690000, '2025-04-24 11:48:29'),
(210, 'GTS-1745470217035-960', 243, 6, 25000, 150000, '2025-04-24 11:50:17'),
(211, 'GTS-1745470217035-960', 245, 6, 250000, 1500000, '2025-04-24 11:50:17'),
(212, 'GTS-1745470928062-669', 285, 5, 374000, 1870000, '2025-04-24 12:02:08'),
(213, 'GTS-1745470928062-669', 288, 5, 1750000, 8750000, '2025-04-24 12:02:08'),
(214, 'GTS-1745471226228-580', 252, 5, 200000, 1000000, '2025-04-24 12:07:06'),
(215, 'GTS-1745471226228-580', 47, 4, 850000, 3400000, '2025-04-24 12:07:06'),
(216, 'GTS-1745471299820-146', 196, 4, 155000, 620000, '2025-04-24 12:08:19'),
(217, 'GTS-1745471299820-146', 49, 5, 340000, 1700000, '2025-04-24 12:08:19'),
(218, 'GTS-1745471410272-974', 20, 4, 720000, 2880000, '2025-04-24 12:10:10'),
(219, 'GTS-1745471410272-974', 200, 4, 180000, 720000, '2025-04-24 12:10:10'),
(220, 'GTS-1745474764496-76', 203, 1, 680000, 680000, '2025-04-24 13:06:04'),
(221, 'GTS-1745474764496-76', 201, 1, 220000, 220000, '2025-04-24 13:06:04'),
(222, 'GTS-1745474972447-516', 12, 1, 128000, 128000, '2025-04-24 13:09:32');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `otp_codes`
--

CREATE TABLE `otp_codes` (
  `id` int(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp_code` varchar(6) NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` int(10) NOT NULL,
  `cate_id` int(10) NOT NULL,
  `name` varchar(250) NOT NULL,
  `price` int(20) NOT NULL,
  `sale` int(10) DEFAULT NULL,
  `price_sale` int(20) DEFAULT NULL,
  `images` varchar(250) NOT NULL,
  `discription` text DEFAULT NULL,
  `inventory_quantity` int(10) NOT NULL DEFAULT 0,
  `view` int(10) NOT NULL DEFAULT 0,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 la hien 0 la an'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `cate_id`, `name`, `price`, `sale`, `price_sale`, `images`, `discription`, `inventory_quantity`, `view`, `create_date`, `status`) VALUES
(6, 1, 'Cây tùng bồng lai tiểu cảnh chậu sứ thổ cẩm TUBO005\r\n', 500000, 10, 450000, 'https://mowgarden.com/wp-content/uploads/2024/03/tung-bong-lai-chu-su-de-ban-mowgarden-768x768.jpg,\n\nhttps://mowgarden.com/wp-content/uploads/2024/03/tung-bong-lai-chu-su-de-ban-mowgarden-01-125x125.jpg\n', 'Cây Tùng Bông Lai là một loài cây mang vẻ đẹp trang nhã, với tán lá dầy xanh mướt trông giống như những đám mây và có kích thước nhỏ gọn nên rất thích hợp để bàn làm việc. Chúng là loài cây dễ trồng nên không cần phải tốn công chăm sóc, tuy nhiên cần đặt tại nơi có nhiều ánh sáng.\r\n*Giá bao gồm chậu, đĩa lót và sỏi rải mặt\r\n\r\nTÊN KHOA HỌC	Podocarpus macrophyllus\r\nTÊN THÔNG THƯỜNG	Cây tùng bồng lai\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 20x20cm (DxC)\r\n• Chiều cao tổng: 50 cm\r\n• Độ rộng tán: 30 cm\r\nĐỘ KHÓ	Trung bình\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp / nắng tán xạ\r\nNHU CẦU NƯỚC	Tưới nước 1-2 lần/tuần', 100, 2, '2025-03-06 13:34:00', 1),
(8, 1, 'Cây kim ngân ba thân để bàn chậu sứ gấu BearBrick LONI040\n', 280000, 10, 252000, 'https://mowgarden.com/wp-content/uploads/2023/07/cay-kim-ngan-3-than-mowgarden.jpg', 'Cây Kim Ngân là loại cây cảnh trong nhà được trồng phổ biến trên khắp thế giới, nó có sức ảnh hưởng tới mức mà hầu như ai cũng tin rằng khi trồng có thể mang lại nhiều may mắn trong cuộc sống, công việc hoặc làm ăn.\r\n\r\nTÊN KHOA HỌC	Pachira aquatica\r\nTÊN GỌI KHÁC	Cây kim ngân\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 12×8 (DxC)\r\n• Chiều cao tổng: 25cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Nắng trực tiếp / Chịu râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-06 14:27:11', 1),
(9, 1, 'Cây trầu bà đế vương xanh chậu mặt cool ‘Imperial Green’ chậu sứ PHIG006\r\n', 120000, 30, 84000, 'https://mowgarden.com/wp-content/uploads/2023/07/cay-trau-ba-de-vuong-xanh-mowgarden-125x125.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/12-cay-trau-ba-de-vuong-xanh-de-ban-chau-su-trang-2-125x125.jpg\r\n', 'Trầu Bà Đế Vương Xanh (Philodendron Imperial Green) là một giống cây rất ưu chuộng để trồng với ý nghĩa phong thủy mà nó mang lại. Nên đặt cây tại các vị trí như trong phòng khách, phòng làm việc, văn phòng hoặc sảnh ra vào cơ quan.\r\n\r\nTÊN KHOA HỌC	Philodendron Imperial Green\r\nTÊN GỌI KHÁC	Trầu bà đế vương xanh\r\nKÍCH THƯỚC CÂY	• Kích thước chậu: 18x14cm (DxC)\r\n• Chiều cao tổng: 25 – 35 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Tưới nước 3 – 5 lần/tháng', 99, 1, '2025-03-06 14:35:29', 1),
(10, 1, 'Cây cỏ lan chi để bàn chậu sứ mặt cười SPI004\r\n', 120000, 30, 84000, 'https://mowgarden.com/wp-content/uploads/2023/07/co-lan-chi-de-ban-mowgaden-125x125.jpg\r\n', 'Cỏ Lan Chi (hay còn gọi là Cỏ Nhện) là loại cây rất dễ sống với điều kiện khí hậu nóng tại Việt Nam. Đặc biệt, nó nằm trong top các loại cây lọc không khí rất hiệu quả, có thể đặt trong phòng ngủ giúp bạn có giấc ngủ trong lành hơn.\r\n\r\nTÊN KHOA HỌC	Chlorophytum laxum\r\nTÊN GỌI KHÁC	Cây cỏ lan chi / cây dây nhện\r\nKÍCH THƯỚC CÂY	Chiều cao 30 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Chịu râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 99, 1, '2025-03-06 14:35:29', 1),
(11, 1, 'Cây trầu bà đế vương đỏ để bàn ‘Red Rojo’ chậu sứ PHIR008\r\n', 320000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/07/trau-ba-de-vuong-do-de-ban-mowgarden.jpg\r\n', 'Thân dạng thảo lớn, trong tự nhiên cây có thể leo được, nhưng đa số khi trồng chậu thì thân vươn thẳng chắc chắn, cao khoảng dưới 1m5.\r\n\r\nTÊN KHOA HỌC	Philodendron Imperial Red\r\nTÊN THÔNG THƯỜNG	Trầu bà đế vương đỏ\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 12x12cm (DxC)\r\n• Chiều cao tổng: 30 cm\r\n• Độ rộng tán: 25 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-06 14:40:55', 1),
(12, 1, 'Cây lưỡi hổ Bantel Sensation chậu ươm STBS001\r\n', 160000, 20, 128000, 'https://mowgarden.com/wp-content/uploads/2023/04/cay-luoi-ho-bengar-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/cay-luoi-ho-bengar-2-125x125.jpg', 'Lưỡi hổ Thái xanh mini là dòng lưỡi hổ nhỏ để bàn, có chiều cao tối đa khoảng 20cm, không có nhiều vằn như những loại lưỡi hổ khác, nhưng nó lại sở hữu bộ lá màu xanh đậm ấn tượng, mang lại nét ‘cứng cáp’ tự nhiên cho không gian. Chúng rất thích hợp để trên bàn làm việc, kệ trang trí hoặc làm quà tặng.\r\n\r\nTÊN KHOA HỌC	Sansevieria ‘hahnii’ Black Gold\r\nTÊN GỌI KHÁC	Cây lưỡi hổ Thái xanh\r\nQUY CÁCH SẢN PHẨM	• Chiều cao: 30 – 45 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Chịu bóng râm tốt\r\nNHU CẦU NƯỚC	Thay nước 2 – 3 lần/tháng', 88, 340, '2025-03-06 14:40:55', 1),
(13, 1, 'Cây hạnh phúc để sàn 2 tầng lớn chậu đá mài RADE033\r\n', 1200000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/cay-hanh-phuc-2-tang-chau-da-mai-tron-1-768x768.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-hanh-phuc-adermachera-Sinica-768x768.jpg\r\n', 'Cây hạnh phúc là dòng cây cảnh đẹp, sức sống khỏe mạnh, dễ chăm sóc. Trên cây có những tán lá xanh tươi, mượt mà thể hiện cho sự hi vọng và niềm tin mạnh mẽ. Với ý nghĩa mang lại may mắn và hạnh phúc nên cây thường được chọn để làm cây trưng trong nhà hoặc làm quà tặng.\r\n\r\nTÊN KHOA HỌC	Radermachera Sinica\r\nTÊN THÔNG THƯỜNG	Cây hạnh phúc\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 30x34cm (DxC)\r\n• Chiều cao tổng: 150cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-06 14:47:49', 1),
(14, 1, 'Cây trầu bà cột chậu xi măng trụ vuông CTBC007\r\n', 1100000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/cay-trau-ba-cot-chau-xi-mang-van-soc-ngang-1-768x768.jpg', 'Có tác dụng thanh lọc không khí trong nhà mà còn chứa đựng ý nghĩa phong thủy rất tốt, mang dáng vẻ thanh lịch và sang trọng.\r\n\r\nTÊN KHOA HỌC	Epipremnum aureum\r\nTÊN THÔNG THƯỜNG	Trầu bà xanh\r\nQUY CÁCH SẢN PHẨM	• Chiều cao 130 – 140 cm\r\n• Kích thước chậu: 30x58cm (DxC)\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 3 – 4 lần/tuần', 100, 86, '2025-03-06 14:47:49', 1),
(15, 1, 'Cây hồng môn cỡ nhỏ chậu sứ trắng ANTH010', 240000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/cay-hong-mon-de-ban-chau-su-1-768x768.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/cay-hong-mon-de-ban-chau-su-2-125x125.jpg\r\n', 'Cây hồng môn được biết tới là một loại cây cảnh mang lại điều tốt lành, có thể giúp điều hòa khí phong thủy trong nhà, có khả năng thu hút những dòng khí tích cực và làm tiêu bớt dòng khí tiêu cực cho môi trường xung quanh, trồng cây hồng môn trong nhà sẽ giúp không gian sống trở nên hài hòa và bình yên hơn.\r\n\r\nTÊN KHOA HỌC	Anthurium andreanum\r\nTÊN GỌI KHÁC	Cây hồng môn\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 14×11.5 cm (DxC)\r\n• Chiều cao tổng: 30 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Chịu râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/lần', 96, 0, '2025-03-07 03:29:27', 1),
(16, 1, 'Cây kim ngân một thân để bàn chậu sứ LONI039', 240000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-kim-ngan-mot-than-chau-su-1-768x768.jpg', 'Cây hồng môn được biết tới là một loại cây cảnh mang lại điều tốt lành, có thể giúp điều hòa khí phong thủy trong nhà, có khả năng thu hút những dòng khí tích cực và làm tiêu bớt dòng khí tiêu cực cho môi trường xung quanh, trồng cây hồng môn trong nhà sẽ giúp không gian sống trở nên hài hòa và bình yên hơn.\r\n\r\nTÊN KHOA HỌC	Anthurium andreanum\r\nTÊN GỌI KHÁC	Cây hồng môn\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 14×11.5 cm (DxC)\r\n• Chiều cao tổng: 30 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Chịu râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/lần', 0, 0, '2025-03-07 03:29:27', 1),
(19, 1, 'Cây cọ lá xẻ mini để bàn chậu sứ hoa văn LIVI005', 160000, 20, 128000, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-co-la-xe-de-ban-chau-su-trang-1a-768x768.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-co-la-xe-de-ban-chau-su-trang-1-125x125.jpg\r\n', 'Cây cọ nhật là loại cây trong nhà có kiểu lá xòe rộng như những cánh quạt, giúp trang trí không gian thêm xanh mát. Nó còn là loại cây phong thủy tượng trưng cho sự giàu sang và tiền tài nên rất đáng trồng trên bàn làm việc.\r\n\r\nTÊN KHOA HỌC	Livistona chinensis\r\nTÊN THÔNG THƯỜNG	Cọ lá xẻ\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 14x14cm (DxC)\r\n• Chiều cao chậu + cây: 25cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần\r\n', 95, 34, '2025-03-07 03:34:11', 1),
(20, 1, 'Cây hạnh phúc để sàn 2 tầng chậu sứ hoa văn RADE032\r\n', 900000, 20, 720000, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-hanh-phuc-van-phong-2-tang-chau-su-hoa-tiet-mowgarden-768x768.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-hanh-phuc-van-phong-2-tang-chau-su-hoa-tiet-mowgarden-01-768x768.jpg', 'Cây hạnh phúc là dòng cây cảnh đẹp, sức sống khỏe mạnh, dễ chăm sóc. Trên cây có những tán lá xanh tươi, mượt mà thể hiện cho sự hi vọng và niềm tin mạnh mẽ. Với ý nghĩa mang lại may mắn và hạnh phúc nên cây thường được chọn để làm cây trưng trong nhà hoặc làm quà tặng.\r\n\r\nTÊN KHOA HỌC	Radermachera Sinica\r\nTÊN THÔNG THƯỜNG	Cây hạnh phúc\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 25x25cm (DxC)\r\n• Chiều cao tổng: 120cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 96, 0, '2025-03-07 03:34:11', 1),
(21, 1, 'Cây hạnh phúc để sàn chậu sứ RADE031', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-hanh-phuc-de-san-chau-su-trang-768x768.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-hanh-phuc-de-san-chau-su-2-125x125.jpg\r\n', 'Cây hạnh phúc là dòng cây cảnh đẹp, sức sống khỏe mạnh, dễ chăm sóc. Trên cây có những tán lá xanh tươi, mượt mà thể hiện cho sự hi vọng và niềm tin mạnh mẽ. Với ý nghĩa mang lại may mắn và hạnh phúc nên cây thường được chọn để làm cây trưng trong nhà hoặc làm quà tặng.\r\n\"\r\nTÊN KHOA HỌC	Radermachera Sinica\r\nTÊN THÔNG THƯỜNG	Cây hạnh phúc\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 23x23cm (DxC)\r\n• Chiều cao tổng: 80-100cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần\"\r\n', 98, 0, '2025-03-07 03:40:38', 1),
(22, 1, 'Cây kim ngân để bàn thắt bính tiểu cảnh chậu sứ LONI038\r\n', 380000, 20, 304000, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-kim-ngan-that-binh-lon-de-san-chau-su-768x768.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-kim-ngan-de-ban-that-binh-chau-su-mowgarden-02-768x768.jpg\r\n', 'Cây Kim Ngân là loại cây cảnh trong nhà được trồng phổ biến trên khắp thế giới, nó có sức ảnh hưởng tới mức mà hầu như ai cũng tin rằng khi trồng có thể mang lại nhiều may mắn trong cuộc sống, công việc hoặc làm ăn.\r\n\"TÊN KHOA HỌC	Pachira aquatica\r\nTÊN GỌI KHÁC	Cây kim ngân\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 20x18cm (DxC)\r\n• Chiều cao tổng: 60cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Nắng trực tiếp / Chịu râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần\"\r\n', 94, 2, '2025-03-07 03:40:38', 1),
(23, 1, 'Cây lưỡi hổ xanh để bàn mini ‘Black Gold’ chậu sứ SHBG005\r\n', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/luoi-ho-xanh-mini-mowgarden-01.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/luoi-ho-xanh-mini-mowgarden-02-125x125.jpg\r\n', 'Lưỡi hổ Thái xanh mini là dòng lưỡi hổ nhỏ để bàn, có chiều cao tối đa khoảng 20cm, không có nhiều vằn như những loại lưỡi hổ khác, nhưng nó lại sở hữu bộ lá màu xanh đậm ấn tượng, mang lại nét ‘cứng cáp’ tự nhiên cho không gian. Chúng rất thích hợp để trên bàn làm việc, kệ trang trí hoặc làm quà tặng.\r\n\r\nTÊN KHOA HỌC	Sansevieria ‘hahnii’ Black Gold\r\nTÊN GỌI KHÁC	Cây lưỡi hổ Thái xanh\r\nQUY CÁCH SẢN PHẨM	• Kích thược 12×11 cm (DxC)\r\n• Chiều cao: 10 – 15 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Chịu bóng râm tốt\r\nNHU CẦU NƯỚC	Thay nước 2 – 3 lần/tháng\r\n', 100, 0, '2025-03-07 03:44:53', 1),
(24, 1, 'Cây hạnh phúc một thân cổ thụ để bàn chậu sứ RADE030', 350000, 20, 280000, 'https://mowgarden.com/wp-content/uploads/2023/03/8-cay-hanh-phuc-de-ban-chau-su-1-125x125.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/8-cay-hanh-phuc-de-ban-chau-su-2-125x125.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/8-cay', 'Cây hạnh phúc là dòng cây cảnh đẹp, sức sống khỏe mạnh, dễ chăm sóc. Trên cây có những tán lá xanh tươi, mượt mà thể hiện cho sự hi vọng và niềm tin mạnh mẽ. Với ý nghĩa mang lại may mắn và hạnh phúc nên cây thường được chọn để làm cây trưng trong nhà hoặc làm quà tặng.\r\n\"\r\nTÊN KHOA HỌC	Radermachera Sinica\r\nTÊN THÔNG THƯỜNG	Cây hạnh phúc\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 20x15cm (DxC)\r\n• Chiều cao tổng: 35 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần\"\r\n', 99, 0, '2025-03-07 03:44:53', 1),
(25, 1, 'Cây ngọc ngân để bàn chậu sứ AGSN010\r\n', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/10-cay-ngoc-ngan-nho-de-ban-chau-su--125x125.jpg,\r\n\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/10-cay-ngoc-ngan-nho-de-ban-chau-su-2-125x125.jpg', 'Cây ngọc ngân là là cây trong nhà được đánh giá cao về phong thuỷ, người ta quan niệm rằng cây Ngọc ngân mang đến tài lộc, may mắn khi đặt trên bàn làm việc hay trang trí trong văn phòng. Về mặt tinh thần cây Ngọc ngân rất thích hợp làm quà tặng tình yêu.\r\n\"\r\nTÊN KHOA HỌC	Aglaonema Snow White\r\nTÊN GỌI KHÁC	Cây ngọc ngân\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 18x16cm (DxC)\r\n• Chiều cao: 20 – 30cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Tránh ánh nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần\"\r\n', 100, 0, '2025-03-07 05:18:32', 1),
(26, 1, 'Cây trầu bà thanh xuân cỡ lớn chậu đá mài TBTX008', 1200000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/12/cay-trau-ba-thanh-xuan-chau-da-mai.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/08/trau-ba-thanh-xuan-chau-su-trang-2-125x125.jpg', 'Trầu bà thanh xuân là loại cây trong nhà độc đáo được mọi người ưa thích và trưng bày trang trí. Trầu Bà Thanh Xuân có ý nghĩa về mặt phong thủy nó còn có ý nghĩa may mắn, đem lại tài lộc, gia tăng vận khí, thể hiện ý chí vươn lên của gia chủ.\r\n\r\nTÊN KHOA HỌC	Thaumatophyllum bipinnatifidum\r\nTÊN GỌI KHÁC	Cây trầu bà thanh xuân / Cây trầu bà tay Phật\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 30x60cm (ĐxC)\r\n• Chiều cao 140 – 150cm\r\n• Kích thước tán 90 – 100cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Bóng râm\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 95, 23, '2025-03-07 05:20:48', 1),
(27, 2, 'Hoa hồng ngoại Carey màu hồng size nhỏ ROSE012', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-ngoai-carey-rose-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-ngoai-carey-rose-12-125x125.jpg', 'Tên gọi	Carey\r\nXuất xứ	Vương Quốc Anh\r\nNgười lai tạo	David Austin\r\nĐặc tính phát triển	Thân leo\r\nMàu sắc	Trắng phớt\r\nKích cỡ bông	6 – 10 cm (khí hậu nóng)\r\nKiểu cánh	Cánh kép\r\nMùi hương	Hương hoa hồng cổ điển\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	5 – 7 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 60 – 80 cm', 100, 0, '2025-03-07 05:58:56', 1),
(28, 2, 'Hoa hồng leo Herzogin màu trắng phớt size nhỏ ROSE011\r\n', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-herzogin-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-herzogin-2-125x125.jpg', '\r\nTên gọi	Herzogin\r\nXuất xứ	Vương Quốc Anh\r\nNgười lai tạo	David Austin\r\nĐặc tính phát triển	Thân leo\r\nMàu sắc	Trắng phớt\r\nKích cỡ bông	5 – 8 cm (khí hậu nóng)\r\nKiểu cánh	Cánh kép\r\nMùi hương	Hương hoa hồng cổ điển\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	5 – 7 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 60 – 80 cm', 100, 0, '2025-03-07 06:01:24', 1),
(29, 2, 'Hoa hồng leo Crown Princess Margareta size nhỏ ROSE010', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-CPM-mau-vang-cam-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-CPM-mau-vang-cam-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-le', 'Tên gọi	Crown Princess Margareta\r\nXuất xứ	Vương Quốc Anh\r\nNgười lai tạo	David Austin\r\nĐặc tính phát triển	Thân leo\r\nMàu sắc	Màu cam cá hồi\r\nKích cỡ bông	5 – 8 cm (khí hậu nóng)\r\nKiểu cánh	Cánh kép\r\nMùi hương	Hương hoa hồng cổ điển\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	5 – 7 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 60 – 80 cm', 100, 0, '2025-03-07 06:02:25', 1),
(30, 2, 'Hoa hồng leo Lady of Shalott form cúp size nhỏ ROSE009', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-mau-cam-lady-of-shalott-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-mau-cam-lady-of-shalott-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/', 'Tên gọi	Lady of Shalott\r\nXuất xứ	Vương Quốc Anh\r\nNgười lai tạo	David Austin\r\nĐặc tính phát triển	Thân leo\r\nMàu sắc	Màu cam cá hồi\r\nKích cỡ bông	5 – 8 cm (khí hậu nóng)\r\nKiểu cánh	Cánh kép\r\nMùi hương	Hương hoa hồng cổ điển\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	3 – 4 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 60 – 80 cm', 100, 0, '2025-03-07 06:02:25', 1),
(31, 2, 'Cây hoa hồng leo Red Eden form cúp size nhỏ ROSE008\r\n', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-red-eden-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-red-eden-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-leo-red-eden-2-125', '\r\nTên gọi	Red Eden\r\nXuất xứ	Vương Quốc Anh\r\nNgười lai tạo	David Austin\r\nĐặc tính phát triển	Thân leo\r\nMàu sắc	Màu đỏ đậm\r\nKích cỡ bông	5 – 8 cm (khí hậu nóng)\r\nKiểu cánh	Cánh kép\r\nMùi hương	Ít thơm\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	5 – 12 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 60 – 80 cm', 100, 0, '2025-03-07 09:58:40', 1),
(32, 2, 'Cây hoa hồng ngoài Double Delight rất thơm size nhỏ ROSE007\r\n', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-ngoai-double-delight-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-ngoai-double-delight-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/hoa-hong-ng', '\r\nTên gọi	Double Delight\r\nXuất xứ	Hoa Kỳ\r\nNgười lai tạo	A.E & A.W.Ellis\r\nĐặc tính phát triển	Thân leo\r\nMàu sắc	Màu hồng cánh sen\r\nKích cỡ bông	5 – 8 cm (khí hậu nóng)\r\nKiểu cánh	Cánh kép\r\nMùi hương	Hương hoa hồng cổ điển\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	3 – 5 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 40 – 50 cm', 100, 0, '2025-03-07 10:00:10', 1),
(33, 2, 'Cây hoa hồng leo Golden Celebration size nhỏ ROSE006', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/cay-hoa-hong-leo-golden-celebration-david-austin-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/cay-hoa-hong-leo-golden-celebration-david-austin-2-125x125.jpg,\r\nhttps://mowgarden.com/', 'Tên gọi	Golden Celebration\r\nXuất xứ	Anh Quốc\r\nNgười lai tạo	David Austin\r\nĐặc tính phát triển	Thân leo\r\nMàu sắc	Màu hồng cánh sen\r\nKích cỡ bông	5 – 12 cm\r\nKiểu cánh	Cánh kép (17 – 50 cánh hoa)\r\nMùi hương	Ít thơm\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	3 – 5 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 60 – 80 cm', 100, 0, '2025-03-07 10:00:10', 1),
(34, 2, 'Cây bông giấy Thái dáng bonsai màu đỏ chậu ươm BGTL003\r\n', 320000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-bong-giay-bonsai-mau-do-chau-uom-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-bong-giay-bonsai-mau-do-chau-uom-2-125x125.jpg', 'Cây hoa giấy Thái bonsai được nghệ tạo dáng thân uốn lượn độc đáo và đẹp mắt. Loài cây này có sức rống rất tốt, phù hợp với khí hậu của Việt nam, chịu hạn rất tốt, sức sống bền bỉ và dễ chăm sóc. Bông giấy Thái bonsai có dáng gọn gàng phù hợp đặt trên ban công, sân thượng hoặc trưng ngoài vườn giúp không gian trở nên sinh động hơn.\r\n\r\nTÊN GỌI KHÁC	Cây bông giấy Thái\r\nKÍCH THƯỚC CÂY	Chiều cao 80 – 100 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 0, '2025-03-07 10:02:55', 1),
(35, 2, 'Cây hoa hồng phụng chậu ươm LORO001', 180000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-hoa-hong-phung-chau-uom-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-hoa-hong-phung-trong-bui-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-hoa-hong-phu', 'Cây hồng phụng (Loropetalum chinense) là một loài thực vật có hoa trong họ Hamamelidaceae. Loài cây này có những bông hoa màu hồng nổi bật, mỗi khi nở rộ rất rực rỡ. Những bông hoa này tồn tại trong một vài tuần. Chúng thích hợp trồng bồn hoa, ban công, trang trí sân vườn, lối đi sân vườn,…\r\n\r\nTÊN KHOA HỌC	Loropetalum chinense\r\nTÊN THÔNG THƯỜNG	Cây hồng phụng\r\nQUY CÁCH SẢN PHẨM	Chiều cao tổng: 90 – 120 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp 6 – 8h/ngày\r\nNHU CẦU NƯỚC	Tưới nước mỗi ngày', 95, 0, '2025-03-07 10:02:55', 1),
(36, 2, 'Cây hoa lan hoàng dương chậu ươm PEBA001', 180000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-hoa-lan-hoang-duong-chau-uom-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-hoa-lan-hoang-duong-125x125.jpg', 'Cây hoa lan hoàng dương là dòng cây thân leo, có hoa màu vàng rực rỡ, buông rủ như những tầm rèm vàng đẹp mắt. Chúng thường được trồng để phủ xanh không gian giống, thích hợp cho việc trồng trong chậu treo hoặc trồng bồn trên ban công.\r\n\r\nTÊN KHOA HỌC	Petraeovitex bambusetorum\r\nTÊN THÔNG THƯỜNG	Cây lan hoàng dương\r\nQUY CÁCH SẢN PHẨM	Chiều cao tổng: 90 – 120 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp 6 – 8h/ngày\r\nNHU CẦU NƯỚC	Tưới nước mỗi ngày', 100, 0, '2025-03-07 10:07:44', 1),
(37, 2, 'Cây hoa nguyệt quế dáng tree chậu ươm MURA002\r\n', 650000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-nguyet-que-dang-tree-tan-tron-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-nguyet-que-dang-tree-tan-tron-2-125x125.jpg', 'Cây hoa nguyệt quế loại cây trồng hàng rào rất phổ biến bởi nó có sức sống rất mãnh liệt, không cần tốn nhiều công chăm sóc mà vẫn xanh tốt. Cây ắc ó thuộc loại thân gỗ lớn, sống lâu năm, có hoa rất thơm.\r\n\r\nTÊN KHOA HỌC	Murraya paniculata\r\nTÊN THÔNG THƯỜNG	Cây nguyệt quế\r\nQUY CÁCH SẢN PHẨM	Chiều cao 120 – 140 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 97, 0, '2025-03-07 10:07:44', 1),
(38, 2, 'Cây bông giấy Thái Lan màu trắng chậu ươm BGTL002', 280000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-bong-giay-thai-lan-mau-trang-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-bong-giay-thai-lan-mau-trang-2-125x125.jpg', 'Cây hoa giấy Thái rất thích hợp với khí hậu tại VN, nó là loại cây ưa nắng ấm, cần nhiều ánh sáng.\r\n\r\nTÊN GỌI KHÁC	Cây bông giấy Thái\r\nKÍCH THƯỚC CÂY	Chiều cao 80 – 100 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 0, '2025-03-07 10:11:25', 1),
(39, 1, 'Cây tre vàng Bambusa vulgaris', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/cay-tre-vang-trong-hang-rao-san-vuon-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/cay-tre-vang-trong-hang-rao-san-vuon-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/', 'Tre Vàng là một loại cây ngoại cảnh được trồng thành khóm để trang trí sân vườn, hàng rào, sát tường hoặc dọc lối đi vào nhà giúp tạo không gian xanh mát, tô điểm thêm cho ngôi nhà và mang những ý nghĩa tốt đẹp trong phong thủy.\r\n\r\nTÊN KHOA HỌC	Bambusa vulgaris\r\nTÊN GỌI KHÁC	Tre vàng\r\nQUY CÁCH SẢN PHẨM	• Số lượng: 1 thân/bụi\r\n• Chiều cao: 180 – 220 cm\r\n`ĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp hoặc gián tiếp\r\nNHU CẦU NƯỚC	Tưới nước mỗi ngày', 98, 0, '2025-03-07 10:11:26', 1),
(40, 2, 'Cây trúc cần câu Phyllostachys aurea', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/cay-truc-can-cau-trang-tri-san-vuon-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/cay-truc-can-cau-trang-tri-san-vuon-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01', 'Trúc Cần Câu là một loại cây ngoại cảnh được trồng thành khóm để trang trí sân vườn, hàng rào, sát tường hoặc dọc lối đi vào nhà giúp tạo không gian xanh mát, tô điểm thêm cho ngôi nhà và mang những ý nghĩa tốt đẹp trong phong thủy.\r\n\r\nTÊN KHOA HỌC	Phyllostachys aurea\r\nTÊN GỌI KHÁC	Trúc cần câu\r\nQUY CÁCH SẢN PHẨM	• Số lượng: 5 8 thân/bụi\r\n• Chiều cao: 180 – 220 cm\r\n`ĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp hoặc gián tiếp\r\nNHU CẦU NƯỚC	Tưới nước mỗi ngày', 98, 0, '2025-03-07 10:15:19', 1),
(41, 2, 'Chậu hoa cúc mâm xôi trang trí xọt nhựa HCMX002', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/cuc-mam-xoi-chau-nhua-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/cuc-mam-xoi-chau-nhua-2-125x125.jpg', 'Cúc mâm xôi là một trong các loài hoa không thể thiếu vào dịp Tết cổ truyền. Chậu cúc mâm xôi có hình dáng tỏa ra theo dạng hình cầu, mang ý nghĩa vẹn tròn, cho một năm mới xuôn sẻ. Với màu vàng được xem là màu của sung túc, đầm ấm và nhiều tài lộc hơn. Do đó, người ta thường tặng cả cặp làm quà tặng cho ông bà, cha mẹ hoặc quý đối tác. \r\n\r\nTÊN KHOA HỌC	Chrysanthemum morifolium\r\nTÊN THÔNG THƯỜNG	Hoa cúc mâm xôi\r\nQUY CÁCH SẢN PHẨM	• Đường kính tán: 40cm (DxC)\r\n• Chiều cao tổng: 40 – 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 96, 0, '2025-03-07 10:15:19', 1),
(42, 2, 'Cây Trà đỏ chậu đất nung họa tiết hoa cúc Camellia Japonica', 850000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/tradomowgarden.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/tradomowgarden2-125x125.jpg', 'Bên cạnh Tắc và Mai đỏ thì một trong những cây đáng để trang trí trong nhà dịp Tết là Trà hoa đỏ với nhiều nụ chỉ chờ nở hoa rực rỡ.\r\nTÊN KHOA HỌC	Camellia Japonica\r\nTÊN THÔNG THƯỜNG	Trà hoa đỏ\r\nQUY CÁCH SẢN PHẨM	Chiều cao tổng: 80cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 4 – 5 lần/tuần', 98, 0, '2025-03-07 10:19:18', 1),
(43, 2, 'Cây Hải đường chậu sứ trắng có họa tiết Camellia amplexicaulis CAME001', 1050000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/haiduongmowgarden-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/haiduongmowgarden2-125x125.jpg', 'Hàng năm, cứ dịp tết đến xuân sang, cây hoa hải đường lại được nhiều gia đình lựa chọn đặt ở vị trí trang trọng của nhà mình. Mỗi bông hoa đỏ thắm, rực rỡ và tươi tắn như chào đón mùa xuân và hứa hẹn một năm mới nhiều điều may mắn, an lành\r\n\r\nTÊN KHOA HỌC	Camellia amplexicaulis\r\nTÊN THÔNG THƯỜNG	Hải Đường\r\nQUY CÁCH SẢN PHẨM	• Đường kính tán: 70cm\r\n• Chiều cao tổng: 130–140cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 4 – 5 lần/tuần', 100, 0, '2025-03-07 10:19:18', 1),
(46, 2, 'Cây hoa hồng cổ Sapa dáng treerose nguyên bản chậu nhựa ROSE005', 750000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/cay-hoa-hong-co-sapa-dang-treerose.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/cay-hoa-hong-co-sapa-dang-treerose-2-125x125.jpg', '\r\nTên gọi	Hoa hồng cổ Sapa\r\nXuất xứ	Pháp\r\nNgười lai tạo	Chưa xác định\r\nĐặc tính phát triển	Thân bụi\r\nMàu sắc	Màu hồng cánh sen\r\nKích cỡ bông	5 – 12 cm\r\nKiểu cánh	Cánh kép (17 – 50 cánh hoa)\r\nMùi hương	Ít thơm\r\nĐộ lặp	5 – 7 tuần/lứa\r\nĐộ bền hoa	3 – 5 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 80 – 120 cm', 100, 0, '2025-03-07 10:24:03', 1),
(47, 2, 'Cây hoa hồng Molinuex dáng treerose chậu nhựa ROSE004', 850000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/hoa-hong-molinuex-dang-treerose-chau-nhua-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/hoa-hong-molinuex-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/hoa-hong-molinu', '\r\nTên gọi	Molinuex rose\r\nXuất xứ	Anh\r\nNgười lai tạo	David Austin (2004)\r\nĐặc tính phát triển	Thân bụi cao\r\nMàu sắc	Màu vàng nhạt, cam quả mơ\r\nKích cỡ bông	5 – 12 cm\r\nKiểu cánh	Cánh kép (+25 cánh hoa)\r\nMùi hương	Hương trái cây dịu ngọt\r\nĐộ lặp	4 – 5 tuần/lứa\r\nĐộ bền hoa	3 – 5 ngày\r\nĐộ thoát nước	Yêu cầu thoát nước tốt\r\nNơi để trồng	Vị trí có nhiều nắng, thoáng gió\r\nLượng nắng cần thiết	6 – 8 giờ nắng\r\nKhả năng kháng bệnh	Kháng bệnh tốt\r\nYêu cầu chăm sóc	Dễ chăm sóc\r\nKích thước cây	Chiều cao 80 – 120 cm', 96, 0, '2025-03-07 10:24:03', 1),
(48, 3, 'Chậu xi măng hình trụ vuông vân sọc ngang màu đen XMDM017', 500000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/chau-xi-mang-hinh-tru-son-den-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/chau-xi-mang-hinh-tru-son-den-2-125x125.jpg', 'CHẤT LIỆU	Bê tông sợi\r\nKIỂU DÁNG	Remy (Trụ bo tròn)\r\nGIA CỐ	• Tấm lưới thủy tinh (GRC)\r\n• Lót chống thấm bảo vệ 2 mặt\r\nQUY CÁCH SẢN PHẨM (RxC)	30×58 (cm)\r\nTRỌNG LƯỢNG	22  (kg)\r\nMÀU SẮC	Màu trắng\r\nHOA VĂN	Granito / Tezzo', 94, 0, '2025-03-07 10:31:58', 1),
(49, 3, 'Chậu xi măng hình giọt nước 32x52cm XMDM009', 340000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-xi-mang-da-mai-giot-nuoc-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-xi-mang-da-mai-giot-nuoc-mau-den-125x125.jpg', 'CHẤT LIỆU	Xi măng, đá mài\r\nGIA CỐ	Tấm lưới thủy tinh\r\nQUY CÁCH SẢN PHẨM (RxC)	32x52cm (DxC)\r\nMÀU SẮC	Xám / Đen / Trắng\r\nHỌA TIẾT	Đá mài', 89, 0, '2025-03-07 10:31:58', 1),
(50, 3, 'Chậu xi măng đá mài đầu đạn họa tiết 29x39cm XMDM007', 320000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-xi-mang-da-mai-hinh-dau-dan-768x768.jpg', 'CHẤT LIỆU	Xi măng, đá mài\r\nGIA CỐ	Tấm lưới thủy tinh\r\nQUY CÁCH SẢN PHẨM (RxC)	29×39 (cm)\r\nMÀU SẮC	Màu xám \r\nHỌA TIẾT	Đá mài', 100, 0, '2025-03-07 10:36:31', 1),
(51, 3, 'Chậu xi măng hình trụ sơn họa tiết 40x40cm XMDM008', 520000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-xi-mang-da-mai-son-mau-768x768.jpg', 'CHẤT LIỆU	Xi măng, đá mài\r\nGIA CỐ	Tấm lưới thủy tinh\r\nQUY CÁCH SẢN PHẨM (RxC)	40×40 (cm)\r\nMÀU SẮC	Màu trắng, xanh, vàng\r\nHỌA TIẾT	Kẻ ngang', 96, 0, '2025-03-07 10:36:31', 1),
(52, 3, 'Chậu gốm sứ để bàn in chữ “Tài Lộc” 12x12cm GOSU046', 90000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-son-nhu-vang-1-768x768.jpg', 'CHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	In chữ ‘tài lộc’\r\nKÍCH THƯỚC	\r\n12x12cm (DxC)\r\n MÀU SẮC	Đỏ, vàng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 98, 0, '2025-03-07 10:39:10', 1),
(53, 3, 'Chậu gốm sứ để bàn màu vàng viền đỏ 12x12cm GOSU047', 90000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-son-nhu-vang-2-768x768.jpg', 'CHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	Gân nổi\r\nKÍCH THƯỚC	\r\n12x12cm (DxC)\r\n MÀU SẮC	Đỏ, vàng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 99, 0, '2025-03-07 10:39:10', 1),
(77, 2, 'Cây dứa diệp tiễn ‘Yucca Silver’ chậu ươm YUCA001', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-dua-diep-tien-yucca-silver-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-dua-diep-tien-yucca-silver-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-dua-d', 'Cô tòng đuôi lươn sở hữu bộ lá nhiều màu sắc rực rỡ, cùng những đường viền hoa văn độc đáo, chúngthường được trồng trang trí cho bồn hoa, ban công hoặc trước hiên nhà. Loại cây này đôi lúc được trồng trong nhà, nhưng đòi hỏi phải trồng nơi có nhiều ánh sáng, gần cửa sổ.\r\n\r\nTÊN KHOA HỌC	Yucca silver\r\nTÊN GỌI KHÁC	Cây dứa diệp tiễn / Thùa bạc\r\nQUY CÁCH SẢN PHẨM	• Kích thước tán: 35 – 40cm\r\n• Chiều cao: 35 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Nơi râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100000, 0, '2025-03-18 06:40:00', 1),
(78, 2, 'Cây cô tòng đuôi lươn ‘Croton Captain Kidd’ chậu ươm LAMA002', 65000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-co-tong-duoi-luon-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-co-tong-duoi-luon-la-mau-125x125.jpg', 'Cô tòng đuôi lươn sở hữu bộ lá nhiều màu sắc rực rỡ, cùng những đường viền hoa văn độc đáo, chúng thường được trồng trang trí cho bồn hoa, ban công hoặc trước hiên nhà. Loại cây này đôi lúc được trồng trong nhà, nhưng đòi hỏi phải trồng nơi có nhiều ánh sáng, gần cửa sổ.\r\n\r\nTÊN KHOA HỌC	Codiaeum variegatum\r\nTÊN GỌI KHÁC	Cây cô tòng đuôi lươn\r\nQUY CÁCH SẢN PHẨM	• Kích thước tán: 30 – 40cm\r\n• Chiều cao: 40 – 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp / Nắng tán xạ\r\nNHU CẦU NƯỚC	• Ngoài trời: Tưới nước hằng ngày\r\n• Trong nhà: 3 – 4 lần/tuần', 100, 0, '2025-03-18 06:40:00', 1),
(79, 2, 'Cây cô tòng lá mít ‘Croton Petra’ chậu ươm LAMA001', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-tong-la-mit-nho-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-tong-la-mit-nho-2-125x125.jpg', 'Cô tòng lá mít là loại có thể trồng được cả trong nhà lẫn ngoài trời. Với tán lá rực rỡ nhiều màu sắc như xanh lá, vàng, đỏ và cam, sẽ là một lựa chọn tuyệt vời để trang hoàng cho ngôi nhà thêm sinh động hơn.\r\n\r\nTÊN KHOA HỌC	Codiaeum variegatum ‘Petra’\r\nTÊN GỌI KHÁC	Cây cô tòng lá mít\r\nQUY CÁCH SẢN PHẨM	• Kích thước tán: 30cm\r\n• Chiều cao: 30 – 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp / Nắng tán xạ\r\nNHU CẦU NƯỚC	• Ngoài trời: Tưới nước hằng ngày\r\n• Trong nhà: 3 – 4 lần/tuần', 99, 0, '2025-03-18 06:41:53', 1),
(80, 2, 'Cây Tràm Bông Đỏ', 800000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-tram-bong-do.jpg', 'Tên phổ thông: Tràm liễu, Tràm bông đỏ, Liễu đỏ\r\nTên khoa học: Callistemon citrinus, Callistemon lanceolatus\r\nHọ thực vật: Myrtaceae (Sim)\r\nChiều cao: 2 – 4 m', 94, 0, '2025-03-18 06:41:53', 1),
(81, 2, 'Cây Bướm Hồng', 45000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-buom-hong-1-768x768.jpg', 'Tên thường gọi: Cây bướm hồng, cây hoa én hồng, cây hoa bướm bướm hồng\r\nTên khoa học: Mussaenda erythrophylla (rosea)\r\nChiều cao: 0,3 –  0,5 m', 100, 0, '2025-03-18 06:43:26', 1),
(82, 2, 'Cây hương thảo cỡ trung chậu ươm ROSM002', 90000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-huong-thao-co-trung-rosemary-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-huong-thao-co-trung-rosemary-2-125x125.jpg', 'Không chỉ có tác dụng trang trí cho góc ban công mà cây hương thảo còn là một loại cây thảo mộc giúp gia tăng hương vị cho món ăn. Cây hương thảo cũng có nhiều tác dụng đối với sức khỏe con người như giải nhiệt, lợi tiểu, giảm sưng viêm, hỗ trợ tiêu hóa, có hương thơm giúp tinh thần thoải mái.\r\n\r\nTÊN KHOA HỌC	Rosmarinus officinalis\r\nTÊN THÔNG THƯỜNG	Cây hương thảo\r\nQUY CÁCH SẢN PHẨM	Chiều cao 40 – 45 cm\r\nĐỘ KHÓ	Trung bình\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước hằng ngày', 89, 0, '2025-03-18 07:32:16', 1),
(83, 2, 'Cây cô tòng lá vàng ‘Croton Gold’ chậu ươm LAMA003', 65000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-co-tong-vang-bac-croton-golden-rust-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-co-tong-vang-bac-croton-golden-rust-2-125x125.jpg', 'Cô tòng vàng sở hữu bộ lá vàng tươi rực rỡ, chúng thường được trồng trang trí cho bồn hoa, ban công hoặc trước hiên nhà. Loại cây này đôi lúc được trồng trong nhà, nhưng đòi hỏi phải trồng nơi có nhiều ánh sáng, gần cửa sổ.\r\n\r\nTÊN KHOA HỌC	Croton Gold Dust\r\nTÊN THÔNG THƯỜNG	Cây cô tòng vàng\r\nQUY CÁCH SẢN PHẨM	Chiều cao 60 – 70 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước hằng ngày', 93, 0, '2025-03-18 07:32:16', 1),
(84, 2, 'Cây hoa dâm bụt Thái chậu ươm HIBI001', 100000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-hoa-dam-but-thai-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-hoa-dam-but-thai-2-125x125.jpg', '\r\nTÊN KHOA HỌC	Hibiscus rosa-senensis\r\nTÊN GỌI KHÁC	Hoa dâm bụt Thái\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 30 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp (thời lượng 6–8h/ngày)\r\nNHU CẦU NƯỚC	Tưới nước hằng ngày', 100, 0, '2025-03-18 07:34:51', 1),
(85, 2, 'Cây hoa nguyệt quế chậu ươm MURA001', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-nguyet-que-chau-uom-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-hoa-nguyet-que-1-1-125x125.jpg', 'Cây hoa nguyệt quế loại cây trồng hàng rào rất phổ biến bởi nó có sức sống rất mãnh liệt, không cần tốn nhiều công chăm sóc mà vẫn xanh tốt. Cây ắc ó thuộc loại thân gỗ lớn, sống lâu năm, có hoa rất thơm.\r\n\r\nTÊN KHOA HỌC	Murraya paniculata\r\nTÊN THÔNG THƯỜNG	Cây nguyệt quế\r\nQUY CÁCH SẢN PHẨM	Chiều cao 80 – 100 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 07:34:51', 1),
(86, 2, 'Cây bạch trinh biển chậu ươm nhỏ HYME001', 15000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-bach-trinh-bien-1-768x768.jpg\r\n', 'Cây bạch trinh biển là loài cây có sức sống mạnh liệt, liên tục phát triển nhánh mới, ra hoa trắng xinh quanh năm và sống lâu năm nên thường được chọn để trồng tạo cảnh quan xanh mát.\r\n\r\nTÊN KHOA HỌC	Hymenocallis littoralis\r\nTÊN THÔNG THƯỜNG	Cây bạch trinh biển\r\nQUY CÁCH SẢN PHẨM	Chiều cao 10 – 15 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 07:36:36', 1),
(87, 2, 'Cây mai chỉ thiên nhỏ chậu ươm WRIG001', 40000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-mai-chi-thien-chau-nho-768x768.jpg', 'Cây thường xuân có bộ lá xanh tươi tốt, hình dáng ấn tượng giúp mang lại không gian xanh mát. Đây là dòng cây dễ chăm đang là “trend” được nhiều người lựa chọn trồng trang trí vườn rất đẹp.\r\n\r\nTÊN TIẾNG ANH	Wrighta antidysenterica\r\nTÊN THÔNG THƯỜNG	Cây mai chỉ thiên\r\nKÍCH THƯỚC CÂY	Chiều cao 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nhiều ánh sáng / Nắng trực tiếp\r\nNHU CẦU NƯỚC	Nhiều nước, 1 lần/ngày', 100, 0, '2025-03-18 07:36:36', 1),
(92, 2, 'Cây ắc ó trồng hàng rào chậu ươm nhỏ ACAN001\r\n', 5000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-ac-o-chau-uom-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-ac-o-trong-hang-rao-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-ac-o-trong-hang-rao-2-125x1', 'Cây ắc ó là loại cây trồng hàng rào rất phổ biến bởi nó có sức sống rất mãnh liệt, không cần tốn nhiều công chăm sóc mà vẫn xanh tốt. Cây ắc ó thuộc loại thân gỗ nhỏ, có chiều cao trung bình từ 1 – 2m, là màu xanh bóng rất đẹp mắt.\r\n\r\nTÊN KHOA HỌC	Acanthus integrifolius\r\nTÊN THÔNG THƯỜNG	Cây ắc ó\r\nQUY CÁCH SẢN PHẨM	Chiều cao 20 – 30 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 07:41:18', 1),
(93, 2, 'Cây hoa lài ta chậu ươm nhỏ JASM001\r\n', 50000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-hoa-lai-ta-3-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-hoa-lai-ta-2-125x125.jpg', 'Cây lài ta loại cây trồng hàng rào rất phổ biến bởi nó có sức sống rất mãnh liệt, không cần tốn nhiều công chăm sóc mà vẫn xanh tốt. Cây ắc ó thuộc loại thân gỗ nhỏ, có chiều cao trung bình từ 1 – 2m, là màu xanh bóng rất đẹp mắt.\r\n\r\nTÊN KHOA HỌC	Jasminum sambac Ait\r\nTÊN THÔNG THƯỜNG	Cây hoa lài ta / hoa nhài ta\r\nQUY CÁCH SẢN PHẨM	Chiều cao 35 – 40 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 07:41:18', 1),
(94, 3, 'Chậu Nhựa Treo Monrovia Size L Màu Xanh', 10000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-L-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-2-125', 'CHẤT LIỆU	Nhựa dẻo cao cấp\r\nKÍCH THƯỚC MIỆNG CHẬU	24.5 (cm)\r\nKÍCH THƯỚC ĐÁY CHẬU	18.3 (cm)\r\nCHIỀU CAO CHẬU	14 (cm)\r\nCHIỀU DÀI DÂY CHẬU	40.5 (cm)\r\nCÂN NẶNG	196 (g)\r\nMÀU SẮC	Xanh tự nhiên', 0, 0, '2025-03-18 08:01:33', 1),
(95, 3, 'Chậu Nhựa Treo Monrovia Size M Màu Xanh', 50000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-M-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-2-125', 'CHẤT LIỆU	Nhựa dẻo cao cấp\r\nKÍCH THƯỚC MIỆNG CHẬU	24.5 (cm)\r\nKÍCH THƯỚC ĐÁY CHẬU	18.3 (cm)\r\nCHIỀU CAO CHẬU	14 (cm)\r\nCHIỀU DÀI DÂY CHẬU	40.5 (cm)\r\nCÂN NẶNG	196 (g)\r\nMÀU SẮC	Xanh tự nhiên', 0, 0, '2025-03-18 08:01:33', 1),
(96, 3, 'Chậu Nhựa Treo Monrovia Size S Màu Xanh', 40000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-S-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/gio-treo-hoa-monrovia-2-125', 'CHẤT LIỆU	Nhựa dẻo cao cấp\r\nKÍCH THƯỚC MIỆNG CHẬU	24.5 (cm)\r\nKÍCH THƯỚC ĐÁY CHẬU	18.3 (cm)\r\nCHIỀU CAO CHẬU	14 (cm)\r\nCHIỀU DÀI DÂY CHẬU	40.5 (cm)\r\nCÂN NẶNG	196 (g)\r\nMÀU SẮC	Xanh tự nhiên', 0, 0, '2025-03-18 08:01:33', 1),
(97, 3, 'Chậu Nhựa Monrovia 6 Gallon Màu Xanh Tự Nhiên', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/Chau-nhua-trong-cay-Monrovia-6-gallon-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/Chau-nhua-trong-cay-Monrovia-2-gallon-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/', '\r\nCHẤT LIỆU	Nhựa dẻo cao cấp\r\nQUY CÁCH SẢN PHẨM	30x30x22.6 (cm)\r\nDUNG TÍCH	14 (lít)\r\nTRỌNG LƯỢNG	390 (g)\r\nMÀU SẮC	Xanh tự nhiên', 100, 0, '2025-03-18 08:08:47', 1),
(98, 3, 'Chậu Nhựa Monrovia 4 Gallon Màu Xanh Tự Nhiên', 80000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/Chau-nhua-trong-cay-Monrovia-4-gallon-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/Chau-nhua-trong-cay-Monrovia-2-gallon-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/', '\r\nCHẤT LIỆU	Nhựa dẻo cao cấp\r\nQUY CÁCH SẢN PHẨM	30x30x22.6 (cm)\r\nDUNG TÍCH	14 (lít)\r\nTRỌNG LƯỢNG	390 (g)\r\nMÀU SẮC	Xanh tự nhiên', 100, 0, '2025-03-18 08:08:47', 1),
(99, 3, 'Chậu Nhựa Monrovia 2 Gallon Màu Xanh Tự Nhiên', 80000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/Chau-nhua-trong-cay-Monrovia-2-gallon-768x770.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/Chau-nhua-trong-cay-Monrovia-2-gallon-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/', 'CHẤT LIỆU	Nhựa dẻo cao cấp\r\nQUY CÁCH SẢN PHẨM	22x22x16.7 (cm)\r\nDUNG TÍCH	7.7 (lít)\r\nTRỌNG LƯỢNG	169 (g)\r\nMÀU SẮC	Xanh tự nhiên', 100, 0, '2025-03-18 08:08:47', 1),
(100, 2, 'Cây Philodendron Paraiso Verde', 450000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/03/philodendron-paraiso.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/03/philodendron-paraiso-verde-125x125.jpg', 'Nếu lúc trước muốn được sở hữu 1 Paraiso đẹp thì giá không hề dễ chịu. Nhưng hiện nay Paraiso gọi là cây quốc dân bất kể ai cũng có thể săn đón dễ dàng.\r\n\r\nTÊN KHOA HỌC	Philodendron Paraiso Verde\r\nTÊN GỌI KHÁC	Paraiso\r\nQUY CÁCH SẢN PHẨM	• Size nhỏ: Lá 10 cm  – 15 cm\r\n• Size trung: Lá 20 cm – 25 cm\r\n• Size lớn: Lá 30 cm – 35 cm\r\nĐỘ KHÓ	Trung bình\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Tránh ánh nắng trực tiếp\r\nNHU CẦU NƯỚC	• Vừa phải\r\n• Đất trồng thông thoáng', 100, 0, '2025-03-18 08:18:26', 1),
(101, 1, 'Cây Trường Sinh Thủy Sinh Peperomia obtusifolia PEOB002', 140000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/cay-truong-sinh-thuy-sinh-de-ban-1.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/cay-truong-sinh-thuy-sinh-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/cay-truong-sinh-thuy', 'Cây trường sinh (Peperomia obtusifolia) là một loại cây cảnh trong nhà đẹp mắt, với bộ lá luôn xanh mát, sức sống mãnh liệt, dễ chăm sóc. Đây cũng là loại cây phong thủy với tác dụng mang đến sức khỏe, may mắn và tiền tài tới cho gia chủ. Người ta thường hay tặng cây trường sinh vào những dịp đặc biệt như là một lời chúc phúc tới người nhận.\r\n\r\nTÊN KHOA HỌC	Peperomia obtusifolia\r\nTÊN GỌI KHÁC	Cây trường sinh\r\nKÍCH THƯỚC CÂY	Cao 40 – 60 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Chịu râm mát\r\nNHU CẦU NƯỚC	Thay nước 2 – 3 lần/tháng', 100, 0, '2025-03-18 08:18:26', 1),
(102, 1, 'Cây kim ngân thủy sinh để bàn LONI005', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/cay-kim-ngan-mot-than-thuy-sinh-1-768x768.jpg', 'Cây Kim Ngân (Pachira aquatica) là dòng cây nội thất được ưu chuộng và phổ biến nhất trên thế giới, nó được biết đến là loại cây phong thủy giúp mang lại những điều tốt lành, vận may và tiền tài tới cho gia chủ.\r\n\r\nTÊN KHOA HỌC	Pachira aquatica\r\nTÊN GỌI KHÁC	Cây kim ngân\r\nKÍCH THƯỚC CÂY	Cao 40 – 60 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Chịu râm mát\r\nNHU CẦU NƯỚC	Thay nước 2 – 3 lần/tháng', 100, 0, '2025-03-18 08:20:23', 1),
(103, 2, 'Cây kim ngân lượng trang trí tết chậu sứ cao CKNL010', 650000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-kim-ngan-trung-tet-2023-3-768x768.jpg', 'Cây kim ngân lượng mang vẻ đẹp lộng lẫy với chùm quả đỏ tươi xum xuê, mang hàm ý về tiền tài và phú quý. Trưng cây kim ngân lượng vào những dịp đầu năm là một cách để chiêu tài, may mắn trong dịp Tết. Những người làm ăn kinh doanh khi trồng kim ngân lượng sẽ giúp công việc buôn bán suôn sẻ và thuận lợi.\r\n\r\nTÊN KHOA HỌC	Ardisia crenata\r\nTÊN THÔNG THƯỜNG	Kim ngân lượng\r\nQUY CÁCH SẢN PHẨM	Kích thước chậu: 32×50 cm\r\nChiều cao tổng: 110 – 120 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:20:23', 1),
(106, 1, '\r\n Add to wishlist\r\n\r\ncây kim ngân lượng trang trí tết\r\nCây kim ngân lượng trang trí tết gói vải vàng CKNL008', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/11/cay-kim-ngan-trung-tet-2023-a-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/11/cay-kim-ngan-luong-trung-tet-125x125.jpg', 'Cây kim ngân lượng mang vẻ đẹp lộng lẫy với chùm quả đỏ tươi xum xuê, mang hàm ý về tiền tài và phú quý. Trưng cây kim ngân lượng vào những dịp đầu năm là một cách để chiêu tài, may mắn trong dịp Tết. Những người làm ăn kinh doanh khi trồng kim ngân lượng sẽ giúp công việc buôn bán suôn sẻ và thuận lợi.\r\n\r\nTÊN KHOA HỌC	Ardisia crenata\r\nTÊN THÔNG THƯỜNG	Kim ngân lượng\r\nQUY CÁCH SẢN PHẨM	Chiều cao tổng: 80 – 90 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:23:30', 1),
(107, 1, 'Cây Môn Caladium Aaron', 500000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/11/Caladium-Aaron-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/11/CaladiumAaron-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/11/Caladium-Aaron-1-125x125.jpg', '\r\nTÊN KHOA HỌC	Caladium Aaron\r\nTÊN GỌI KHÁC	• Caladium Aaron\r\nKÍCH THƯỚC CÂY	Chiều cao 30 – 40 cm\r\nĐỘ KHÓ	Dễ sống\r\nYÊU CẦU ÁNH SÁNG	Ít sáng / Bóng râm / Tán xạ\r\nNHU CẦU NƯỚC	Vừa phải, 2 – 3  lần/tuần', 100, 0, '2025-03-18 08:23:30', 1);
INSERT INTO `product` (`id`, `cate_id`, `name`, `price`, `sale`, `price_sale`, `images`, `discription`, `inventory_quantity`, `view`, `create_date`, `status`) VALUES
(108, 1, 'Cây Trầu Bà Tim Nâu Philodendron hederaceum Micans', 70000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/11/trau-ba-tim-nau-micans-1a.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/11/trau-ba-tim-nau-micans-2a-125x125.jpg', 'Trầu bà tim nâu (Philodendron hederaceum Micans) sở hữu những chiếc lá màu xanh nâu hình trái tim quyến rũ, có thể trồng theo phong cách thả xuống trên kệ trang trí, trên tủ sách hoặc được treo lơ lửng, cũng có thể được gắn vào cột leo đẹp mắt. Chúng có khả năng sinh trưởng nhanh chóng và rất dễ chăm sóc, chỉ cần tưới một lần một tuần.\r\n\r\nTÊN KHOA HỌC	Philodendron hederaceum Micans\r\nTÊN GỌI KHÁC	• Trầu bà tim nâu\r\n• Trầu bà Micans\r\nQUY CÁCH SẢN PHẨM	Dài: 30 – 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Bóng râm\r\nNHU CẦU NƯỚC	Ít tưới (1 – 2 lần/tuần)', 100, 0, '2025-03-18 08:25:39', 1),
(109, 1, 'Cây kim ngân 3 thân để bàn chậu ươm LONI002\r\n', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/11/cay-kim-ngan-3-than-mini-de-ban-chau-uom.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/11/cay-kim-ngan-xoan-nho-3-125x125.jpg', 'Cây kim ngân thân xoắn với dáng cao độc đáo rất phù hợp để trang trí trong nhà, như là trong phòng khách, kệ trang trí hoặc bàn làm việc. Nà là giống cây cảnh nội thất có sức ảnh hưởng tới mức mà hầu như ai cũng tin rằng khi trồng có thể mang lại nhiều may mắn trong cuộc sống, công việc hoặc làm ăn.\r\n\r\nTÊN KHOA HỌC	Pachira aquatica\r\nTÊN GỌI KHÁC	• Cây kim ngân\r\n• Money Tree\r\n• Money Plant\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 50cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Nắng trực tiếp\r\nNHU CẦU NƯỚC	Vừa phải (2 lần/tuần)', 100, 0, '2025-03-18 08:25:39', 1),
(110, 1, 'Cây kim ngân lượng để bàn trang trí tết chậu sứ CKNL004', 300000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-kim-ngan-luong-de-ban-trang-tri-tet-768x768.jpg', 'Cây kim ngân lượng mang vẻ đẹp lộng lẫy với chùm quả đỏ tươi xum xuê, mang hàm ý về tiền tài và phú quý. Trưng cây kim ngân lượng vào những dịp đầu năm là một cách để chiêu tài, may mắn trong dịp Tết. Những người làm ăn kinh doanh khi trồng kim ngân lượng sẽ giúp công việc buôn bán suôn sẻ và thuận lợi.\r\n\r\nTÊN KHOA HỌC	Ardisia crenata\r\nTÊN THÔNG THƯỜNG	Kim ngân lượng\r\nQUY CÁCH SẢN PHẨM	Chiều cao tổng: 100 – 120 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:28:01', 1),
(111, 1, 'Cây kim ngân lượng trang trí tết gói vải đỏ CKNL009', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-kim-ngan-trung-tet-2023-2-768x768.jpg', 'Cây kim ngân lượng mang vẻ đẹp lộng lẫy với chùm quả đỏ tươi xum xuê, mang hàm ý về tiền tài và phú quý. Trưng cây kim ngân lượng vào những dịp đầu năm là một cách để chiêu tài, may mắn trong dịp Tết. Những người làm ăn kinh doanh khi trồng kim ngân lượng sẽ giúp công việc buôn bán suôn sẻ và thuận lợi.\r\n\r\nTÊN KHOA HỌC	Ardisia crenata\r\nTÊN THÔNG THƯỜNG	Kim ngân lượng\r\nQUY CÁCH SẢN PHẨM	Chiều cao tổng: 80 – 90 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:28:01', 1),
(112, 1, 'Cây kim ngân lượng chậu sứ trang trí tết CKNL007', 950000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-kim-ngan-luong-trang-tri-tet-2022-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/10/cay-kim-ngan-luong-trang-tri-tet-2022-1-125x125.jpg', 'Cây kim ngân lượng mang vẻ đẹp lộng lẫy với chùm quả đỏ tươi xum xuê, mang hàm ý về tiền tài và phú quý. Trưng cây kim ngân lượng vào những dịp đầu năm là một cách để chiêu tài, may mắn trong dịp Tết. Những người làm ăn kinh doanh khi trồng kim ngân lượng sẽ giúp công việc buôn bán suôn sẻ và thuận lợi.\r\n\r\nTÊN KHOA HỌC	Ardisia crenata\r\nTÊN THÔNG THƯỜNG	Kim ngân lượng\r\nQUY CÁCH SẢN PHẨM	Kích thước chậu: 22×22 cm\r\nChiều cao tổng: 90 – 100 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 0, 0, '2025-03-18 08:29:17', 1),
(113, 1, 'Cây kim ngân lượng chậu sứ trang trí tết CKNL006', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-kim-ngan-luong-trang-tri-tet-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-kim-ngan-luong-trang-tri-tet-125x125.jpg', 'Cây kim ngân lượng mang vẻ đẹp lộng lẫy với chùm quả đỏ tươi xum xuê, mang hàm ý về tiền tài và phú quý. Trưng cây kim ngân lượng vào những dịp đầu năm là một cách để chiêu tài, may mắn trong dịp Tết. Những người làm ăn kinh doanh khi trồng kim ngân lượng sẽ giúp công việc buôn bán suôn sẻ và thuận lợi.\r\n\r\nTÊN KHOA HỌC	Ardisia crenata\r\nTÊN THÔNG THƯỜNG	Kim ngân lượng\r\nQUY CÁCH SẢN PHẨM	Kích thước chậu: 22×22 cm\r\nChiều cao tổng: 90 – 100 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:29:17', 1),
(114, 1, 'Cây cau tiểu trâm mini để bàn chậu ươm CHAM001', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/06/cay-cau-tieu-tram-CHAMAEDOREA-ELEGANS-1-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/06/cay-cau-tieu-tram-CHAMAEDOREA-ELEGANS-3-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads', 'Công việc đòi hỏi bạn phải tiếp xúc hằng ngày với các thiết bị hiện đại có nhiều bức xạ điện tử như máy tính, máy in, điện thoại khiến cho tình trạng sức khỏe bị ảnh hưởng, dẫn đến giảm chất lượng công việc.\r\n\r\nTÊN KHOA HỌC	Chamaedorea elegans\r\nTÊN GỌI KHÁC	Cau tiểu trâm\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 10 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ\r\nNHU CẦU NƯỚC	Ít tưới (1 – 2 lần/tuần)', 100, 0, '2025-03-18 08:30:38', 1),
(115, 1, 'Callisia Repens “Pink Lady”', 165000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/Callisia-Repens-768x768.jpg', '', 100, 0, '2025-03-18 08:30:38', 1),
(116, 1, 'Cây Đuôi Công Calathea Thai Beauty', 680000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/calathea_duoi_cong_thai_beauty_xanh_decor_4.jpg', 'Calathea Thai Beauty là loài thực vật thân thảo, có lá hình thuôn tròn, màu xanh đậm, họa tiết viền xanh nhạt. Loài này rất dễ sống, thường được trồng để trang trí trong nhà, thanh lọc không khí và mang ý nghĩa đem lại may mắn, thành công và thịnh vượng.\r\n\r\nTÊN GỌI KHÁC	Cây Đuôi Công\r\nTÊN TIẾNG ANH	Calathea Thai Beauty\r\nKÍCH THƯỚC CÂY	Cao 30 cm\r\nĐỘ KHÓ	Vừa phải\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần\r\nĐỘ pH CỦA ĐẤT	Tính axit\r\nLỌC KHÔNG KHÍ	Có khả năng hấp thu chất độc hại', 100, 0, '2025-03-18 08:32:04', 1),
(117, 1, 'Cây đuôi công tím Calathea roseopicta chậu sứ CATH143', 240000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-duoi-cong-tim-calathea-roseopicta-dottie.jpg', 'Calathea Roseopicta Dottie là loài thực vật thân thảo, có lá hình thuôn tròn, màu hồng. Hay được gọi với tên là Cây Đuôi Công Tím. Loài này rất dễ sống, thường được trồng để trang trí trong nhà, thanh lọc không khí và mang ý nghĩa đem lại may mắn, thành công và thịnh vượng.\r\n\r\nTÊN KHOA HỌC	Calathea roseopicta Dottie\r\nTÊN THÔNG THƯỜNG	Cây đuôi công tím\r\nKÍCH THƯỚC CÂY	Chiều cao 10 – 20 cm\r\nĐỘ KHÓ	Trung bình\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu râm mát\r\nNHU CẦU NƯỚC	4 – 5 lần/tuần', 100, 0, '2025-03-18 08:32:04', 1),
(120, 1, 'Cây đuôi công ‘Network’ để bàn chậu đất nung CATH722', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/calathea-musaica-network-768x768.jpg', 'Với những vân lá tạo nên hoạ tiết ô lưới ngẫu nhiên độc đáo như một bức tranh mosaic kì công. Calathea Network tạo nên sự khác biệt không thể tìm thấy với bất kỳ loại cây nào.\r\n\r\nTÊN TIẾNG ANH	Calathea Musaica\r\nTÊN THÔNG THƯỜNG	Cây đuôi công ‘Network’\r\nKÍCH THƯỚC CÂY	Chiều cao 20 – 25 cm\r\nĐỘ KHÓ	Vừa phải\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Nơi râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:33:07', 1),
(121, 1, 'Cây thu hải đường cánh thiên thần chậu ươm BEGO001', 240000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-thu-hai-duong-la-dom-begonia-Maculata-Wightii-768x768.jpg', 'Trong họ Thu Hải Đường này thì loài lá đốm là loài nổi tiếng nhất và được trồng nhiều nhất. Hoa của chúng màu trắng hoặc hồng khá bền màu và bền hoa\r\n\r\nTÊN KHOA HỌC	Begonia Maculata Wightii\r\nTÊN GỌI KHÁC	Cây thu hải đường cánh thiên thần\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 30 – 40 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Bóng râm\r\nNHU CẦU NƯỚC	Tưới nước 3 – 4 lần/tuần', 100, 0, '2025-03-18 08:33:07', 1),
(122, 1, 'Cây ngũ gia bì cẩm thạch chậu ươm SCHE010', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-ngu-gia-bi-cam-thach-1.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-ngu-gia-bi-cam-thach-2-125x125.jpg', 'gũ gia bì là loại cây mang lại tài vận, thịnh vượng và may mắn, trồng trong nhà sẽ mang đến một không gian thư thái, trong lành cho gia đình.\r\n\r\nTÊN KHOA HỌC	Scheffera Octophylla\r\nTÊN THÔNG THƯỜNG	Ngũ gia bì cẩm thạch\r\nQUY CÁCH SẢN PHẨM	Chiều cao ~80 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:34:25', 1),
(123, 1, 'Cây kim tiền chậu đất nung họa tiết thổ cẩm ZAMI005', 185000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-kim-tien-de-ban-chau-dat-nung.jpg', 'Cây kim tiền rất dễ sống vì có thể trồng tại nơi có ít ánh sáng, và nó cũng không cần đến quá nhiều nước để phát triển. Loại cây này thường được lựa chọn để đặt trong nhà để tạo thêm mảng xanh, đồng thời được trồng với tác dụng phong thủy.\r\n\r\nTÊN KHOA HỌC	Zamioculcas zamiifolia\r\nTÊN GỌI KHÁC	Cây kim tiền\r\nKÍCH THƯỚC CÂY	Chiều cao 30 – 40 cm\r\nĐỘ KHÓ	Dễ sống\r\nYÊU CẦU ÁNH SÁNG	Ít sáng / Bóng râm / Tán xạ\r\nNHU CẦU NƯỚC	Vừa phải, 2 – 3  lần/tuần', 100, 0, '2025-03-18 08:34:25', 1),
(124, 1, 'Cây đa búp đỏ để bàn 3 thân chậu sứ CDBD002', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-da-bup-do-de-ban-mowgarden-800x960.jpg', 'Từ lâu cây Đa luôn là biểu tượng của sự trường tồn, sức sống dẻo dai, nơi chứa đựng thần quyền và tâm linh của con người. Chính lẽ đó mà trong phong thủy, Đa Búp Đỏ cũng mang ý nghĩa của sự may mắn, an lành.\r\n\r\nTÊN KHOA HỌC	Ficus elastica\r\nTÊN GỌI KHÁC	Đa búp đỏ\r\nQUY CÁCH SẢN PHẨM	Chiều cao 40 – 50cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Bóng râm\r\nNHU CẦU NƯỚC	Vừa phải, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:35:34', 1),
(125, 1, 'Cây Trầu Bà Đế Vương Xanh Để Bàn DVX002', 350000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/trau-ba-de-vuong-xanh-de-ban-mowgarden-768x768.jpg', 'Trầu Bà Đế Vương có tên tiếng Anh là Philodendron Imperial thuộc họ Araceae (Ráy). Nguồn gốc của cây từ đảo Solomon, nguyên sinh ở Indonesia, là dòng cây thân thảo, trong tự nhiên dòng cây này có thể cao hơn 1.5m, nhưng với mục đích trang trí thì MOW sẽ gửi đến các bạn cây với kích cỡ nhỏ để tiện đặt ở bất cứ đâu mình thích.\r\n\r\nNgay từ cái tên thì chúng ta đã hiểu được phần nào ý nghĩa của loài cây này, chúng không những thể hiện sự quyết tâm, ý chí vươn lên đến đỉnh cao nhất mà còn mang đến nhiều may mắn, tài lộc đến cho người trồng.\r\n\r\nTÊN GỌI KHÁC	Cây Trầu Bà Đế Vương Xanh\r\nTÊN TIẾNG ANH	Philodendron Imperial Green\r\nKÍCH THƯỚC CÂY	Cao 20 – 40 cm\r\nĐỘ KHÓ	Vừa phải\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần\r\nĐỘ pH CỦA ĐẤT	Tính axit\r\nLỌC KHÔNG KHÍ	Có khả năng hấp thu chất độc hại', 100, 0, '2025-03-18 08:35:34', 1),
(126, 1, 'Cây Ngà voi chậu gốm để bàn Sansevireria Cylindrica SANS001', 300000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/92-cay-nga-voi-768x768.jpg', 'Hình dáng bên ngoài độc đáo như chính tên gọi, bởi giống như những chiếc ngà voi vươn thẳng lên cao.\r\n\r\nTÊN KHOA HỌC	Sansevireria Cylindrica\r\nTÊN THÔNG THƯỜNG	Ngà voi\r\nQUY CÁCH SẢN PHẨM	Cao 20 – 25 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:38:30', 1),
(127, 1, 'Cây Lưỡi hổ kim cương đen để bàn Sansevieria Trifasciata Black Diamond SANS002', 300000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/luoi-ho-thai-Sansevieria-Black-Diamond.jpg', 'Lưỡi hổ “Black Diamond” không có nhiều vằn như những loại lưỡi hổ khác, nhưng nó lại sở hữu bộ lá màu xanh lá bóng mượt ấn tượng, mang lại nét cứng cáp tự nhiên cho không gian nội thất.\r\n\r\nTÊN KHOA HỌC	Sansevieria trifasciata Black Diamond\r\nTÊN THÔNG THƯỜNG	Lưỡi hổ Thái kim cương đen\r\nQUY CÁCH SẢN PHẨM	Cao 20 – 25 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:38:30', 1),
(128, 1, 'Cây Đuôi công xương cá Calathea burle-marxii CATH546', 340000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/148-cay-duoi-cong-xuong-ca-de-ban-768x768.jpg', 'Cây đuôi công thường được chọn để mang lại không gian xanh mát cho phòng làm việc, phòng làm việc, văn phòng, quán cafe,… Bởi loài cây có những đường vân sọc độc đáo, cùng màu xanh dễ chịu giúp căn phòng trở nên tươi mát và sang trọng hơn.\r\n\r\nTÊN KHOA HỌC	Calathea burle-marxii\r\nTÊN GỌI KHÁC	Đuôi công xương cá\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 45cm – Tán: 25cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Chịu được khuất sáng\r\nNHU CẦU NƯỚC	Tưới nước 5 – 6 lần/tuần', 100, 0, '2025-03-18 08:39:22', 1),
(129, 1, 'Cây kim ngân để bàn chậu sứ tuổi Tuất LONI010\r\n', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-kim-ngan-de-ban-chau-gom-mowgarden-768x768.jpg', 'Kim ngân là loại cây mang ý nghĩa may mắn, tài lộc và thường được làm quà biếu trong các dịp khai trương, tân gia, lên chức… như lời cầu chúc vạn sự may mắn, tấn tài tấn lộc đến người nhận.Chọn vị trí đặt cây cũng khá quan trọng để thu hút sự thịnh vượng và may mắn cho gia chủ.\r\n\r\nTÊN KHOA HỌC	Lonicera periclymenum\r\nTÊN THÔNG THƯỜNG	Cây kim ngân\r\nQUY CÁCH SẢN PHẨM	Cao 30 – 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:39:22', 1),
(130, 1, 'Cây Ngọc Ngân để bàn chậu gốm size Trung – Aglaonema Snow White CNN002\r\n', 450000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-ngoc-ngan-chau-gom-mowgarden-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/08/cay-ngoc-ngan-chau-gom-mowgarden-01-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-ng', 'Cây ngọc ngân thuộc dòng thân thảo, họ nhà Araceae, lá hình bầu, thuôn nhọn dần về đuôi. Lá cây mềm, màu xanh đốm trắng khá đặc trưng, viền lá màu xanh đậm và mướt. Cây ngọc ngân thuộc giống cây ưa bóng và sinh trưởng mạnh ở nơi mát mẻ rất thích hợp trồng cửa sổ phòng ngủ, phòng khách và trang trí cho cảnh quan văn phòng, quán cafe.\r\n\r\nTÊN KHOA HỌC	Aglaonema Snow White\r\nTÊN GỌI KHÁC	Cây ngọc ngân\r\nQUY CÁCH SẢN PHẨM	Cao 30 – 40 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Tưới nước 1-2 lần/ tuần', 0, 0, '2025-03-18 08:40:28', 1),
(131, 1, 'Cây trầu bà thanh xuân cỡ lớn chậu ươm TBTX002', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-trau-ba-thanh-xuan-co-lon-chau-uom-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/trau-ba-thanh-xuan-haumatophyllum-bipinnatifidum-2-125x125.jpg', 'Trầu bà thanh xuân là loại cây trong nhà độc đáo được mọi người ưa thích và trưng bày trang trí. Trầu Bà Thanh Xuân có ý nghĩa về mặt phong thủy nó còn có ý nghĩa may mắn, đem lại tài lộc, gia tăng vận khí, thể hiện ý chí vươn lên của gia chủ.\r\n\r\nTÊN KHOA HỌC	Thaumatophyllum bipinnatifidum\r\nTÊN GỌI KHÁC	Cây trầu bà thanh xuân / Cây trầu bà tay Phật\r\nQUY CÁCH SẢN PHẨM	Chiều cao 80 – 100cm bao gồm chậu\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Bóng râm\r\nNHU CẦU NƯỚC	Ít tưới nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:40:28', 1),
(132, 1, 'Cây Tùng thơm Cupressus Macrocarpa chậu xi măng nhỏ để bàn CUPR001', 420000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/caytungthom.jpg', 'Còn được biết đến với cái tên Tùng chanh\r\n\r\nTÊN KHOA HỌC	Cupressus Macrocarpa\r\nTÊN THÔNG THƯỜNG	Tùng thơm\r\nQUY CÁCH SẢN PHẨM	Cao 60-80 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:42:11', 1),
(133, 1, 'Cây Tóc thần vệ nữ chậu gốm trắng để bàn ADIA001', 450000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/182765171_4040387049389537_995992012131540443_n-transformed-%E2%80%93-Da-sua-768x768.jpg', 'Một loại dương xỉ sống ở vùng ẩm, hơi lạnh, thường thấy ở dọc bờ suối, còn có tên gọi khác là cây tóc tiên, cỏ dây thép…\r\n\r\nTÊN KHOA HỌC	Adiantum cadatum\r\nTÊN THÔNG THƯỜNG	Tóc thần vệ nữ\r\nQUY CÁCH SẢN PHẨM	Cao 40 – 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:42:11', 1),
(134, 1, 'Cây hương thảo chậu gốm xanh có họa tiết CHT001', 490000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/huongthao-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/08/cay-huong-thao-chau-su-xanh-mowgarden-125x125.jpg', 'Có một mùi thơm rất dễ chịu. Thân cây phân nhánh và mọc thành bụi rậm rạp với rất nhiều chiếc lá xanh mướt phủ xung quanh.\r\n\r\nTÊN KHOA HỌC	Rosmarinus Officinalis\r\nTÊN THÔNG THƯỜNG	Hương thảo\r\nQUY CÁCH SẢN PHẨM	Cao 30 – 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:43:28', 1),
(135, 1, 'Cây trầu bà hạnh phúc để bàn chậu gốm Monstera Pinnatipartita MONS015', 350000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/traubahanhphucmowgarden-768x768.jpg', 'Cây có bản lá to màu xanh thuộc hành Mộc nên cây phù hợp làm cây phong thủy cho người mệnh Mộc và mệnh Hỏa, mang đến may mắn, thành đạt và bình an cho gia chủ.\r\n\r\nTÊN KHOA HỌC	Monstera Pinnatipartita\r\nTÊN THÔNG THƯỜNG	Trầu bà hạnh phúc\r\nQUY CÁCH SẢN PHẨM	Cao 40 – 60 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ.\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:43:28', 1),
(136, 2, 'Cây bưởi da xanh chậu ươm FRUI001', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-buoi-da-xanh-nho.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-buoi-da-xanh-co-trai-125x125.jpg', 'Cây bưởi da xanh loại cây có múi được trồng rất phổ biến tại nước ta, thích hợp trồng nơi có nhiều ánh sáng và thoáng mát như sân vườn để tạo bóng mát và để lấy trái. Cây cần được tưới nước thường xuyên để luôn xanh tốt.\r\n\r\nTÊN GỌI KHÁC	Cây bưởi da xanh\r\nKÍCH THƯỚC CÂY	Chiều cao 60 – 80 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 0, '2025-03-18 08:45:02', 1),
(137, 2, 'Cây mận đỏ An Phước chậu ươm FRUI004', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-man-do-an-phuoc-1.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-man-do-an-phuoc-2-125x125.jpg', 'Cây mận đỏ An Phước là loại cây ăn tái thích hợp trồng nơi có nhiều ánh sáng và thoáng mát như sân vườn để tạo bóng mát và để lấy trái. Cây cần được tưới nước thường xuyên để luôn xanh tốt.\r\n\r\nTÊN GỌI KHÁC	Cây mận đỏ an phước\r\nKÍCH THƯỚC CÂY	Chiều cao 60 – 70 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 0, '2025-03-18 08:45:02', 1),
(138, 2, 'Cây hoa nguyệt quế chậu ươm MURA001', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-nguyet-que-chau-uom.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-hoa-nguyet-que-1-1-125x125.jpg', 'Cây hoa nguyệt quế loại cây trồng hàng rào rất phổ biến bởi nó có sức sống rất mãnh liệt, không cần tốn nhiều công chăm sóc mà vẫn xanh tốt. Cây ắc ó thuộc loại thân gỗ lớn, sống lâu năm, có hoa rất thơm.\r\n\r\nTÊN KHOA HỌC	Murraya paniculata\r\nTÊN THÔNG THƯỜNG	Cây nguyệt quế\r\nQUY CÁCH SẢN PHẨM	Chiều cao 80 – 100 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:46:03', 1),
(140, 2, 'Dây Sử Quân Tử/ Cây Trang Leo', 330000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/su_quan_tu_1_1024x1024-692x800.jpg', '', 100, 0, '2025-03-18 08:47:34', 1),
(141, 2, 'Dây Thiên Lý/ Hoa Dạ Lý Hương – Cao 70 Cm', 84000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/thien_ly_1_1024x1024.jpg', '', 100, 0, '2025-03-18 08:47:34', 1),
(142, 2, 'Cây đa tam phúc một thân chậu ươm FICU059', 350000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-da-tam-phuc-1.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-da-tam-phuc-2-125x125.jpg', 'Ficus Triangularis Variegata còn gọi là Si Thái cẩm thạch hay Đa tam phúc.\r\n\r\nNhững tán lá hình trái tim điểm tô bởi những màu sắc xanh vàng bắt mắt. Đây là loại cây trồng ưa sáng, nắng. Nên bạn nên trồng ngoài trời hoặc góc nhà có thật nhiều ánh sáng nhé. Tưới nước khi thấy chất trồng khô đi, tuỳ thuộc nơi bạn đặt chậu. Không để đất khô, hoặc trồng thiếu sáng cây dễ bị rụng lá.', 100, 0, '2025-03-18 08:48:33', 1),
(143, 2, 'Cây mận đỏ An Phước chậu ươm FRUI004', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-man-do-an-phuoc-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-man-do-an-phuoc-2-125x125.jpg', 'Cây mận đỏ An Phước là loại cây ăn tái thích hợp trồng nơi có nhiều ánh sáng và thoáng mát như sân vườn để tạo bóng mát và để lấy trái. Cây cần được tưới nước thường xuyên để luôn xanh tốt.\r\n\r\nTÊN GỌI KHÁC	Cây mận đỏ an phước\r\nKÍCH THƯỚC CÂY	Chiều cao 60 – 70 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 0, '2025-03-18 08:48:33', 1),
(144, 3, 'Chậu gốm sứ hình đa giác 10x10cm GOSU044', 50000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-hinh-da-giac.jpg', '\r\nCHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	Trơn\r\nKÍCH THƯỚC	\r\n10x10cm (DxC)\r\n MÀU SẮC	Hồng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 0, '2025-03-18 08:49:57', 1),
(145, 3, 'Chậu gốm họa tiết giọt nước 20x18cm GOSU040', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-van-giot-nuoc-768x768.jpg', '\r\nCHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	Giọt nước\r\nKÍCH THƯỚC	\r\n20x18cm (DxC) \r\n MÀU SẮC	Trắng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 0, '2025-03-18 08:49:57', 1),
(146, 3, 'Chậu gốm men nhám vân giả đá 20x24cm GOSU030', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-men-nham-gia-da-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-men-nham-gia-da-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-men', 'CHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	Giả đá\r\nKÍCH THƯỚC	\r\n26×20 / 18×16 / 12x10cm (DxC) \r\n MÀU SẮC	Trắng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 0, '2025-03-18 08:51:34', 1),
(147, 3, 'Chậu gốm sứ để bàn mặt người 15x15cm GOSU027\r\n', 90000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-mat-nguoi-18x16-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-mat-nguoi-18x16-4-125x125.jpg\r\n', '\r\nCHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	Mặt người\r\nKÍCH THƯỚC	\r\n15×15 cm (DxC) \r\n MÀU SẮC	Trắng / Xanh dương\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 0, '2025-03-18 08:51:34', 1),
(148, 3, 'Chậu gốm sứ trụ tròn nhỏ in hình cute 10x11cm GOSU025', 50000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-ly-nho-in-hinh-cute-1-768x768.jpg', 'CHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	Hình cute\r\nKÍCH THƯỚC	\r\n10×11 cm (DxC) \r\n MÀU SẮC	Trắng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 0, '2025-03-18 08:53:28', 1),
(149, 2, 'Cây Trầu Bà Đế Vương Xanh Thủy Sinh ‘Imperial Green’ PHIG003\r\n', 185000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-trau-ba-de-vuong-xanh-thuy-tinh-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-trau-ba-de-vuong-xanh-thuy-tinh-2-125x125.jpg', 'Trầu Bà Đế Vương Xanh (Philodendron Imperial Green) là một giống cây rất ưu chuộng để trồng với ý nghĩa phong thủy mà nó mang lại. Nên đặt cây tại các vị trí như trong phòng khách, phòng làm việc, văn phòng hoặc sảnh ra vào cơ quan.\r\n\r\nTÊN KHOA HỌC	Philodendron Imperial Green\r\nTÊN GỌI KHÁC	Trầu bà đế vương xanh\r\nKÍCH THƯỚC CÂY	Chiều cao 15 – 25 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Thay nước 1 – 2 lần/tháng', 100, 0, '2025-03-18 08:53:58', 1),
(150, 1, 'Cây lan ý thủy sinh để bàn chậu nhựa PEAC003', 185000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-lan-y-thuy-sinh-3-768x768.jpg', 'Cây lan ý thuộc giống cây rất dễ sống, thường được trồng để trang trí trong nhà cần ít ánh sáng, thanh lọc không khí. Nó cũng loại bỏ nhiều chất độc từ không khí trong nhà bao gồm cả formaldehyde và amoniac. Ngoài ra Cây Lan Ý mang ý nghĩa đem lại may mắn, thành công và thịnh vượng, hợp với người mệnh Kim và Thủy\r\n\r\nTÊN KHOA HỌC	Spathiphyllum wallisii\r\nTÊN GỌI KHÁC	Cây Lan Ý\r\nKÍCH THƯỚC CÂY	Chiều cao 40 – 50 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Thay nước định kỳ 1 – 2 tháng/lần', 100, 0, '2025-03-18 08:53:58', 1),
(151, 2, 'Chậu hoa cúc mâm xôi trang trí xọt nhựa HCMX002', 300000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/cuc-mam-xoi-chau-nhua-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/cuc-mam-xoi-chau-nhua-2-125x125.jpg', 'Cúc mâm xôi là một trong các loài hoa không thể thiếu vào dịp Tết cổ truyền. Chậu cúc mâm xôi có hình dáng tỏa ra theo dạng hình cầu, mang ý nghĩa vẹn tròn, cho một năm mới xuôn sẻ. Với màu vàng được xem là màu của sung túc, đầm ấm và nhiều tài lộc hơn. Do đó, người ta thường tặng cả cặp làm quà tặng cho ông bà, cha mẹ hoặc quý đối tác. \r\n\r\nTÊN KHOA HỌC	Chrysanthemum morifolium\r\nTÊN THÔNG THƯỜNG	Hoa cúc mâm xôi\r\nQUY CÁCH SẢN PHẨM	• Đường kính tán: 40cm (DxC)\r\n• Chiều cao tổng: 40 – 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 0, '2025-03-18 08:55:53', 1),
(152, 1, 'Cây Trầu Bà Chân Vịt chậu sứ trắng có vân Philodendron Xanadu CTBCV002', 750000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/chanvitmowgarden-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/chanvitmowgarden2-125x125.jpg', 'Khi nói đến Trầu Bà Chân Vịt thì có thể nhiều người sẽ cảm thấy lạ lẫm kèm theo đó là tò mò không biết hình dạng của loài cây đó ra sao. Đó là một loài cây có đặc tính sinh trưởng mạnh mẽ, thường được mọi người dùng để tô điểm cho không gian sinh sống, trang trí nội thất.\r\n\r\nMột điều khá đặc biệt nữa là Trầu Bà Chân Vịt sở hữu mùi hương khá dễ chịu đối với nhiều người, hương thơm thoang thoảng của nó giúp ta giảm stress, trở nên yêu đời hơn sau biết bao bộn bề cuộc sống.\r\n\r\nTÊN GỌI KHÁC	Cây Trầu Bà Chân Vịt \r\nTÊN TIẾNG ANH	Philodendron Xanadu\r\nKÍCH THƯỚC CÂY	Cao 50 cm\r\nĐỘ KHÓ	Vừa phải\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần\r\nĐỘ pH CỦA ĐẤT	Tính axit\r\nLỌC KHÔNG KHÍ	Có khả năng hấp thu chất độc hại', 100, 0, '2025-03-18 08:55:53', 1),
(153, 1, 'Chậu cây nội thất mix hạnh phúc, vạn lộc, trúc Nhật, tróc bạc NTMX018', 1250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/12/cay-canh-noi-that-mix-cac-loai-cay-768x768.jpg', 'Chậu cây nội thất được mix các loại cây dễ chăm sóc, thích nghi tốt với điều kiện thiếu sáng trong nhà. Sản phẩm được mix các loại cây Hạnh Phúc, Vạn lộc, Trúc Nhật, Tróc bạc thích hợp thể đặt tại phòng khách, lối hành lang, văn phòng làm việc, sảnh nhà hàng, khách sạn hoặc làm quà tặng.\r\n\r\nCHẤT LIỆU CHẬU	Xi măng nhẹ\r\nMÀU SẮC	Màu trắng\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 32×52 cm (DxC)\r\n• Chiều cao tổng: 110 – 120 cm\r\nTÊN CÂY MIX	Cây hạnh phúc / vạn lộc / trúc Nhật / tróc bạc\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Ít nắng\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:58:02', 1),
(154, 1, 'Cây kim ngân 3 thân để bàn chậu đỏ phát tài LONI018', 280000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/12/cay-kim-ngan-de-ban-768x768.jpg', 'Cây Kim Ngân là loại cây cảnh trong nhà được trồng phổ biến trên khắp thế giới, nó có sức ảnh hưởng tới mức mà hầu như ai cũng tin rằng khi trồng có thể mang lại nhiều may mắn trong cuộc sống, công việc hoặc làm ăn.\r\n\r\nTÊN KHOA HỌC	Pachira aquatica\r\nTÊN GỌI KHÁC	Cây kim ngân\r\nQUY CÁCH SẢN PHẨM	Chiều cao 20 – 25 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới ít nước 2 lần/tuần', 100, 0, '2025-03-18 08:58:02', 1),
(155, 1, 'Chậu cây nội thất mix hạnh phúc, vạn lộc, ngọc ngân, thường xuân NTMX016', 1250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/12/cay-noi-that-mix-chau-da-mai-son-768x768.jpg\r\n', 'Chậu cây nội thất được mix các loại cây dễ chăm sóc, thích nghi tốt với điều kiện thiếu sáng trong nhà. Sản phẩm được mix các loại cây Hạnh Phúc, Vạn lộc, Ngọc ngân, Thường Xuân thích hợp thể đặt tại phòng khách, lối hành lang, văn phòng làm việc, sảnh nhà hàng, khách sạn hoặc làm quà tặng.\r\n\r\nCHẤT LIỆU CHẬU	Xi măng nhẹ\r\nMÀU SẮC	Màu trắng / Xanh dương / Vàng 24k\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 32×52 cm (DxC)\r\n• Chiều cao tổng: 100 – 110 cm\r\nTÊN CÂY MIX	Cây hạnh phúc / vạn lộc / ngọc ngân / thường xuân\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Ít nắng\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:59:36', 1),
(156, 1, 'Cây cọ lá xẻ mini để bàn chậu đất nung LIVI004', 85000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/12/cay-co-nhat-nho-de-ban-768x768.jpg', 'Cây cọ nhật là loại cây trong nhà có kiểu lá xòe rộng như những cánh quạt, giúp trang trí không gian thêm xanh mát. Nó còn là loại cây phong thủy tượng trưng cho sự giàu sang và tiền tài nên rất đáng trồng trên bàn làm việc.\r\n\r\nTÊN KHOA HỌC	Livistona chinensis\r\nTÊN THÔNG THƯỜNG	Cọ lá xẻ\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 14x14cm (DxC)\r\n• Chiều cao chậu + cây: 25cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 08:59:36', 1),
(157, 1, 'Cây trầu bà Nam Mỹ Monstera chậu ươm MONS002', 450000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/12/cay-trau-ba-la-xe-monstera.jpg', 'Cây trầu bà Nam Mỹ được xem là một loài cây kiểng lá “quốc dân”, được ưu chuộng khắp nơi trên thế giới. Nhờ sở hữu một bộ lá ấn tượng, trang nhã và sang trong mà chúng luôn trở thành tâm điểm điểm của những hình ảnh đại diện cho các nhãn hàng, thương hiệu cho tới cá nhân trên các trang mạng xã hội.\r\n\r\nTÊN KHOA HỌC	Monstera Borsiagana\r\nTÊN GỌI KHÁC	Trầu bà Nam Mỹ\r\nQUY CÁCH SẢN PHẨM	• Kích thước lá: 15 – 30cm\r\n• Chiều cao: 50 – 60cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Tránh ánh nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:00:49', 1),
(158, 1, 'Cây hạnh phúc để bàn một thân chậu sứ RADE018', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/cay-hanh-phuc-de-ban-chau-su.jpg', 'Cây hạnh phúc là dòng cây cảnh đẹp, sức sống khỏe mạnh, dễ chăm sóc. Trên cây có những tán lá xanh tươi, mượt mà thể hiện cho sự hi vọng và niềm tin mạnh mẽ. Với ý nghĩa mang lại may mắn và hạnh phúc nên cây thường được chọn để làm cây trưng trong nhà hoặc làm quà tặng.\r\n\r\nTÊN KHOA HỌC	Radermachera Sinica\r\nTÊN THÔNG THƯỜNG	Cây hạnh phúc\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 12x12cm (DxC)\r\n• Chiều cao tổng: 30 – 35 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:00:49', 1),
(159, 1, 'Cây trầu bà thanh xuân vàng chậu đất nung PWAF004', 380000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-dat-nung-van-gia-da-4-1-768x768.jpg', 'Trầu bà thanh xuân vàng là loại cây có màu sắc gây ấn tượng, bởi chúng hoàn toàn được “phủ” bởi màu vàng rực rỡ. Nếu như bạn đang muốn mang thêm sắc màu vào không gian sống thì hãy cân nhắc tới loại cây này. Hơn nữa, đây cũng là loại cây cực kì dễ chăm sóc, chịu hạn tốt.\r\n\r\nTÊN KHOA HỌC	Philodendron Warscewiczii Aurea Flavum\r\nTÊN THÔNG THƯỜNG	Cây trầu bà thanh xuân vàng\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 20×20 cm (DxC)\r\n• Chiều cao tổng: 40 – 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:01:49', 1),
(160, 1, 'Cây cầu nguyện Maranta leuconeura chậu đất nung MARA301', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/cay-cau-nguyen-chau-dat-nung-1a-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/cay-cau-nguyen-chau-dat-nung-3-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-cau-nguy', 'Maranta leuconeura là một loại cây nội thất rất được ưu thích tại các nước Châu Âu. Loài cây này sở hữu bộ lá sặc sỡ tựa như một chiếc đuôi công, những đường gân lá khỏe khoắn gây ấn tượng mạnh, cùng tông màu đẹp như một bức tranh nghệ thuật.\r\n\r\nTÊN KHOA HỌC	Maranta leuconeura\r\nTÊN THÔNG THƯỜNG	Cây cầu nguyên\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 20×18 cm (DxC)\r\n• Chiều cao: 10cm\r\n• Đường kính tán: 25cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Râm mát\r\nNHU CẦU NƯỚC	Tưới nước 4 – 5 lần/tuần', 100, 0, '2025-03-18 09:01:49', 1),
(161, 1, 'Cây ngũ gia bì bonsai để bàn SCHE016', 680000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/ngu-gia-bi-bon-sai-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/ngu-gia-bi-bon-sai-2a-125x125.jpg', 'Ngũ gia bì là loại cây mang lại tài vận, thịnh vượng và may mắn, trồng trong nhà sẽ mang đến một không gian thư thái, trong lành cho gia đình.\r\n\r\nTÊN KHOA HỌC	Scheffera Octophylla\r\nTÊN THÔNG THƯỜNG	Ngũ gia bì\r\nQUY CÁCH SẢN PHẨM	Chiều cao 30 ~ 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:03:31', 1),
(162, 1, 'Cây dưa hấu ‘Watermelon’ để bàn chậu cú mèo PEWA003', 180000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-dua-hau-chau-dat-nung-hinh-cu-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-dua-hau-chau-dat-nung-hinh-cu-2-125x125.jpg', 'Cây dưa hấu có kích thước nhỏ gọn, là hình bầu dục, tán lá sọc xanh sẫm và thân màu đỏ. Chính là kiểu lá sọc xanh tựa như cây dưa hấu nên chúng được đặt tên là cây dưa hấu ‘ Watermelon’. Tuy những chiếc lá khá mỏng manh, nhưng nó lại có sức sống rất khỏe, dễ chăm sóc.\r\n\r\nTÊN KHOA HỌC	Peperomia ‘Watermelon’\r\nTÊN GỌI KHÁC	Cây dưa hấu\r\nKÍCH THƯỚC CÂY	Chiều cao 20 – 30 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Chịu râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tháng', 100, 0, '2025-03-18 09:03:31', 1),
(165, 1, 'Cây hồng phát lộc ‘Pink Lady’ chậu sứ trắng AGPL002\r\n', 240000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/cay-hong-phat-loc-de-ban-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-hong-phat-loc-de-ban-2-125x125.jpg', 'Cây hồng phát lộc là loại cây nhỏ để bàn, có màu hồng phớt tươi mới và bắt mắt, giúp tạo điểm nhấn cho góc làm việc thêm sinh động. Chúng còn là dòng cây phong thủy, được cho rằng giúp mang lại những điều may mắn và thịnh vượng tới cho gia chủ. Hồng phát lộc cũng là một món quà rất ý nghĩa vào những dịp khai trương, sinh nhật hoặc dịp lễ.\r\n\r\nTÊN KHOA HỌC	Aglaonema ‘Pink Lady’\r\nTÊN GỌI KHÁC	Cây hồng phát lộc\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 15×14 cm (DxC)\r\n• Chiều cao tổng: 35 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Nơi râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:05:01', 1),
(166, 1, 'Cây sen đá mix chậu lu bể đất nung SCMI002', 280000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/sen-da-mix-chau-lu-dat-nung-nho-1.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/sen-da-mix-chau-lu-dat-nung-nho-2-125x125.jpg', 'Cô tòng đuôi lươn sở hữu bộ lá nhiều màu sắc rực rỡ, cùng những đường viền hoa văn độc đáo, chúngthường được trồng trang trí cho bồn hoa, ban công hoặc trước hiên nhà. Loại cây này đôi lúc được trồng trong nhà, nhưng đòi hỏi phải trồng nơi có nhiều ánh sáng, gần cửa sổ.\r\n\r\nTÊN KHOA HỌC	Aglaonema ‘Pink Lady’\r\nTÊN GỌI KHÁC	Cây hồng phát lộc\r\nQUY CÁCH SẢN PHẨM	• Kích thước tán: 35 – 40cm\r\n• Chiều cao: 35 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Nơi râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:05:01', 1),
(167, 1, 'Cây ngọc bích ‘Super White’ chậu ươm AGSW001', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-ngoc-bich-nho-super-white-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-ngoc-bich-nho-super-white-1-125x125.jpg', 'Cây ngọc bích là là cây trong nhà được đánh giá cao về phong thuỷ, người ta quan niệm rằng cây Ngọc ngân mang đến tài lộc, may mắn khi đặt trên bàn làm việc hay trang trí trong văn phòng. Về mặt tinh thần cây Ngọc ngân rất thích hợp làm quà tặng tình yêu.\r\n\r\nTÊN KHOA HỌC	Aglaonema Super White\r\nTÊN GỌI KHÁC	Cây ngọc bích\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 20 – 30cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Tránh ánh nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:06:56', 1),
(168, 1, 'Cây trầu bà cẩm thạch chậu ươm Njoy Pothos POTH250', 80000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-trau-ba-cam-thach-Epipremnum-Njoy-768x768.jpg', 'Cây trầu bà cẩm thạch hay trầu bà sữa có những chiếc lá  hòa quyện giữa màu xanh ngát của cây và màu trắng sữa, tạo nên một sự độc đáo riêng biệt. Loại cây này rất dễ sống, chịu bóng râm, phát triển nhanh tại nơi có khí hậu mát mẻ, nhiều ẩm. \r\n\r\nTÊN KHOA HỌC	Epipremnum Aureum ‘Njoy Pothos’\r\nTÊN GỌI KHÁC	Cây trầu bà cẩm thạch / Trầu bà sữa\r\nQUY CÁCH SẢN PHẨM	Chiều dài 40 – 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Chịu được khuất sáng\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3  lần/tuần', 100, 0, '2025-03-18 09:06:56', 1),
(169, 1, 'Cây dương xỉ lá me nhỏ chậu ươm ASPL001\r\n', 50000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-duong-xi-la-me-Nephrolepis-cordifolia-.jpg', 'Dương xỉ lá me sở hữu nét độc đáo và tự nhiên của họ dương xỉ vẫn luôn là lựa chọn rất tuyệt vời để decor sân vườn, ban công hoặc trồng trang tí trong nhà. Bên cạnh đó loài này không cần nhiều ánh sáng, rất dễ sống và không cần phải chăm sóc nhiều.\r\n\r\nTÊN KHOA HỌC	Nephrolepis cordifolia\r\nTÊN THÔNG THƯỜNG	Dương xỉ lá me / Ráng cốt cắt\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 30~40 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:08:06', 1),
(170, 1, 'Cây tùng bách tán tiểu cảnh để bàn chậu sứ CTBT001\r\n', 420000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-tung-bach-tan-de-ban-768x768.jpg.\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-tung-xuong-ca-tieu-canh-de-ban-1-125x125.jpg.\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-tung-xuon', 'Cây tùng bách tán sở hữu kiểu dáng vô cùng độc đáo với những chiếc lá thuôn nhọn, bóng mượt và có màu xanh đậm, chúng mọc dọc theo cành đều đặn đúng theo hình xương cá.\r\n\r\nTÊN KHOA HỌC	Araucaria angustifolia\r\nTÊN THÔNG THƯỜNG	Cây tùng bách tán\r\nQUY CÁCH SẢN PHẨM	Chiều cao 30 ~ 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:08:06', 1),
(171, 1, 'Cây Hoa Sen – Cao 37cm', 140000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/sen_2_1024x1024.jpg', '', 100, 0, '2025-03-18 09:09:22', 1),
(172, 1, 'Cây Lẻ Bạn – Cao 19cm', 30000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-le-ban-mowgarden-01-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-le-ban-mowgarden-02-125x125.jpg', '', 100, 0, '2025-03-18 09:09:22', 1),
(175, 1, 'Cây cầu nguyện Maranta leuconeura ‘massangeana’ MARA100', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-cau-nguyen-Maranta-leuconeura-massangeana-768x768.jpg', 'Maranta leuconeura ‘massangeana’ là một loại cây nội thất có tác dụng trang trí tuyệt vời cho không gian nội thất. Loại này khá dễ chăm sóc, có thể sống tại nơi ánh sáng yếu, ưu khí hậu mát mẻ, và chịu được hạn.\r\n\r\nTÊN KHOA HỌC	Maranta leuconeura ‘massangeana’\r\nTÊN THÔNG THƯỜNG	Cây cầu nguyên\r\nQUY CÁCH SẢN PHẨM	Đường kính tán: 25cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Chịu được râm mát\r\nNHU CẦU NƯỚC	Tưới nước 4 – 5 lần/tuần', 100, 0, '2025-03-18 09:10:30', 1),
(176, 1, 'Cây đuôi công đốm xanh Maranta Leuconeura‬ MARA001', 120000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-duoi-cong-Maranta-Varieties-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-duoi-cong-Maranta-Varieties-2-125x125.jpg', 'Cây đuôi công có tên khoa học là Maranta leuconeura kerchoveana là một loại cây nội thất có tác dụng trang trí tuyệt vời cho không gian nội thất. Không giống như mọi loại đuôi công, giống đuôi công này “dễ chịu” hơn nhiều, có thể sống tại nơi ánh sáng yếu, ưu khí hậu mát mẻ, và chịu được hạn.\r\n\r\nTÊN KHOA HỌC	Maranta leuconeura kerchoveana\r\nTÊN THÔNG THƯỜNG	Đuôi công đốm xanh\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 20cm – Tán: 25cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Chịu được râm mát\r\nNHU CẦU NƯỚC	Tưới nước 4 – 5 lần/tuần', 0, 0, '2025-03-18 09:10:30', 1),
(177, 1, 'Cây bàng Singapore lớn 2 thân chậu xi măng LYRA025', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/11/cay-bang-singapore-lon-chau-xi-mang-da-mai-768x768.jpg', 'Cây Bàng Singapore Lớn có thể dễ dàng nhận ra ở những góc quán cafe, bàn làm việc công. Với những chiếc lá căng bóng hình đàn vĩ cầm rất lớn, nhiều gân là hình chân chim nổi bật và sức sống rất mạnh mẽ và chắc chắn sẽ là một sự bổ sung tuyệt đẹp cho những góc trang trí cho góc làm việc, căn phòng, ngôi nhà của bạn.\r\n\r\nTÊN KHOA HỌC	Ficus lyrata\r\nTÊN GỌI KHÁC	Bàng Singapore / Sung tỳ bà\r\nKÍCH THƯỚC CÂY	Kích thước chậu: 35×28 cm (DxC)\r\nChiều cao 140 – 150 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp / Ánh sáng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:12:08', 1),
(178, 1, 'Cây Môn Rồng Bạc Alocasia Baginda Silver Dragon chậu sứ trắng ALOCA001', 650000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-rong-bac-chau-su-trang-mowgarden-768x768.jpg', 'Một viên ngọc đến từ họ nhà Alocasia, kích thích mọi ánh nhìn, Alocasia Baginda Silver Dragon nổi tiếng và đầy mê hoặc. Nó có thể tồn tại khá tốt trong nhà lẫn ngoài trời.\r\n\r\nTÊN KHOA HỌC	Alocasia Baginda Silver Dragon\r\nTÊN GỌI KHÁC	• Môn Rồng Bạc\r\n• Alocasia Baginda\r\n• Silver Dragon\r\nĐỘ KHÓ	Trung Bình\r\nYÊU CẦU ÁNH SÁNG	• Ánh sáng tán xạ\r\n• Tránh ánh nắng trực tiếp\r\nNHU CẦU NƯỚC	• Vừa phải, 2 – 3 lần/tuần\r\n• Đất trồng thông thoáng', 100, 0, '2025-03-18 09:12:08', 1),
(179, 1, 'Cây Đại lộc chậu xi măng đá mài đen DRAC001', 5500000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/dailoc-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/08/cay-dai-loc-chau-den-mowgarden-125x125.jpg', 'Góp phần thư giản, giảm căng thẳng, mệt mỏi. thanh lọc bầu không khí xung quanh hiệu quả, mang đến không gian trong lành hơn, và giúp chủ nhân của nó hứng lộc.\r\n\r\nTÊN KHOA HỌC	Dracaena Draco L\r\nTÊN THÔNG THƯỜNG	Đại lộc\r\nQUY CÁCH SẢN PHẨM	Cao 150 – 170 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:14:03', 1),
(180, 1, 'Cây Bàng Nhật cẩm thạch dáng tree chậu xi măng họa tiết CBCT003', 950000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/bangcamthachnhat-768x768.jpg', 'Là dòng cây bóng mát có tán lá xếp tầng mang vẻ đẹp hiện đại, có tốc độ phát triển nhanh.\r\n\r\nTÊN KHOA HỌC	Bucida sp.variegata\r\nTÊN THÔNG THƯỜNG	Bàng cẩm thạch\r\nQUY CÁCH SẢN PHẨM	Cao 70 – 80 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:14:03', 1),
(183, 1, 'Cây ráng tổ yến chậu gốm có họa tiết màu đen ASPL002', 490000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/toyen.jpg', 'Tổ yến góp phần lọc không khí, tạo mảng xanh trong ngôi nhà, khu vườn của bạn.\r\n\r\nTÊN KHOA HỌC	Asplenium antiquum\r\nTÊN THÔNG THƯỜNG	Tổ yến\r\nQUY CÁCH SẢN PHẨM	Cao 30 – 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:17:28', 1),
(184, 1, 'Cây Trầu bà đế vương đỏ chậu xi măng màu đồng CDVD001', 700000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/devuongdo1.jpg', 'Thân dạng thảo lớn, trong tự nhiên cây có thể leo được, nhưng đa số khi trồng chậu thì thân vươn thẳng chắc chắn, cao khoảng dưới 1m5.\r\n\r\nTÊN KHOA HỌC	Philodendron Imperial Red\r\nTÊN THÔNG THƯỜNG	Đế vương đỏ\r\nQUY CÁCH SẢN PHẨM	Cao 80 – 120 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:17:28', 1),
(185, 1, 'Cây đa búp đỏ một thân chậu xi măng CDBD003', 350000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/63-cay-da-bup-de-chau-xi-mang-768x768.jpg', 'Từ lâu cây Đa luôn là biểu tượng của sự trường tồn, sức sống dẻo dai, nơi chứa đựng thần quyền và tâm linh của con người. Chính lẽ đó mà trong phong thủy, Đa Búp Đỏ cũng mang ý nghĩa của sự may mắn, an lành.\r\n\r\nTÊN KHOA HỌC	Ficus elastica\r\nTÊN GỌI KHÁC	Đa búp đỏ\r\nQUY CÁCH SẢN PHẨM	Chiều cao 60 – 80cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ; Bóng râm\r\nNHU CẦU NƯỚC	Vừa phải, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:18:31', 1),
(186, 1, 'Cây Trầu bà Nam Mỹ – Monstera Borsigiana – MONS010', 7500000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/43-cay-monstera-borsi-leo-cot-768x768.jpg', 'Là loài cây sở hữu cho mình những chiếc lá được tạo nét như trái tim, càng lớn lá bắt đầu xuất hiện các đường xẻ một cách ngẫu nhiên.\r\n\r\nTÊN KHOA HỌC	Monstera Borsigiana\r\nTÊN THÔNG THƯỜNG	Trầu bà lá xẻ\r\nQUY CÁCH SẢN PHẨM	Cao 80 – 100 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ.\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:18:31', 1),
(187, 1, 'Cây bàng Singapore cao 2m dáng tree chậu sứ LYRA023\r\n', 2200000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-bang-singapore-co-lon-dang-tree-chau-su-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/08/cay-bang-singapore-co-lon-dang-tree-chau-su-2-125x125.jpg', 'Bàng Singapore là loại cây nội thất đang được ưa chuộng nhất hiện nay bởi cây có khả năng cải thiện chất lượng không khí mang lại sự xanh mát và sang trọng cho không gian.\r\n\r\nTÊN KHOA HỌC	Ficus lyrata\r\nTÊN THÔNG THƯỜNG	Cây bàng Singapore\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 42×60 cm (DxC)\r\n• Chiều cao cây + chậu: 190 – 200cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:20:14', 1),
(188, 1, 'Cây đuôi công táo xanh để bàn chậu sứ CALA009', 320000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-duoi-cong-tao-mowgarden.jpg', 'Với tán lá tròn trịa xoè rộng phủ xanh cả khu vườn nhỏ, bạn chỉ cần trồng vài cây Orbifolia là không khí tropical mát mẻ đã về với không gian nhà rồi đó.\r\n\r\nTÊN KHOA HỌC	Calathea Orbifolia\r\nTÊN THÔNG THƯỜNG	Đuôi công táo xanh\r\nQUY CÁCH SẢN PHẨM	Cao 35 – 45 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:20:14', 1),
(189, 1, 'Cây phát lộc chậu sứ để bàn DRAC001', 135000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-phat-loc-de-ban-1-768x768.jpg', 'Cây phát lộc là loại cây phong thủy để bàn có khả năng đem lại vận khí tốt cho sức khỏe, tình yêu và sự thịnh vượng. Loại cây này rất thích hợp dùng để làm quà tặng, bởi nó mang ý nghĩa như lời chúc phát triển sự nghiệp dành cho người được tặng.\r\n\r\nTÊN KHOA HỌC	Dracaena sanderiana\r\nTÊN THÔNG THƯỜNG	Cây phát lộc\r\nQUY CÁCH SẢN PHẨM	Cao 20 – 30 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được thiếu nắng\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:21:31', 1),
(190, 1, 'Cây môn lính để bàn chậu sứ mini Caladium Hilo Beauty CALA013\r\n', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/104-cay-mon-la-quan-doi.jpg', 'Loài cây đuôi công này được trồng rất phổ biến trong nội thất với mục đích trang trí, họa tiết lá rất sang trọng.\r\n\r\nTÊN KHOA HỌC	Caladium Hilo Beauty\r\nTÊN THÔNG THƯỜNG	Môn lính\r\nQUY CÁCH SẢN PHẨM	Cao 20 – 30 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:22:09', 1);
INSERT INTO `product` (`id`, `cate_id`, `name`, `price`, `sale`, `price_sale`, `images`, `discription`, `inventory_quantity`, `view`, `create_date`, `status`) VALUES
(191, 1, 'Cây đuôi phụng lớn chậu men sứ trắng CATH104', 350000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/duoi-phung-de-ban-mowgarden-768x768.jpg', 'Vẻ đẹp độc đáo của loài cây này khiến cho người ta phải gọi nó bằng cái tên là cây đuôi phụng, và theo “mặc định” thì nó luôn là một sự lựa chọn tuyệt hảo được dùng để trang trí cho không gian nội thất thêm phần sinh động. \r\n\r\nTÊN KHOA HỌC	Calathea Lancifolia\r\nTÊN GỌI KHÁC	Cây đuôi phụng\r\nQUY CÁCH SẢN PHẨM	• Kích thước lá: 10 – 20cm\r\n• Chiều cao: 25 – 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Chịu được râm mát\r\nNHU CẦU NƯỚC	Ít nước 2 3 lần/tuần', 100, 0, '2025-03-18 09:22:09', 1),
(194, 1, 'Cây phát tài núi nhiều nhánh chậu sứ họa tiết CPTN007', 3200000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/phat-tai-nui-mowgarden-768x768.jpg', 'Cây phát tài núi rất thường được lựa chọn để làm quà tặng vào những dịp khai trương, lên nhà mới, văn phòng mới… với mong muốn đem lại nhiều tài lộc và may mắn cho người được tặng.\r\n\r\nTÊN KHOA HỌC	Dracaena draco L\r\nTÊN THÔNG THƯỜNG	Phát tài núi\r\nQUY CÁCH SẢN PHẨM	Cao 150 – 160 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:23:34', 1),
(195, 1, 'Cây phát tài núi 2 tầng chậu sứ CPTN008', 1500000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-phat-tai-nui-mowgarden.jpg', 'Cây phát tài núi rất thường được lựa chọn để làm quà tặng vào những dịp khai trương, lên nhà mới, văn phòng mới… với mong muốn đem lại nhiều tài lộc và may mắn cho người được tặng.\r\n\r\nTÊN KHOA HỌC	Dracaena draco L\r\nTÊN THÔNG THƯỜNG	Phát tài núi\r\nQUY CÁCH SẢN PHẨM	Cao 150 – 160 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 0, '2025-03-18 09:23:34', 1),
(196, 3, 'Chậu đất nung trơn bầu lớn DANU013', 155000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/chau-dat-nung-tron-bau-lon-768x768.jpg', '\r\nCHẤT LIỆU	Đất nung\r\nHỌA TIẾT	Trơn\r\nKÍCH THƯỚC	\r\n28x28cm\r\nMÀU SẮC	Nâu đất\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 96, 0, '2025-03-20 15:08:37', 1),
(197, 3, 'Chậu đất nung trụ trơn không họa tiết DANU005', 110000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/chau-dat-nung-khong-hoa-tiet-1-768x768.jpg', '\r\nCHẤT LIỆU	Đất nung\r\nHỌA TIẾT	Tường gạch\r\nKÍCH THƯỚC	 25cm (ngang) – 25cm (cao)\r\nMÀU SẮC	Nâu đất\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 0, '2025-03-20 15:08:37', 1),
(198, 1, 'Cây ngũ gia bì cẩm thạch nhỏ chậu ươm SCHE020', 100000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/04/cay-ngu-gia-bi-cam-thach-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/04/cay-ngu-gia-bi-cam-thach-2-125x125.jpg', 'Ngũ gia bì là loại cây mang lại tài vận, thịnh vượng và may mắn, trồng trong nhà sẽ mang đến một không gian thư thái, trong lành cho gia đình.\r\n\r\nTÊN KHOA HỌC	Scheffera Octophylla\r\nTÊN THÔNG THƯỜNG	Ngũ gia bì cẩm thạch\r\nQUY CÁCH SẢN PHẨM	Chiều cao tổng: 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 0, 0, '0000-00-00 00:00:00', 1),
(200, 1, 'Cây bàng Singapore mini để bàn chậu sứ LYRA048', 180000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/7-cay-bang-singapore-nho-de-ban-chau-su-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/7-cay-bang-singapore-nho-de-ban-chau-su-2-125x125.jpg', 'Cây Bàng Singapore Lớn có thể dễ dàng nhận ra ở những góc quán cafe, bàn làm việc công. Với những chiếc lá căng bóng hình đàn vĩ cầm rất lớn, nhiều gân là hình chân chim nổi bật.\r\n\r\nTÊN KHOA HỌC	Ficus lyrata\r\nTÊN GỌI KHÁC	Bàng Singapore / Sung tỳ bà\r\nKÍCH THƯỚC CÂY	• Kích thước chậu: 12×12 cm (DxC)\r\n• Chiều cao tổng: 25 – 30 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp / Ánh sáng tán xạ\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 94, 326, '2025-03-24 03:20:00', 1),
(201, 1, 'Cây ngũ gia bì để bàn chậu sứ thổ cẩm SCHE019', 220000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-ngu-gia-bi-chau-su-hoa-tiet-trang-tri.jpg', 'Ngũ gia bì là loại cây mang lại tài vận, thịnh vượng và may mắn, trồng trong nhà sẽ mang đến một không gian thư thái, trong lành cho gia đình.\r\n\r\nTÊN KHOA HỌC	Scheffera Octophylla\r\nTÊN THÔNG THƯỜNG	Ngũ gia bì\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 20×18 cm (DxC)\r\n• Chiều cao tổng: 40-50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 72, 637, '2025-03-24 03:24:31', 1),
(203, 1, 'Cây bàng Singapore 2 thân chậu đá mài LYRA047', 680000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-bang-singapore-chau-da-mai-tru-tron-1a-768x768.jpg', 'Cây Bàng Singapore Lớn có thể dễ dàng nhận ra ở những góc quán cafe, bàn làm việc công. Với những chiếc lá căng bóng hình đàn vĩ cầm rất lớn, nhiều gân là hình chân chim nổi bật.\r\n\r\nTÊN KHOA HỌC	Ficus lyrata\r\nTÊN GỌI KHÁC	Bàng Singapore / Sung tỳ bà\r\nKÍCH THƯỚC CÂY	• Kích thước chậu: 37×37 cm (DxC)\r\n• Chiều cao tổng: 100 – 120 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp / Ánh sáng tán xạ\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 69, 684, '2025-03-24 03:27:59', 1),
(204, 1, 'Cây thường xuân cẩm thạch chậu nhựa HEDE002', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-thuong-xuan-cam-thach-chau-uom-768x768.jpg', 'Thường xuân là loài cây dây leo, chúng có thể sống trong nhà rất tốt và sinh trưởng khỏe mạnh vào mùa mát mẻ. Những cành dài buông rủ của chúng là gợi ý tuyệt vời trên bục cửa sổ, trên kệ sách hoặc treo lên cao. Chúng có sức sống khá bền bỉ nên điều kiện chăm sóc cũng không quá phức tạp.\r\n\r\nTÊN TIẾNG ANH	English Ivy / Hedera Helix\r\nTÊN THÔNG THƯỜNG	Cây thường xuân cẩm thạch\r\nQUY CÁCH SẢN PHẨM	Chậu ươm 10×10\r\nĐỘ KHÓ	Trung bình\r\nYÊU CẦU ÁNH SÁNG	Ít nắng, trồng nơi râm mát\r\nNHU CẦU NƯỚC	Tưới nước 4 – 5 lần/tuần', 97, 12, '2025-03-24 03:44:29', 1),
(206, 1, 'Cây Ổ Rồng treo tường Staghorn Fern STAG002', 380000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/08/cay-o-rong-treo-tuong-768x768.jpg\r\n', 'Cây Ổ Rồng được dùng để làm đẹp khoảng không ở khu vườn. Loài cây không thể thiếu cho những ai muốn tạo nên một khu rừng nhiệt đới thực thụ.\r\n\r\nTÊN KHOA HỌC	Platycerium grande\r\nTÊN THÔNG THƯỜNG	Cây Ổ Rồng\r\nQUY CÁCH SẢN PHẨM	Lá dài 10 – 15cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, ánh nắng gián tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 32, '2025-03-24 03:48:38', 1),
(207, 1, 'Cây Lan Tim Nhí/ Cây Khúc Thủy – Cao 10cm', 105000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/lan_tim_3_1024x1024-692x800.jpg', '', 97, 123, '2025-03-24 03:51:03', 1),
(208, 1, 'Cây thường xuân xanh chậu treo HEDE001', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-thuong-xuan-xanh-treo-english-ivy-768x768.jpg', 'Cây thường xuân có bộ lá xanh tươi tốt, hình dáng ấn tượng giúp mang lại không gian xanh mát. Đây là dòng cây dễ chăm đang là “trend” được nhiều người lựa chọn trồng trang trí trong nhà rất đẹp.\r\n\r\nTÊN TIẾNG ANH	English Ivy\r\nTÊN THÔNG THƯỜNG	Cây thường xuân\r\nKÍCH THƯỚC CÂY	Dài 60cm\r\nĐỘ KHÓ	Trung bình\r\nYÊU CẦU ÁNH SÁNG	Ít nắng, trồng nơi râm mát\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 19, '2025-03-24 03:53:45', 1),
(209, 1, 'Cây Càng Cua Cẩm Thạch Peperomia scandens Variegata – Cao 16 Cm', 85000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-cang-cua-cam-thach-Peperomia-scandens-Variegata-1-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-cang-cua-cam-thach-Peperomia-scandens-Variegata-3-1-125x125.jpg,\r\nhttps://mowg', 'Cây Càng Cua Cẩm Thạch Peperomia scandens Variegata dây leo mỏng manh, có lá màu xanh nhạt, trắng sữa, hình trái tim và cuối cùng rụng xuống khi chúng trưởng thành. Một loại cây biểu trưng cho vui vẻ, nhẹ nhàng và tươi tốt chắc chắn sẽ mang lại nụ cười cho bạn.', 100, 25, '2025-03-24 03:56:37', 1),
(210, 1, 'Cây Ổ Rồng Staghorn Fern STAG001', 990000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/11/Platycerium-Kitshakood-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/11/cay-o-rong-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/11/o-rong-125x125.jpg', 'Cây Ổ Rồng được dùng để làm đẹp khoảng không ở khu vườn. Loài cây không thể thiếu cho những ai muốn tạo nên một khu rừng nhiệt đới thực thụ.\r\n\r\nTÊN KHOA HỌC	Staghorn Fern\r\nTÊN THÔNG THƯỜNG	 Cây Ổ Rồng\r\nQUY CÁCH SẢN PHẨM	Lá dài 20 – 30cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, ánh nắng gián tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 93, 65, '2025-03-24 03:59:58', 1),
(211, 1, 'Cây môn vảy rồng ‘Dragon Scale’ chậu sứ trắng ABDS004', 320000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-mon-vay-rong-chau-trung-vo-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-rong-xanh-125x125.jpg', 'Bạn không cần dành quá nhiều thời gian cho Rồng Bạc nhưng vẫn ngắm nhìn được vẻ đẹp của nó mỗi ngày.\r\n\r\nTÊN KHOA HỌC	Alocasia Dragon Scale\r\nTÊN THÔNG THƯỜNG	Môn vảy rồng\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 15x15cm (DxC)\r\n• Chiều cao tổng: 30 – 32 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Nơi râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 97, 65, '2025-03-24 04:03:28', 1),
(212, 1, 'Cây hồng hạc thân cam “Billietiae’ chậu banh PHBI005', 550000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-hong-hac-chan-cam-chau-trai-banh-1-768x768.jpg', 'Cây Hạc Cam đặc trưng bởi những chiếc lá thuôn dài, hình dây đeo có xẻ trái tim sâu, phần cuống cũng được tô điểm bởi màu da cam rất bắt mắt. Khi trưởng thành cây hạc Philodendron billietiae có kích thước rất khủng nên được nhiều người săn đón sưu tầm.\r\n\r\nTÊN KHOA HỌC	Philodendron billietiae\r\nTÊN THÔNG THƯỜNG	Cây hồng hạc chân cam\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 32×25 cm (DxC)\r\n• Kích thước lá: 35 ~ 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 98, 98, '2025-03-24 04:05:29', 1),
(215, 1, 'Cây trầu bà Nam Mỹ Monstera ‘Deliciosa’ chậu lớn MONS020', 1850000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/01/cay-trau-ba-nam-my-monstera-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/01/cay-trau-ba-nam-my-monstera-2-768x768.jpg', 'Monstera là dòng câycó sức sống mạnh mẽ, dễ chăm sóc, chỉ ánh sáng tán xạ vừa phải, thích với môi trường có ít ánh sáng. Cây trầu bà Nam Mỹ được xem là biểu tượng rất được ưu thích trong lĩnh vực thời trang, kiến trúc và nội thất. Nó thường được đặt cạnh các thương hiệu lớn như một cách để tạo thêm điểm nhấn và phong cách.\r\n\r\nTÊN KHOA HỌC	Monstera ‘Deliciosa’\r\nTÊN THÔNG THƯỜNG	Trầu bà Nam Mỹ\r\nQUY CÁCH SẢN PHẨM	• Chiều cao tổng chậu: 170cm\r\n• Kích thước lá: 65 – 70 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 96, 9, '2025-03-24 04:06:51', 1),
(216, 1, 'Cây cau nga mi cao 150-160cm chậu xi măng trắng PNIX010', 1850000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/cau-nga-mi-chau-da-mai-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/cay-cau-nga-mi-trang-tri-noi-that-125x125.jpg', 'Cau Nga Mi là một loại cây cảnh nội thất có kích thước tương đối lớn, nhưng không quá chiếm diện tích, mang một vẻ đẹp tự nhiên giúp tạo cảm giác thư thái và thoải mái. Với bộ lá xum xuê, xanh mát và dạng rũ giúp tạo cho không gian nội thất thêm phần sang trọng, duyên dáng và vô cùng ấn tượng.\r\n\r\nTÊN KHOA HỌC	Phoenix roebelenii\r\nTÊN THÔNG THƯỜNG	Cây cau nga mi / Chà là cảnh\r\nQUY CÁCH SẢN PHẨM	• Kích thước cây: 150 – 160 cm\r\n• Kích thước chậu: 40×40 cm (DxC)\r\n• Chiều cao tổng: 180 ~ 190 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 98, 2, '2025-03-24 04:11:05', 1),
(217, 1, 'Cây trầu bà thanh xuân vàng chậu đất nung PWAF004', 380000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-dat-nung-van-gia-da-4-1-768x768.jpg', 'Trầu bà thanh xuân vàng là loại cây có màu sắc gây ấn tượng, bởi chúng hoàn toàn được “phủ” bởi màu vàng rực rỡ. Nếu như bạn đang muốn mang thêm sắc màu vào không gian sống thì hãy cân nhắc tới loại cây này. Hơn nữa, đây cũng là loại cây cực kì dễ chăm sóc, chịu hạn tốt.\r\nTÊN KHOA HỌC	Philodendron Warscewiczii Aurea Flavum\r\nTÊN THÔNG THƯỜNG	Cây trầu bà thanh xuân vàng\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 20×20 cm (DxC)\r\n• Chiều cao tổng: 40 – 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ánh sáng tán xạ / Râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 9, '2025-03-24 04:13:14', 1),
(218, 1, 'Cây huyết dụ bảy sắc cầu vòng chậu đất nung CFWR002', 220000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/cay-phat-du-bay-sac-cau-vong-chau-dat-nung-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/cay-phat-du-bay-sac-cau-vong-2-125x125.jpg', 'Cây phất dụ ‘bảy sắc’ là loại cây có bộ lá sặc sỡ như ‘bảy sắc cầu vòng’, rất thích để trồng trang trí nội thất. Với sức sống cực kỳ mãnh liệt, loại cây sẽ là một sự lựa chọn tuyệt vời dành cho những “người lưới”. Vẻ đẹp độc đáo của cây phất dụ ‘bảy sắc’ chắc chắn sẽ rất hút mắt những vị khách tới thăm nhà bạn.\r\n\r\nTÊN KHOA HỌC	Cordyline fruticosa ‘Waihee Rainbow’\r\nTÊN THÔNG THƯỜNG	Huyết phất dụ 7 sắc\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 17×17  cm (DxC)\r\n• Chiều cao tổng: 50 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 99, 33, '2025-03-24 04:16:42', 1),
(219, 1, 'Cây trầu bà Brasil ‘Carnival’ leo cột chậu ươm PHBZ024', 330000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-trau-ba-leo-cot-philodendron-brazil-carnival-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-trau-ba-leo-cot-philodendron-brazil-carnival-2-125x125.jpg', 'Trầu bà tỷ phú là loại cây nội thất cao cấp với những chiếc lá to có hình trái tim, màu cẩm thạch sang trọng luôn được săn đón trong giới mê cây cảnh. Trầu bà tỷ phú còn được xem là loại cây phong thủy, mang ý nghĩa về sự thành đạt và trù phú.\r\n\r\nTÊN KHOA HỌC	Philodendron Brazil Carnival\r\nTÊN GỌI KHÁC	Trầu bà Brazil\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 60 – 70 cm\r\nKích thước tán: 50 – 60 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Bóng râm\r\nNHU CẦU NƯỚC	Tưới nước 3 – 4 lần/tuần', 99, 6, '2025-03-24 04:18:28', 1),
(220, 1, 'Cây trầu bà tỷ phú cẩm thạch ‘Burle Marx’ PHIL106', 650000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/cay-trau-ba-ty-phu-dot-bien-burble-max-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/cay-trau-ba-ty-phu-burble-marx-var-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/t', 'Trầu bà tỷ phú là loại cây nội thất cao cấp với những chiếc lá to có hình trái tim, màu cẩm thạch sang trọng luôn được săn đón trong giới mê cây cảnh. Trầu bà tỷ phú còn được xem là loại cây phong thủy, mang ý nghĩa về sự thành đạt và trù phú.\r\n\r\nTÊN KHOA HỌC	Philodendron burle marx var\r\nTÊN GỌI KHÁC	Trầu bà tỷ phú cẩm thạch\r\nQUY CÁCH SẢN PHẨM	Chiều cao: 60 – 70 cm\r\nKích thước tán: 50 – 60 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Bóng râm\r\nNHU CẦU NƯỚC	Tưới nước 3 – 4 lần/tuần', 100, 7, '2025-03-24 04:26:27', 1),
(222, 1, 'Cây Lan ý chậu cỡ lớn để bàn chậu sứ trắng PEAC005', 240000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-lan-y-de-ban-chau-su-mowgarden-01-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2023/03/cay-lan-y-de-ban-chau-su-mowgarden-02-125x125.jpg', 'Những bông hoa trắng tinh khiết vươn lên đầy kiêu hãnh,phần còn lại phải kể đến vẻ đẹp được tạo từ những chiếc lá xanh tươi, tràn đầy sức sống.\r\n\r\nTÊN KHOA HỌC	Spathiphyllum Wallisii\r\nTÊN THÔNG THƯỜNG	Lan ý\r\nQUY CÁCH SẢN PHẨM	Cao 30 – 40 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ, chịu được nắng trực tiếp\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 100, 4, '2025-03-24 04:37:28', 1),
(223, 1, 'Cây trúc mặt trời ‘Compacta’ chậu sứ họa tiết thổ DRCO004', 200000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2023/03/cay-phat-tai-bup-de-ban-chau-su-1-768x768.jpg', 'Cây phát tài Nhật tượng trưng cho sức sống bền bỉ, mạnh mẽ. Cây có thể thích nghi với mọi điều kiện thời tiết, tán lá vẫn xanh vẫn vươn thêm nhiều tầng mới. Vì thế mà cây mang lại nguồn sinh khí dồi dào, một tinh thần tích cực, cùng niềm vui và sự may mắn cho mọi người.\r\n\r\nTÊN KHOA HỌC	Dracaena fragrans ‘Compacta’\r\nTÊN THÔNG THƯỜNG	Trúc mặt trời / Phát tài Nhật\r\nQUY CÁCH SẢN PHẨM	• Kích thước chậu: 11x11cm (DxC)\r\n• Chiều cao tổng: 20 – 30 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ / Nơi râm mát\r\nNHU CẦU NƯỚC	Tưới nước 2 – 3 lần/tuần', 100, 55, '2025-03-24 04:40:37', 1),
(224, 2, 'Cây Bò Cạp Vàng', 4500000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-bo-cap-vang-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-bo-cap-vang-2-125x125.jpg', 'Tên thường gọi: Bò Cạp Vàng, Bò cạp nước, Muồng Hoàng yến, Lồng đèn, Hoàng hậu (hạ), Mai dây, Cây xuân muộn, Mai nở muộn\r\nTên khoa học: Cassia fistula L\r\nHọ thực vật: Caesalpinioideae (họ Vang) phân họ của họ Đậu (Fabaceae)\r\nChiều cao: 4 – 6m\r\nĐường kính gốc: 15 – 20cm', 95, 21, '2025-03-24 04:46:06', 1),
(225, 2, 'Cây Kèn Hồng\r\n', 1050000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-ken-hong-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-ken-hong-3-125x125.jpg', 'Tên khoa học: Tabebuia rosea\r\nHọ: Bignoniaceae ( Đinh)\r\nChiều cao: 3 – 5 m\r\nĐường kính gốc: 10 – 12 cm', 97, 99, '2025-03-24 04:49:54', 1),
(226, 2, 'Cây Chuông Vàng', 1800000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-chuong-vang-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-chuong-vang-2-125x125.jpg', 'Tên phổ thông: Cây chuông vàng\r\nTên khoa học: Tabebuia argentea\r\nHọ thực vật: Bignoniaceae (Núc nác)\r\nChiều cao: 2.5 – 3.5 m\r\nĐường kính thân: 8 – 10 cm', 98, 58, '2025-03-24 04:56:23', 1),
(227, 1, 'Cây ổi ruột đỏ Tân Châu chậu ươm FRUI015', 220000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/oi-ruot-do-tan-chau-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/oi-ruot-do-tan-chau-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/oi-ruot-do-tan-chau-3-125x125.j', 'Ổi ruột đỏ Tân Châu rất giàu chất dinh dưỡng, đặc biệt là vitamin C giúp tăng cường sức đề kháng, hỗ trợ giảm cân và làm đẹp da, khi chín có ruột đỏ hồng vô cùng bắt mắt, ruột đặc rất ít hạt, khi ăn rất giòn, thơm và ngọt.\r\n\r\nTÊN GỌI KHÁC	Cây ruột đỏ Tân Châu\r\nKÍCH THƯỚC CÂY	Chiều cao 60 – 80 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 98, 24, '2025-03-24 05:04:35', 1),
(228, 2, 'Cây cóc Thái Lan trái nhỏ chậu ươm FRUI008', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-coc-thai-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-coc-thai-1-125x125.jpg', 'Trái Cóc Thái nhỏ so với Cóc Ta,có thể ăn được trái non lẫn trái già đều được. Nếu ăn trái non thì hạt cóc rất mềm và nhỏ, khi trái già sẽ có hạt. Vị cóc Thái hơi chua và giòn, rất giàu Vitamin.\r\n\r\nTÊN GỌI KHÁC	Cây cóc Thái\r\nKÍCH THƯỚC CÂY	Chiều cao 80 – 90 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 66, '2025-03-24 05:06:48', 1),
(229, 2, 'Cây ổi lê Đài Loan chậu ươm FRUI009', 180000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-oi-le-dai-loan-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/oi-le-dai-loan-4-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/oi-le-dai-loan-3-125x125.jpg,\r\nhttps:', 'Cây ổi lê Đài Loan cho trái tựa hình quả Lê, giòn giòn thơm ngon, vị ngọt mát, cùi dầy, rất ít hạt và hạt mềm, quả to trung bình 3 quả/kg. Cây rất dễ trồng, không kén đất và có thời gian cho trái sớm với tỷ lệ đậu trái cao, cho thu hoạch quanh năm.\r\n\r\nTÊN GỌI KHÁC	Cây ổi lê Đài Loan\r\nKÍCH THƯỚC CÂY	Chiều cao 90 – 100 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 78, '2025-03-24 05:08:42', 1),
(230, 2, 'Cây sung Mỹ Masui Dauphine B5 chậu ươm FRUI010', 280000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-sung-my-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-dung-my-Masui-Dauphine-b5-125x125.jpg', 'Cây sung Mỹ rất thích hợp với khí hậu tại VN, nó là loại cây ưa nắng ấm, cần nhiều ánh sáng. Cây cho trái to, ăn nhiều mật nhiều hơn những dòng phổ thông các và có độ mọng và thơm, rất giàu dinh dưỡng.\r\n\r\nTÊN GỌI KHÁC	Cây sung Mỹ Masui Dauphine B5\r\nKÍCH THƯỚC CÂY	Chiều cao 20 – 30 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 91, 21, '2025-03-24 05:12:35', 1),
(231, 2, 'Cây chanh cẩm thạch chậu ươm FRUI005', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-chanh-cam-thach-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-chanh-cam-thach-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-chanh-cam-thach-3-125x125.j', 'Cây mận đỏ An Phước là loại cây ăn tái thích hợp trồng nơi có nhiều ánh sáng và thoáng mát như sân vườn để tạo bóng mát và để lấy trái. Cây cần được tưới nước thường xuyên để luôn xanh tốt.\r\n\r\nTÊN GỌI KHÁC	Cây chanh cẩm thạch\r\nKÍCH THƯỚC CÂY	Chiều cao 60 – 70 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 52, '2025-03-24 05:14:00', 1),
(232, 2, 'Cây mận đỏ An Phước chậu ươm FRUI004', 160000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-man-do-an-phuoc-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-man-do-an-phuoc-2-125x125.jpg', 'Cây mận đỏ An Phước là loại cây ăn tái thích hợp trồng nơi có nhiều ánh sáng và thoáng mát như sân vườn để tạo bóng mát và để lấy trái. Cây cần được tưới nước thường xuyên để luôn xanh tốt.\r\n\r\nTÊN GỌI KHÁC	Cây mận đỏ an phước\r\nKÍCH THƯỚC CÂY	Chiều cao 60 – 70 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 83, '2025-03-24 05:15:31', 1),
(233, 2, 'Cây mận xanh tam hoa chậu ươm FRUI003', 200000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-man-xanh-tam-hoa-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-man-xanh-tam-hoa-2-125x125.jpg', 'Cây mận xanh tam hoa là loại cây ăn tái thích hợp trồng nơi có nhiều ánh sáng và thoáng mát như sân vườn để tạo bóng mát và để lấy trái. Cây cần được tưới nước thường xuyên để luôn xanh tốt.\r\n\r\nTÊN GỌI KHÁC	Cây mận xanh tam hoa\r\nKÍCH THƯỚC CÂY	Chiều cao 40 – 60 cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 12, '2025-03-24 05:16:38', 1),
(234, 2, 'Cây bưởi da xanh chậu ươm FRUI001', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/09/cay-buoi-da-xanh-nho-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/09/cay-buoi-da-xanh-co-trai-125x125.jpg', 'Cây bưởi da xanh loại cây có múi được trồng rất phổ biến tại nước ta, thích hợp trồng nơi có nhiều ánh sáng và thoáng mát như sân vườn để tạo bóng mát và để lấy trái. Cây cần được tưới nước thường xuyên để luôn xanh tốt.\r\n\r\nTÊN GỌI KHÁC	Cây bưởi da xanh\r\nKÍCH THƯỚC CÂY	Chiều cao 60 – 80 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước 1 lần/ngày', 100, 127, '2025-03-24 05:17:45', 1),
(235, 2, 'Cỏ Nhung Nhật', 50000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/co-nhung-nhat-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/co-nhung-nhat-gia-re-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/co-nhung-nhat-gia-re-3-125x125.jpg,\r\nhtt', 'Cỏ nhung Nhật là loại cỏ thảm thường được sử dụng cho sân vườn biệt thự, sân vận động, công viên, khu vui chơi,… Loại cỏ này có đặc điểm lá rất mềm mịn, tuy nhỏ nhưng gây kích ứng, rất thân thiện với con người.\r\n\r\nTÊN KHOA HỌC	Zoysia japonoca\r\nTÊN GỌI KHÁC	Cỏ nhung Nhật / Cỏ thảm\r\nQUY CÁCH SẢN PHẨM	100×100 cm (một mét vuông)\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Ngoài trời\r\nNHU CẦU NƯỚC	Tưới nước mỗi ngày', 100, 94, '2025-03-24 05:19:22', 1),
(236, 2, 'Cây bạch trinh biển chậu ươm nhỏ HYME001', 15000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-bach-trinh-bien-1-768x768.jpg', 'Cây bạch trinh biển là loài cây có sức sống mạnh liệt, liên tục phát triển nhánh mới, ra hoa trắng xinh quanh năm và sống lâu năm nên thường được chọn để trồng tạo cảnh quan xanh mát.\r\n\r\nTÊN KHOA HỌC	Hymenocallis littoralis\r\nTÊN THÔNG THƯỜNG	Cây bạch trinh biển\r\nQUY CÁCH SẢN PHẨM	Chiều cao 10 – 15 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 65, 227, '2025-03-24 05:21:24', 1),
(237, 2, 'Cây mai chỉ thiên nhỏ chậu ươm WRIG001', 40000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-mai-chi-thien-chau-nho-768x768.jpg', 'Cây thường xuân có bộ lá xanh tươi tốt, hình dáng ấn tượng giúp mang lại không gian xanh mát. Đây là dòng cây dễ chăm đang là “trend” được nhiều người lựa chọn trồng trang trí vườn rất đẹp.\r\n\r\nTÊN TIẾNG ANH	Wrighta antidysenterica\r\nTÊN THÔNG THƯỜNG	Cây mai chỉ thiên\r\nKÍCH THƯỚC CÂY	Chiều cao 40cm\r\nĐỘ KHÓ	Dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nhiều ánh sáng / Nắng trực tiếp\r\nNHU CẦU NƯỚC	Nhiều nước, 1 lần/ngày', 84, 686, '2025-03-24 05:22:47', 1),
(238, 2, 'Cây Cúc Tần Ấn Độ Vernonia elliptica', 35000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-cuc-tan-an-do-Vernonia-elliptica-1-2.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-cuc-tan-an-do-Vernonia-elliptica-2-1-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/c', 'Cúc Tần Ấn Độ là loại cây dây leo thân mềm có sức sống mạnh mẽ, phát triển nhanh và ít sâu bệnh. Rất thích hợp để trồng tạo cảnh quan trên ban công, sân thượng, cao tầng… Với tác dụng như tấm màn che tự nhiên, tô điểm cho ngôi nhà thêm xanh tươi, mát mẻ và trong lành hơn.\r\n\r\nTÊN KHOA HỌC	Vernonia elliptica\r\nTÊN GỌI KHÁC	Cúc tần ấn độ\r\nKÍCH THƯỚC CÂY	• Cỡ nhỏ: Cao 30 – 40 cm\r\n• Cỡ trung: Cao 40 – 60 cm\r\n• Cỡ lớn: Cao 100 – 120 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng trực tiếp\r\nNHU CẦU NƯỚC	Tưới nước mỗi ngày', 100, 113, '2025-03-24 05:24:07', 1),
(239, 3, 'Chậu Xi Măng Đá Mài Trụ Vuông Vát Đáy', 460000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/chau-xi-mang-da-mai-vuong-dung-vat-day-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/chau-xi-mang-da-mai-vuong-dung-vat-day-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2', 'CHẤT LIỆU	Xi măng, đá cẩm thạch\r\nGIA CỐ	Tấm lưới thủy tinh\r\nQUY CÁCH SẢN PHẨM (RxC)	• 28×45 (cm)\r\n• 32×55 (cm)\r\n• 36×45 (cm)\r\n• 36×65 (cm)\r\n• 43×65 (cm)\r\nMÀU SẮC	• Trắng\r\n• Đen\r\n• Xám', 98, 88, '2025-03-24 05:30:13', 1),
(240, 3, 'Chậu Xi Măng Đá Mài Hình Vuông Trụ', 370000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/chau-xi-mang-da-mai-vuong-ong-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/chau-xi-mang-da-mai-vuong-ong-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/chau-xi-man', 'CHẤT LIỆU	Xi măng, đá cẩm thạch\r\nGIA CỐ	Tấm lưới thủy tinh\r\nQUY CÁCH SẢN PHẨM (RxC)	• 25×50 (cm)\r\n• 30×50 (cm)\r\n• 30×60 (cm)\r\n• 35×50 (cm)\r\n• 35×70 (cm)\r\n• 40×80 (cm)\r\nMÀU SẮC	• Trắng\r\n• Đen\r\n• Xám', 97, 64, '2025-03-24 05:34:03', 1),
(241, 3, 'Chậu Xi Măng Đá Mài Vuông Trọng Lượng Nhẹ', 150000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/02/chau-xi-mang-da-mai-vuong-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/chau-xi-mang-da-mai-vuong-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/02/chau-xi-mang-da-mai', 'CHẤT LIỆU	Xi măng, đá cẩm thạch\r\nGIA CỐ	Tấm lưới thủy tinh\r\nQUY CÁCH SẢN PHẨM (RxC)	• 20×20 (cm)\r\n• 25×25 (cm)\r\n• 30×30 (cm)\r\n• 40×40 (cm)\r\n• 50×50 (cm)\r\n• 60×60 (cm)\r\nMÀU SẮC	• Trắng\r\n• Đen\r\n• Xám', 83, 316, '2025-03-24 05:35:39', 1),
(242, 3, 'Chậu đất nung vân quấn rối 18x16cm DANU095', 60000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-dat-nung-de-ban-van-quan-roi-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-dat-nung-de-ban-van-quan-roi-2-125x125.jpg', 'CHẤT LIỆU	Đất nung sơn màu\r\nHỌA TIẾT	Gân sọc dọc\r\nKÍCH THƯỚC	\r\n18×18 cm (DxC) \r\n MÀU SẮC	Màu mộc\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 45, '2025-03-24 05:42:56', 1),
(243, 3, 'Chậu đất nung vân chiếc lá màu mộc 12x11cm DANU091', 25000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/chau-dat-nung-hinh-chiec-la-768x768.jpg', '\r\nCHẤT LIỆU	Đất nung sơn\r\nHỌA TIẾT	Vân lá\r\nKÍCH THƯỚC	\r\n12×11 cm (DxC) \r\n MÀU SẮC	Màu mộc\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 94, 88, '2025-03-24 05:45:19', 1),
(244, 3, 'Chậu đất nung hình trụ sơn ngôi nhà 16x16cm DANU092', 0, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/chau-dat-nung-son-ngoi-nha-768x768.jpg', '\r\nCHẤT LIỆU	Đất nung sơn\r\nHỌA TIẾT	Sơn ngôi nhà\r\nKÍCH THƯỚC	\r\n16×16 cm (DxC) \r\n MÀU SẮC	Màu mộc\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 55, '2025-03-24 05:46:32', 1),
(245, 3, 'Chậu đất nung sơn vân giả đá có đĩa 30×30 DANU109', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-dat-nung-van-gia-da-co-dia-3-768x768.jpg', 'CHẤT LIỆU	Gốm đất nung sơn\r\nHỌA TIẾT	Giả đá\r\nKÍCH THƯỚC	\r\n30x30cm (DxC)\r\n MÀU SẮC	Nâu / Trắng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 93, 223, '2025-03-24 05:51:03', 1),
(247, 3, 'Chậu gốm tráng men vân giả đá 3 kích thước GOSU013\r\n', 230000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/10/chau-gom-su-trang-goc-doc-3-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/chau-gom-su-trang-goc-doc-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/10/chau-gom-su-trang-g', 'CHẤT LIỆU	Gốm tráng men\r\nHỌA TIẾT	Sọc dọc, vân đá\r\nKÍCH THƯỚC	\r\n18×16 / 14×13 / 10×10 cm (DxC) \r\n MÀU SẮC	Trắng\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 97, 15, '2025-03-24 05:52:12', 1),
(248, 3, 'Chậu Chữ Nhật Xi Măng Đá Mài 80x40x40Cm Trồng Cây Hoa Kiểng', 170000, 0, 0, '\r\nhttps://down-vn.img.susercontent.com/file/sg-11134201-7ra1k-m4mxs36q0vvbd8.webp,\r\nhttps://down-vn.img.susercontent.com/file/sg-11134201-7ra0r-m4mxs3ddr6nodd.webp', 'Chậu Dài 80Cm X Rộng40Cm phù hợp với nhà to đẹp. \r\n\r\n Bên mình hiện có 3 màu \r\n\r\n TRẮNG 80*40 \r\n\r\nĐEN 80*40\r\n\r\n XÁM XI MĂNG  80*40', 98, 66, '2025-03-24 05:58:20', 1),
(249, 3, 'CHẬU NHỰA CHỮ NHẬT TRỒNG RAU, HOA CÂY CẢNH THÔNG MINH KÍCH THƯỚC 48X20X16cm', 30000, 0, 0, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lqbzpyu5blxu7f.webp,\r\nhttps://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lqbzpyu5r2gn1f.webp,\r\nhttps://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lqbzpyu4w5yv65.webp', 'CHẬU NHỰA CHỮ NHẬT( KHAY) TRỒNG RAU, HOA CÂY CẢNH THÔNG MINH KÍCH THƯỚC 48X20X16cm\r\n👉Loại chậu trồng rau chuyên dụng này, do có lớp lưới nhựa ngăn cách giữa 2 tầng nên có ưu điểm \r\nT👉rên các khay trồng rau thông thường, chúng ta thường phải đục các lỗ bên hông, dưới đáy chậu để tránh ngập úng cho cây trồng. Tuy nhiên khả năng thoát nước của chúng thường không tốt do các lỗ bị đất đá bịt kín, dẫn đến rau của bạn bị ngập úng, vàng lá và không phát triển tốt.\r\n👉Với chậu trồng rau thông minh, lượng nước dư thừa được lọc qua một tấm lưới với thiết diện rộng và nhiều lỗ Nhờ vậy nước dễ dàng chảy xuống phần dưới đáy chậu và chảy ra ngoài với chỉ 1 hoặc 2 lỗ nhỏ', 93, 22, '2025-03-24 06:02:41', 1),
(251, 2, 'Cây hoa nguyệt quế chậu ươm MURA001', 250000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2021/04/cay-nguyet-que-chau-uom-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2021/04/cay-hoa-nguyet-que-1-1-125x125.jpg', 'Cây hoa nguyệt quế loại cây trồng hàng rào rất phổ biến bởi nó có sức sống rất mãnh liệt, không cần tốn nhiều công chăm sóc mà vẫn xanh tốt. Cây ắc ó thuộc loại thân gỗ lớn, sống lâu năm, có hoa rất thơm.\r\n\r\nTÊN KHOA HỌC	Murraya paniculata\r\nTÊN THÔNG THƯỜNG	Cây nguyệt quế\r\nQUY CÁCH SẢN PHẨM	Chiều cao 80 – 100 cm\r\nĐỘ KHÓ	Rất dễ chăm sóc\r\nYÊU CẦU ÁNH SÁNG	Nắng tán xạ\r\nNHU CẦU NƯỚC	Ít nước, 2 – 3 lần/tuần', 88, 25, '2025-03-24 06:05:53', 1),
(252, 3, 'Chậu gốm trụ tròn ghép Mosaic ‘nhiệt đới’ 20x18cm GOSU033', 200000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-som-su-hoa-tiet-nhiet-doi-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-som-su-hoa-tiet-nhiet-doi-2-125x125.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-gom-', '\r\nCHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	‘Nhiệt đới’\r\nKÍCH THƯỚC	\r\n20x18cm (DxC) \r\n MÀU SẮC	Nhiều màu sắc\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 94, 126, '2025-03-24 06:16:35', 1),
(253, 3, 'Chậu xi măng đá mài trụ tròn vẽ zigzac XMDM013', 0, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/12/chau-xi-mang-da-mai-ve-768x768.jpg', '\r\nCHẤT LIỆU	Xi măng, đá cẩm thạch\r\nGIA CỐ	Tấm lưới thủy tinh\r\nQUY CÁCH SẢN PHẨM (RxC)	30×30 (cm)\r\nMÀU SẮC	Đen, Xám', 100, 52, '2025-03-24 06:19:18', 1),
(254, 3, 'Chậu gốm trụ tròn hoa tiết caro 25x24cm GOSU034\r\n', 0, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-van-caro-1-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-van-caro-2-125x125.jpg', 'CHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	‘Caro’\r\nKÍCH THƯỚC	\r\n25x24cm (DxC) \r\n MÀU SẮC	Xanh đại dương\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 100, 152, '2025-03-24 06:20:39', 1),
(255, 3, 'Chậu gốm trụ tròn men nhám 12,5x11cm GOSU035', 45000, 0, 0, 'https://mowgarden.com/wp-content/uploads/2022/11/chau-gom-su-tru-tron-de-ban-768x768.jpg,\r\nhttps://mowgarden.com/wp-content/uploads/2022/11/cay-da-bup-do-cam-thach-chau-gom-su-125x125.jpg', '\r\nCHẤT LIỆU	Gốm sứ\r\nHỌA TIẾT	Trơn nhám\r\nKÍCH THƯỚC	\r\n12,5x11cm (DxC) \r\n MÀU SẮC	Xanh dương\r\n*Ghi chú: Sản phẩm là hàng thủ công mỹ nghệ nên không thể hoàn hảo tuyệt đối, thông số kích thước có thể sai sót 5% đến 10%', 92, 26, '2025-03-24 06:22:13', 1),
(256, 4, 'Cưa tay lưỡi gập 135P Gardena 08742-20', 932000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-cat-canh/8742/cua-tay-luoi-gap-135p-gardena-08742-20-11.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/dung-cu-cat-canh/8742/cua-tay-luoi-gap-135p-gardena-08742-20-6.jpg,\r\nhttps://dolamvuon.vn/Upload/a', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nChiều dài lưỡi cưa 135mm\r\nChất liệu: thép không gỉ\r\nTay cầm: Nhựa HDPE cao cấp\r\nLưỡi gập 3 chế độ\r\nMã vạch: 4078500874205\r\nKích thước: 203 x 59 x 28 mm\r\nTrọng lượng: 220g\r\nBảo hành: 12 tháng', 100, 45, '2025-04-05 04:36:40', 1),
(257, 4, 'Cưa tay lưỡi gập 200P Gardena 08743-20', 1355000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-cat-canh/8743/cua-tay-luoi-gap-200p-gardena-08743-20-10.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/dung-cu-cat-canh/8743/cua-tay-luoi-gap-200p-gardena-08743-20-2.jpg,', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nChiều dài lưỡi cưa 200mm\r\nChất liệu: thép không gỉ\r\nTay cầm: Nhựa HDPE cao cấp\r\nLưỡi gập 3 chế độ\r\nMã vạch: 4078500874304\r\nKích thước: 291 x 64 x 28 mm\r\nTrọng lượng: 320g\r\nBảo hành: 12 tháng', 100, 33, '2025-04-05 04:41:05', 1),
(258, 4, 'Kéo cắt cỏ cầm tay Gardena 08733-20', 557000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/keo-cat-co-keo-tia-rao/8733/keo-cat-co-cam-tay-gardena-08733-20-7.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/keo-cat-co-keo-tia-rao/8733/keo-cat-co-cam-tay-gardena-08733-20-4.jpg,\r\nhttps://dolamvuon.vn/Upl', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nKiểu cắt: bóp bằng 1 tay\r\nLưỡi cắt: dài 23cm\r\nLưỡi cắt phủ chống dính\r\nChốt khóa an toàn\r\nMã vạch: 4078500873307\r\nKích thước: 373 x 154 x 42 mm\r\nTrọng lượng: 296g\r\nBảo hành: 12 tháng', 100, 22, '2025-04-05 04:43:27', 1),
(259, 4, 'Kéo cắt cỏ Gardena xoay lưỡi 360 độ 08734-20', 557000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/keo-cat-co-keo-tia-rao/8734/keo-cat-co-gardena-xoay-luoi-360-do-08734-20-1.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nKiểu cắt: bóp bằng 1 tay\r\nLưỡi cắt: dài 23cm\r\nLưỡi cắt phủ chống dính\r\nLưỡi cắt xoay 360 độ\r\nChốt khóa an toàn\r\nMã vạch: 4078500873307\r\nKích thước: 373 x 154 x 42 mm\r\nTrọng lượng: 264g', 100, 11, '2025-04-05 04:43:27', 1),
(262, 4, 'Cuốc cầm tay mini Gardena 08915-20\r\n', 370000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08915/cuoc-cam-tay-mini-gardena-08915-20-3.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nĐầu cuốc và cào xới đất\r\nChất liệu: Kim loại \r\nTây cầm: nhựa HDPE cao cấp\r\nPhủ lớp duroplast cao cấp\r\nCó thể kết hợp với cán dài 78-130cm\r\nMã vạch: 4078500023429\r\nKích thước: 366 x 173 x 80 mm\r\nTrọng lượng: 333g', 100, 65, '2025-04-05 04:47:06', 1),
(263, 4, 'Đầu cuốc mini 14cm Gardena 03112-20', 420000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/03112/dau-cuoc-mini-14-cm-gardena-03112-20-3.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nĐầu cuốc làm tơi đất\r\nChất liệu: Kim loại \r\nPhủ lớp duroplast cao cấp\r\nThích hợp cho cán 130 đến180cm\r\nMã vạch: 4078500311205\r\nKích thước: 175 x 140 x 125 mm\r\nTrọng lượng: 330g', 100, 63, '2025-04-05 04:47:06', 1),
(264, 4, 'Đầu cuốc và cào đất Gardena 03219-20', 477000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/03219/dau-cuoc-va-cao-dat-gardena-03219-20-7.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/03219/dau-cuoc-va-cao-dat-gardena-03219-20-5.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nĐầu cuốc và cào đất\r\nChất liệu: Kim loại \r\nPhủ lớp duroplast cao cấp\r\nThích hợp cho cán 130 đến180cm\r\nMã vạch: 4078500321907\r\nKích thước: 266 x 266 x 146 mm\r\nTrọng lượng: 490g', 97, 82, '2025-04-05 04:51:30', 1),
(267, 4, 'Xẻng trồng cây 12cm Gardena 08953-20', 316500, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08953/xeng-trong-cay-12cm-gardena-08953-20-2.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08953/xeng-trong-cay-12cm-gardena-08953-20-7.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nChiều rộng lưỡi: 12cm\r\nChất liệu: Kim loại \r\nTay cầm: Nhựa HDPE cao cấp\r\nPhủ lớp duroplast cao cấp\r\nMã vạch: 4078500023696\r\nKích thước: 385 x 124 x 75 mm\r\nTrọng lượng: 365g\r\nBảo hành: 12 tháng', 100, 12, '2025-04-05 04:54:01', 1),
(268, 4, 'Xẻng trồng cây 8cm Gardena 08950-20', 136500, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08950/xeng-trong-cay-8cm-gardena-08950-20-6.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08950/xeng-trong-cay-8cm-gardena-08950-20-7.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nChiều rộng lưỡi: 8cm\r\nChất liệu: Kim loại \r\nTay cầm: Nhựa HDPE cao cấp\r\nPhủ lớp duroplast cao cấp\r\nMã vạch: 4078500023603\r\nKích thước: 335 x 80 x 45 mm\r\nTrọng lượng: 240g', 100, 22, '2025-04-05 04:54:01', 1),
(271, 4, 'Xẻng giẫy cỏ 14.5cm Gardena 08935-20\r\n', 284000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08935/xeng-giay-co-145cm-gardena-08935-20-3.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08935/xeng-giay-co-145cm-gardena-08935-20-5.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nChiều dài lưỡi: 14.5cm\r\nChất liệu: Kim loại \r\nTây cầm: Nhựa HPDE cao cấp\r\nPhủ lớp duroplast cao cấp\r\nMã vạch: 4078500023627\r\nKích thước: 375 x 42 x 35 mm\r\nTrọng lượng: 185g', 99, 51, '2025-04-05 04:56:20', 1),
(272, 4, 'Xẻng trồng cây 8.5cm Gardena 08929-20\r\n', 234000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08929/xeng-trong-cay-85cm-gardena-08929-20-2.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/08929/xeng-trong-cay-85cm-gardena-08929-20-3.jpg,\r\nhttps://dolamvuon.vn/Upload/anh-', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nChiều rộng lưỡi 8.5cm\r\nChất liệu: Kim loại \r\nPhủ lớp duroplast cao cấp\r\nCó thể kết nối với cán 130 đến180cm\r\nMã vạch: 4078500023580\r\nKích thước: 410 x 110 x 50 mm\r\nTrọng lượng: 275g', 100, 36, '2025-04-05 04:56:20', 1),
(273, 4, 'Xẻng trồng cây cán dài Gardena 117 cm 17012-20\r\n', 1768000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/dung-cu-lam-vuon/17012/xeng-trong-cay-can-dai-gardena-117cm-17012-20-1.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Cộng Hòa Séc\r\nChiều dài xẻng: 117cm\r\nLưỡi rộng: 19cm\r\nChất liệu: Kim loại\r\nTay cầm: bọc nhựa HDPE cao cấp \r\nPhủ lớp sơn tĩnh điện chất lượng cao\r\nMã vạch: 4078500042840\r\nKích thước: 1171 x 192 x 125 mm\r\nTrọng lượng: 2050g', 98, 24, '2025-04-05 04:59:46', 1),
(275, 4, 'Kéo tỉa bonsai cao cấp 20,5cm HM040', 250000, 0, 0, 'https://product.hstatic.net/1000220180/product/keo_bonsai_cao_cap_thep_den_49_dungculamvuon.vn_e22d9debf2e7461d93cde1b1409211d4_master.jpg', 'Mã sản phẩm:	#029269\r\nThương hiệu:	HM\r\nXuất xứ thương hiệu:	Việt Nam\r\n', 0, 102, '2025-04-05 05:03:42', 1),
(276, 4, 'Kéo tỉa cao cấp 19,5cm HM041', 40000, 0, 0, 'https://www.bing.com/th/id/OIP.keYlNRUwgQ1LfUN4bL0-HgHaHa?w=176&h=185&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2', 'Mã sản phẩm: HM041 \r\nTình trạng: Còn hàng \r\nThương hiệu: Đài Loan', 97, 33, '2025-04-05 05:07:18', 1),
(277, 4, 'Cạp tròn đen bonsai', 380000, 0, 0, 'https://www.bing.com/th/id/OIP.7Ll3RHcgxjUfkFA_j3p56wHaJ3?w=150&h=200&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2', 'Chất liệu	Thép đen CrWMn\r\nĐộ cứng	62HRC\r\nKích thước	21cm\r\nCân nặng	220g', 97, 55, '2025-04-05 05:59:40', 1),
(279, 4, 'Kìm cạp tròn trắng bonsai MSTWA', 550000, 0, 0, 'https://www.bing.com/th/id/OIP.RHPIJdm6Db40za-Fz753hwHaGl?w=128&h=110&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2', 'Chất liệu	Thép trắng 5CR13 (thép hợp kim không gỉ)\r\nĐộ cứng	62HRC\r\nKích thước	21cm\r\nCân nặng	210g', 98, 96, '2025-04-05 06:01:45', 1),
(280, 4, 'Đầu giỏ hái quả Gardena 03115-20', 120000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/phu-kien-san-vuon/3115/dau-gio-hai-qua-gardena-03115-20-7.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nTất cả rãnh thưa đều kết hợp cắt cuống\r\nChất liệu: Nhựa cao cấp\r\nChuôi kết nối tiêu chuẩn\r\nMã vạch: 4078500033565\r\nKích thước: 490 x 175 x 73 mm\r\nTrọng lượng: 248g\r\nBảo hành: 12 tháng', 100, 12, '2025-04-05 06:04:54', 1),
(281, 4, 'Bộ vòi tưới cây ban công 5 - 10 mét Gardena', 985000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/bo-voi-tuoi-cay/18416/bo-day-ban-cong-gardena-2.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nĐường kính: 13mm\r\nChiều dài: 5 mét - 10 mét\r\n01 cút một chiều 13-15mm\r\n01 cút hai chiều 13-15mm\r\n02 cút ren 33 và 26.5mm\r\n1 vòi phun cổ điển 2 chức năng\r\n1 giá treo tường\r\nkích thước: 350 x 350 x 150 mm\r\nTrọng lượng: 1200g\r\nBảo hành: 12 tháng', 98, 2, '2025-04-05 06:24:45', 1),
(282, 4, 'Bộ vòi tưới cây ban công Gardena 18411-20\r\n', 1364000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/bo-voi-tuoi-cay/18411/bo-voi-tuoi-cay-ban-cong-gardena-18411-20-4.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nChiều dài dây: 7.5 mét\r\nĐường kính dây: 9mm\r\n1 cút nối một chiều\r\n1 cút nối hai chiều\r\n1 vòi phun oroa nhẹ\r\n1 cút nối ren 26.5mm\r\nMã vạch: 4078500025379\r\nTrọng lượng: 820g\r\nKích thước: 395 x 355 x 147mm\r\nBảo hành: 12 tháng', 98, 23, '2025-04-05 06:24:45', 1),
(283, 4, 'Bộ vòi tưới cây co dãn 10 mét Gardena 04647-20\r\n', 1484000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/bo-voi-tuoi-cay/4647/bo-voi-tuoi-cay-co-dan-10-met-gardena-04647-20-4.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nĐường kính: 9mm\r\nChiều dài: 10 mét\r\n01 cút một chiều 9mm\r\n01 cút hai chiều 9mm\r\n01 cút ren 26.5mm\r\n1 vòi phun oroa nhẹ\r\nMã vạch: 4078500464703\r\nTrọng lượng: 1065g\r\nBảo hành: 12 tháng', 100, 22, '2025-04-05 06:27:01', 1),
(284, 4, 'Bộ vòi tưới cây xe cuộn 20 mét Gardena 18502-20\r\n', 2301000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/bo-voi-tuoi-cay/18502/bo-voi-tuoi-cay-xe-cuon-20-met-gardena-18502-20-3.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nĐường kính: 13mm\r\nChiều dài: 20 mét\r\n01 cút một chiều 13-15mm\r\n03 cút hai chiều 13-15mm\r\n02 cút ren 21 và 26.5mm\r\n1 vòi phun cổ điển 2 chức năng\r\nMã vạch: 4078500033091\r\nkích thước: 340 x 440 x 460 mm\r\nTrọng lượng: 4800g\r\nBảo hành: 12 tháng', 100, 63, '2025-04-05 06:27:01', 1),
(285, 4, 'Bình tưới cây 1lít Gardena 11112-20\r\n', 374000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/binh-tuoi-cay-ap-suat/11112/binh-tuoi-cay-1-lit-gardena-11112-20-11.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Trung Quốc\r\nDung tích: 1 lít\r\nChất liệu: Nhựa HDPE cao cấp\r\nVạch trắng báo mực nước\r\nKiểu phun: Phun sương và tia thẳng\r\nMã vạch: 4078500051118\r\nTrọng lượng: 220g\r\nKích thước: 140 x 115 x 275 mm\r\nBảo hành: 12 tháng', 93, 12, '2025-04-05 06:31:59', 1),
(287, 4, 'Bình tưới cây áp suất 1.25 lít Gardena 11120-20\r\n', 858000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/binh-tuoi-cay-ap-suat/11120/binh-tuoi-cay-ap-suat-125-lit-gardena-11120-20-5.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Trung Quốc\r\nDung tích: 1.25 lít\r\nChất liệu: Nhựa HDPE cao cấp\r\nĐầu tưới điều chỉnh lên xuống\r\nVạch trắng báo mực nước\r\nKiểu phun: Áp suất phun sương và tia thẳng\r\nMã vạch: 4078500051132\r\nTrọng lượng: 680g\r\nKích thước: 145 x 150 x 290 mm\r\nBảo hành: 12 tháng', 99, 3, '2025-04-05 06:32:23', 1),
(288, 4, 'Bình tưới cây áp suất 5 lít Gardena 11130-20', 1750000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/binh-tuoi-cay-ap-suat/11130/binh-tuoi-cay-ap-suat-5-lit-gardena-11130-20-9.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Trung Quốc\r\nDung tích: 5 lít\r\nChất liệu: Nhựa HDPE cao cấp\r\nVạch trắng báo mực nước\r\nKiểu phun: Áp suất phun sương và tia thẳng\r\nMã vạch: 4078500051156\r\nTrọng lượng: 1200g\r\nKích thước: 228 x 182 x 510 mm\r\nBảo hành: 12 tháng', 95, 26, '2025-04-05 06:32:23', 1),
(289, 4, 'Bình tưới cây 5 lít chạy pin Gardena 11136-20', 3200000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/binh-tuoi-cay-ap-suat/11136/binh-tuoi-cay-5-lit-chay-pin-gardena-11136-20-1.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Trung Quốc\r\nDung tích: 5 lít\r\nPin 4.2V / 2.0 Ah\r\nChế độ phun sương: 2 tiếng\r\nChế độ phun tia thẳng: 1 tiếng\r\nChất liệu: Nhựa HDPE cao cấp\r\nCần tưới có thể thay đổi chiều dài\r\nĐầu tưới gập lên xuống được\r\nVạch trắng báo mực nước\r\nMã vạch: 4078500052481\r\nTrọng lượng: 2090g\r\nKích thước: 230 x 250 x 530 mm\r\nBảo hành: 12 tháng', 100, 76, '2025-04-05 06:34:01', 1),
(290, 4, 'Vòi tưới cây cổ điển Gardena 18300-50\r\n', 170000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/voi-tuoi-cay/18300/voi-tuoi-cay-co-dien-gardena-18300-50-8.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nHai chế độ phun xòe và tia thẳng\r\nMàu sắc: Đen,cam\r\nĐiều chỉnh: vặn trên đầu vòi\r\nMã vạch:4078500010658\r\nKích thước: 35 x 35 x 137 mm\r\nTrọng lượng: 560g\r\nBảo hành: 12 tháng', 87, 232, '2025-04-05 06:36:22', 1),
(291, 4, 'Vòi tưới cây 2 chức năng Gardena 18303-20\r\n', 405000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/voi-tuoi-cay/18303/voi-tuoi-cay-2-chuc-nang-gardena-18303-20-8.jpg', 'Xuất xứ: Đức\r\nKiểu phun: 2 chức năng\r\nMàu sắc: Đen, xám, cam, xanh\r\nChất liệu: Nhựa HPDE cao cấp\r\nĐiều chỉnh: Vặn trên đầu vòi\r\nĐiều chỉnh lưu lượng nước\r\nCò bóp khóa mở nước\r\nMã vạch: 4078500024280\r\nKích thước: 35 x 35 x 137 mm\r\nTrọng lượng: 560g\r\nBảo hành: 12 tháng', 96, 26, '2025-04-05 06:36:52', 1),
(292, 4, 'Vòi tưới cây phun loe Gardena 18311-20\r\n', 450000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/voi-tuoi-cay/18311/voi-tuoi-cay-phun-loe-gardena-18311-20-10.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nMột chế độ phun loe\r\nMàu sắc: Xám,cam\r\nĐiều chỉnh: tắt mở cò bó\r\nNút cam vặn lưu lượng nước\r\nMã vạch:4078500010795\r\nKích thước: 215 x 200 x 58 mm\r\nTrọng lượng: 169g\r\nBảo hành: 12 tháng', 98, 34, '2025-04-05 06:37:32', 1),
(293, 4, 'Vòi tưới cây 4 chức năng Gardena 18304-20\r\n', 700000, 0, 0, 'https://dolamvuon.vn/Upload/anh-san-pham/voi-tuoi-cay/18304/voi-tuoi-cay-4-chuc-nang-gardena-18304-20-7.jpg', 'Thương hiệu: Gardena\r\nXuất xứ: Đức\r\nKiểu phun: 4 chức năng\r\nĐiều chỉnh: vặn trên đầu vòi\r\nĐiều chỉnh lưu lượng nước\r\nCò bóp khóa mở nước\r\nMàu sắc: Ghi, đen, cam\r\nMã vạch: 4078500044561\r\nKích thước: 195 x 220 x 45 mm\r\nTrọng lượng: 200g\r\nBảo hành: 12 tháng', 98, 32, '2025-04-05 06:37:32', 1);
INSERT INTO `product` (`id`, `cate_id`, `name`, `price`, `sale`, `price_sale`, `images`, `discription`, `inventory_quantity`, `view`, `create_date`, `status`) VALUES
(294, 4, 'Bánh dầu đậu phộng LAVAMIX dạng bột đã qua xử lý - Gói 1kg', 27000, 0, 0, 'https://product.hstatic.net/1000269461/product/banh-dau-dau-phong-1kg_b496f7d5563343548a3030abad2b4dfa_large.jpg', 'Bánh dầu hay phân bánh dầu đã là phụ phẩm có được từ ngành ép dầu đậu phộng. Sản phẩm sau đó được xử lý kĩ bằng công nghệ tiên tiến để tạo ra sản phẩm phân bánh dầu chất lượng nhất. Sản phẩm phân bánh dầu đã qua xử lý cung cấp hàm lượng chất hữu cơ lên đến 40%, khoáng và các vitamin cần thiết cho sự phát triển của cây trồng.', 0, 28, '2025-04-05 07:08:22', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products_favorite`
--

CREATE TABLE `products_favorite` (
  `id` int(11) NOT NULL,
  `pr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products_favorite`
--

INSERT INTO `products_favorite` (`id`, `pr_id`, `user_id`) VALUES
(5, 22, 2),
(13, 238, 2),
(21, 223, 2),
(22, 201, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_type_cate`
--

CREATE TABLE `product_type_cate` (
  `id` int(10) NOT NULL,
  `pr_id` int(10) NOT NULL,
  `type_cate_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_type_cate`
--

INSERT INTO `product_type_cate` (`id`, `pr_id`, `type_cate_id`) VALUES
(18, 6, 9),
(19, 6, 10),
(20, 6, 15),
(21, 6, 19),
(22, 6, 5),
(29, 8, 9),
(30, 8, 17),
(31, 8, 10),
(32, 8, 16),
(33, 8, 15),
(34, 8, 19),
(35, 9, 9),
(36, 9, 17),
(37, 9, 10),
(38, 9, 15),
(43, 9, 11),
(44, 10, 17),
(45, 10, 10),
(46, 10, 9),
(47, 10, 19),
(48, 11, 10),
(49, 11, 17),
(50, 11, 16),
(51, 11, 15),
(52, 11, 19),
(53, 12, 9),
(54, 12, 17),
(55, 12, 17),
(56, 12, 10),
(57, 12, 16),
(58, 12, 15),
(59, 12, 19),
(60, 13, 10),
(61, 13, 17),
(62, 13, 16),
(63, 13, 15),
(64, 14, 17),
(65, 14, 17),
(66, 14, 10),
(67, 14, 19),
(68, 14, 12),
(69, 15, 10),
(70, 15, 17),
(71, 15, 19),
(72, 15, 16),
(73, 15, 12),
(74, 16, 9),
(75, 16, 17),
(76, 16, 19),
(77, 16, 16),
(78, 20, 10),
(79, 20, 17),
(80, 20, 15),
(81, 20, 16),
(82, 20, 19),
(83, 20, 15),
(84, 19, 9),
(85, 19, 17),
(86, 19, 10),
(87, 19, 19),
(89, 22, 9),
(90, 22, 17),
(91, 22, 10),
(92, 22, 19),
(93, 22, 19),
(94, 21, 10),
(95, 21, 15),
(96, 21, 16),
(97, 21, 15),
(98, 21, 15),
(99, 25, 9),
(100, 25, 17),
(101, 25, 10),
(102, 25, 16),
(103, 26, 16),
(104, 26, 10),
(105, 26, 17),
(106, 26, 18),
(107, 26, 8),
(108, 26, 15),
(109, 27, 35),
(110, 27, 33),
(111, 28, 33),
(112, 28, 35),
(113, 29, 33),
(114, 29, 35),
(115, 30, 35),
(116, 30, 33),
(117, 31, 33),
(118, 31, 33),
(119, 32, 33),
(120, 32, 35),
(121, 33, 35),
(122, 33, 33),
(123, 34, 33),
(124, 34, 35),
(125, 34, 12),
(126, 35, 12),
(127, 35, 33),
(128, 35, 35),
(129, 35, 30),
(130, 35, 28),
(131, 36, 30),
(132, 36, 33),
(133, 37, 33),
(134, 37, 29),
(135, 37, 35),
(136, 37, 12),
(137, 39, 35),
(138, 39, 31),
(140, 38, 33),
(141, 38, 35),
(142, 41, 33),
(143, 41, 5),
(145, 40, 31),
(146, 40, 35),
(147, 42, 33),
(148, 42, 12),
(149, 43, 33),
(150, 43, 20),
(151, 43, 33),
(152, 43, 12),
(153, 46, 33),
(154, 46, 35),
(155, 46, 20),
(156, 46, 12),
(157, 47, 33),
(158, 47, 12),
(159, 47, 20),
(160, 47, 35),
(161, 48, 44),
(162, 48, 40),
(163, 48, 49),
(164, 49, 49),
(165, 49, 44),
(166, 49, 40),
(167, 50, 44),
(168, 50, 49),
(169, 51, 44),
(170, 51, 49),
(171, 52, 46),
(173, 53, 46),
(300, 198, 3),
(301, 198, 9),
(302, 198, 17),
(303, 198, 16),
(304, 198, 15),
(305, 198, 19),
(306, 200, 4),
(307, 200, 10),
(308, 200, 16),
(309, 200, 19),
(310, 200, 3),
(311, 200, 12),
(312, 201, 3),
(313, 201, 17),
(314, 201, 15),
(315, 201, 16),
(316, 201, 19),
(317, 201, 12),
(322, 6, 3),
(324, 9, 4),
(325, 8, 4),
(326, 10, 4),
(327, 11, 4),
(328, 11, 28),
(333, 12, 3),
(334, 13, 3),
(335, 14, 3),
(336, 15, 4),
(337, 16, 4),
(338, 19, 4),
(339, 26, 3),
(340, 204, 5),
(341, 204, 14),
(342, 206, 5),
(343, 206, 14),
(344, 207, 5),
(345, 207, 14),
(346, 208, 5),
(347, 208, 14),
(348, 209, 14),
(349, 209, 5),
(350, 210, 14),
(351, 210, 5),
(352, 211, 7),
(353, 211, 8),
(354, 212, 8),
(355, 212, 7),
(356, 215, 8),
(357, 215, 7),
(358, 216, 8),
(359, 216, 7),
(360, 216, 20),
(361, 217, 8),
(362, 217, 7),
(363, 217, 21),
(364, 218, 8),
(365, 218, 7),
(366, 218, 21),
(367, 219, 8),
(368, 219, 7),
(369, 219, 21),
(370, 220, 8),
(371, 220, 7),
(372, 220, 20),
(373, 15, 11),
(374, 150, 11),
(375, 222, 11),
(376, 222, 19),
(377, 222, 16),
(378, 222, 15),
(379, 223, 21),
(380, 223, 8),
(381, 223, 11),
(382, 223, 15),
(383, 80, 32),
(384, 224, 32),
(385, 224, 33),
(386, 224, 20),
(387, 224, 24),
(388, 225, 32),
(390, 225, 20),
(391, 225, 24),
(392, 80, 33),
(393, 80, 20),
(394, 80, 24),
(395, 226, 33),
(396, 226, 24),
(397, 226, 32),
(398, 226, 20),
(399, 206, 30),
(400, 207, 30),
(401, 208, 30),
(402, 209, 30),
(403, 210, 30),
(404, 227, 30),
(405, 227, 34),
(406, 228, 34),
(409, 229, 34),
(410, 230, 34),
(411, 231, 34),
(412, 232, 34),
(413, 233, 34),
(414, 234, 34),
(415, 235, 37),
(416, 236, 36),
(417, 237, 36),
(418, 238, 36),
(419, 239, 38),
(420, 239, 44),
(421, 240, 44),
(422, 240, 38),
(423, 241, 44),
(424, 241, 38),
(425, 94, 43),
(426, 94, 42),
(427, 95, 42),
(428, 95, 43),
(429, 96, 43),
(430, 96, 42),
(431, 196, 45),
(432, 196, 40),
(433, 242, 45),
(434, 243, 45),
(435, 244, 45),
(436, 39, 27),
(437, 40, 27),
(438, 52, 48),
(439, 53, 48),
(440, 245, 45),
(441, 245, 50),
(442, 247, 50),
(443, 247, 51),
(444, 247, 49),
(445, 247, 46),
(446, 248, 49),
(447, 248, 39),
(448, 249, 43),
(449, 249, 39),
(450, 251, 29),
(451, 251, 33),
(454, 82, 29),
(456, 83, 29),
(457, 83, 28),
(458, 79, 28),
(459, 252, 46),
(460, 252, 41),
(461, 253, 44),
(462, 253, 41),
(463, 254, 41),
(464, 254, 46),
(465, 255, 46),
(466, 255, 48),
(467, 255, 41),
(468, 256, 53),
(469, 257, 53),
(470, 258, 53),
(471, 259, 53),
(474, 263, 54),
(475, 262, 54),
(476, 264, 54),
(477, 267, 54),
(478, 268, 54),
(479, 271, 54),
(480, 272, 54),
(481, 273, 54),
(482, 273, 54),
(484, 275, 55),
(485, 276, 55),
(488, 277, 55),
(489, 279, 55),
(490, 280, 56),
(491, 281, 57),
(492, 282, 57),
(493, 283, 57),
(494, 284, 57),
(499, 288, 58),
(500, 289, 58),
(501, 285, 58),
(502, 287, 58),
(503, 290, 59),
(504, 291, 59),
(507, 292, 59),
(508, 293, 59),
(509, 294, 61);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `id` int(10) NOT NULL,
  `order_detail_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `content` text NOT NULL,
  `star` int(10) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `reviews`
--

INSERT INTO `reviews` (`id`, `order_detail_id`, `user_id`, `content`, `star`, `create_date`, `status`) VALUES
(74, 108, 27, 'zxczx', 5, '2025-04-19 13:25:37', 1),
(75, 112, 27, 'sản phẩm rất đẹp', 5, '2025-04-19 13:37:36', 1),
(109, 124, 27, 'Sản phẩm đẹp quá shop ơi <3 <3', 5, '2025-04-22 22:50:50', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `type_cate`
--

CREATE TABLE `type_cate` (
  `id` int(10) NOT NULL,
  `characteristic_id` int(10) NOT NULL,
  `name` varchar(250) NOT NULL,
  `image` varchar(250) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `content` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `type_cate`
--

INSERT INTO `type_cate` (`id`, `characteristic_id`, `name`, `image`, `create_at`, `content`) VALUES
(3, 10, 'Cây cao & lớn', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-cao-lon-trong-nha.jpg', '2025-03-06 13:23:49', 'Nếu muốn tạo hiệu ứng không gian trải rộng hãy thử đặt một chậu cây cảnh cao và lớn tại góc tường. Với chiều cao của mình, cây cảnh sẽ thu hút mọi ánh nhìn vào đường thẳng kiến trúc.'),
(4, 10, 'Cây cảnh mini', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-canh-trong-trong-nha.jpg', '2025-03-06 13:23:49', 'Giúp cho ngôi nhà của bạn thêm tươi mới và xanh với những sản phẩm cây trong nhà của MOW Garden. Thật tuyệt vời mang đến cho bạn những phút giây thư giãn bên canh nhữngsản phẩm cây xanh chất lượng.'),
(5, 10, 'Cây treo trong nhà', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-canh-treo-trong-nha.jpg', '2025-03-06 13:41:11', 'Treo thêm vài chậu cây cảnh trong nhà là một ý tưởng rất tuyệt vời để bạn phủ xanh không gian sống của mình. Bạn có thể đặt mua cây cảnh treo trong nhà chất lượng tại MOW Garden.'),
(7, 10, 'Cây Nhiệt đới', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-nhiet-doi-cata.jpg', '2025-03-06 13:43:39', 'Thật tuyệt vời khi được sống giữa một khu rừng trong lành. Với mong muốn gần gũi với thiên nhiên thì việc phối những loại cây xanh vùng nhiệt đới sẽ giúp tô điểm thêm cho ngôi nhà của bạn.'),
(8, 10, '\r\nCây kiểng lá', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-kieng-la.jpg', '2025-03-06 13:43:39', 'Với vẻ đẹp tuyệt vời từ những cái cây kiểng lá giống như liều thuốc hữu hiệu cho chứng \"đâu đầu\" mỗi khi làm việc căng thẳng. Ngoài giá trị về mặt tinh thần thì kiểng lá là một sự lựa chọn rất tuyệt vời giúp gia tăng thẩm mỹ cho không gian sống.'),
(9, 11, 'Cây Để Bàn', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-canh-de-ban.jpg', '2025-03-06 13:45:22', 'Đặt thêm một chậu cây để bàn làm việc giúp mang lại cảm giác thoải mái, giảm áp lực, stress nên có thể chữa được bệnh trầm cảm.'),
(10, 11, 'Cây văn phòng', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-canh-van-phong.jpg', '2025-03-06 13:45:22', 'Việc trồng thêm cây xanh trong văn phòng là một cách bảo vệ sức khỏe thiết thực, bởi môi trường văn phòng thường kín và tồn tại nhiều chất khí độc hại. Hãy cùng MOW Garden xây dựng một môi trường làm việc lành mạnh để công việc luôn được thuận lợi.'),
(11, 11, 'Cây Xanh Nhà bếp & phòng tắm', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-canh-trong-phong-bep.jpg', '2025-03-06 13:48:21', 'Với sắc xanh từ cây, không gian bí bức và nóng nực của những gian bếp như được làm dịu mát lại. Đây cũng là một giai pháp khử mùi và thanh lọc không khí rất hiệu quả, hơn nữa cây xanh còn giúp tăng tính thẩm mỹ cho khu vực bếp và phòng ăn'),
(12, 11, '\r\nCây Trước Cửa & Hành Lang', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-trang-tri-nha-cua.jpg', '2025-03-06 13:48:21', 'Khu vực ban công tuy không rộng nhưng nó vẫn có thể biến thành một khu vườn của riêng bạn. Thật tuyệt vời khi được thưởng thức một ly trà, ăn miếng bánh và đọc cuốn sách yêu thích, tại khu vườn nhỏ xanh mát này, sau một ngày làm việc mệt mỏi.'),
(14, 11, '\r\nCây Trồng Ban công', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-trong-ban-cong.jpg', '2025-03-06 13:50:00', 'Khu vực ban công tuy không rộng nhưng nó vẫn có thể biến thành một khu vườn của riêng bạn. Thật tuyệt vời khi được thưởng thức một ly trà, ăn miếng bánh và đọc cuốn sách yêu thích, tại khu vườn nhỏ xanh mát này, sau một ngày làm việc mệt mỏi.'),
(15, 12, 'Cây Lọc Không Khí', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-loc-khong-khi.jpg', '2025-03-06 13:51:15', 'Khả năng hấp thụ các loại chất khí độc hại có trong không khí của cây xanh sẽ giúp bầu không khí trong nhà trở nên trong lành và an toàn hơn, giúp bảo vệ sức khỏe của các thành viên trong gia đình. Những loại chất khí độc hại như benzene, formaldehyd'),
(16, 12, '\nCây Dễ Chăm', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-de-trong-trong-nha.jpg', '2025-03-06 13:51:15', 'Đa phần các loại cây trồng được trong nhà đều thuộc loại dễ chăm sóc. Nếu như bạn không có nhiều thời gian thì hãy lựa chọn các loại cây có sức sống tốt, chúng có thể chịu được hạn, cần ít ánh sáng và không cần phải bón phân thường xuyên.'),
(17, 12, 'Cây cần ít ánh sáng', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-can-it-anh-sang.jpg', '2025-03-06 13:52:53', 'Đa phần các loài thực vật trong tự nhiên đều cần tới ánh sáng để chúng quang hợp, một số thì cần nhiều, và cũng có một số cần rất ít ánh sáng. Chúng ta lựa chọn các loại cây cần ít ánh sáng vì khi đặt trong nhà thì nguồn sáng sẽ bị hạn chế, không như'),
(18, 12, 'Cây thủy sinh', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-thuy-sinh.jpg', '2025-03-06 13:52:53', 'Dạng cây thủy sinh vốn được trồng trong nước nên sẽ chẳng cần phải tưới thường xuyên, và nó sẽ giúp bạn tiết kiệm thời gian rất nhiều. Đặt một vài chậu cây cảnh thủy sinh trên bàn làm việc để giúp bạn cải thiện tâm trạng, cũng như giúp thanh lọc khôn'),
(19, 12, 'Cây Phong Thủy', 'https://mowgarden.com/wp-content/uploads/2023/04/cay-phong-thuy-de-trong-nha.jpg', '2025-03-06 13:53:48', 'Cây xanh luôn có vai trò quan trọng đối với đời sống hàng ngày. Do đó, việc lựa chọn loại cây và vị trí trồng được chú trọng và lựa chọn cẩn thận theo những quy luật của thuật phong thủy. Cây xanh được chia thành âm dương và ngũ hành, tùy vào mỗi gia'),
(20, 13, 'Cây Tầm Trung', '', '2025-03-06 14:03:12', 'Cây tầm trung – Sự lựa chọn hoàn hảo cho không gian của bạn.'),
(21, 13, 'Cây Tầm Thấp', '', '2025-03-06 14:03:12', 'Cây tầm thấp – Mang thiên nhiên gần gũi từng góc nhỏ.'),
(24, 13, 'Tán Hình Tròn', 'https://media.loveitopcdn.com/17260/cach-bo-tri-cay-ngau-tan-tron-trong-canh-quan-1.jpg', '2025-03-06 14:07:47', 'Cây tán tròn – Vẻ đẹp cân đối cho mọi không gian.'),
(25, 13, 'Tán Hình Tháp', '', '2025-03-06 14:07:47', '\"Cây tán tháp – Sự kết hợp hoàn hảo giữa thiên nhiên và thiết kế.\"'),
(27, 14, 'Cây Thường Xanh', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-thuong-xanh.jpg', '2025-03-06 14:08:44', '\"Cây thường xanh – Tự nhiên bền vững, không gian mãi xanh.\"'),
(28, 14, 'Cây Lá Màu', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-la-mau.jpg', '2025-03-06 14:08:44', '\"Cây lá màu – Tạo điểm nhấn đầy màu sắc cho không gian.\"'),
(29, 14, 'Cây Dạng Bụi', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-dang-bui.jpg', '2025-03-06 14:09:19', '\"Cây dạng bụi – Đơn giản, tinh tế, làm đẹp không gian.\"'),
(30, 14, 'Cây Leo Dàn', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-leo-gian.jpg', '2025-03-06 14:09:19', '\"Cây leo dàn – Tạo nên không gian xanh mát, sống động.\"'),
(31, 14, 'Cây Thân Đốt', 'https://mowgarden.com/wp-content/uploads/2021/07/dl.beatsnoop.com-1625893917.jpg', '2025-03-06 14:09:38', '\"Cây thân đốt – Từ đất, vươn lên những tầm cao mới.\"'),
(32, 15, 'Cây Bóng Mát', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-bong-mat.jpg', '2025-03-06 14:09:53', '\"Cây bóng mát – Nơi thư giãn dưới bóng xanh tươi.\"'),
(33, 15, 'Cây Có Hoa', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-co-hoa-1.jpg', '2025-03-06 14:09:53', '\"Cây có hoa – Mang hương sắc thiên nhiên vào nhà.\"'),
(34, 15, 'Cây Ăn Quả', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-an-trai.jpg', '2025-03-06 14:10:26', '\"Cây ăn quả – Lợi ích xanh cho cuộc sống thêm ngọt ngào.\"'),
(35, 15, 'Cây Hàng Rào', 'https://mowgarden.com/wp-content/uploads/2021/07/dl.beatsnoop.jpg', '2025-03-06 14:10:26', '\"Cây hàng rào – Sự kết hợp hoàn hảo giữa bảo vệ và trang trí.\"'),
(36, 15, 'Cây Che Phủ Nền', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-cay-trong-vien.jpg', '2025-03-06 14:10:53', '\"Cây phủ nền – Lấp đầy khoảng trống, tỏa sáng thiên nhiên.\"'),
(37, 15, 'Cỏ Nền', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-co-phu-nen.jpg', '2025-03-06 14:10:53', '\"Cỏ nền – Mang thiên nhiên gần gũi đến từng bước chân.\"'),
(38, 16, 'Chậu Hình Vuông', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-cay-vuong.jpg', '2025-03-06 14:11:24', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(39, 16, 'Chậu Chữ Nhật', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-hinh-chu-nhat.jpg', '2025-03-06 14:11:24', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(40, 16, 'Hình tròn Bầu', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-tron-bau.jpg', '2025-03-06 14:12:07', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(41, 16, 'Trụ Tròn Đứng', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-cay-tru-dung.jpg', '2025-03-06 14:12:07', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(42, 16, 'Chậu Treo', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-treo.jpg', '2025-03-06 14:12:53', 'Treo thêm vài chậu cây cảnh trong nhà là một ý tưởng rất tuyệt vời để bạn phủ xanh không gian sống của mình.'),
(43, 17, 'Chậu Nhựa', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-nhua.jpg', '2025-03-06 14:13:22', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(44, 17, 'Chậu Xi Măng', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-xi-mang.jpg', '2025-03-06 14:13:22', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(45, 17, 'Chậu Đất Nung', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-dat-nung.jpg', '2025-03-06 14:13:56', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(46, 17, 'Chậu Gốm Sứ', 'https://cayvahoa.net/wp-content/uploads/chau-gom-su-bat-trang-1-1024x576.jpg', '2025-03-06 14:13:56', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua. '),
(48, 18, 'Nhỏ Để Bàn', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-nho-de-ban.jpg', '2025-03-06 14:14:27', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(49, 18, 'Chậu Cỡ Trung', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-tam-trung.jpg', '2025-03-06 14:14:27', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(50, 18, 'Chậu Cỡ Lớn', 'https://mowgarden.com/wp-content/uploads/2021/07/danh-muc-chau-tam-trung.jpg', '2025-03-06 14:15:25', ''),
(51, 18, 'Chậu Dáng Cao', 'https://nhaxinhplaza.vn/wp-content/uploads/chau-cao-trong-cay-gi.jpeg', '2025-03-06 14:15:25', 'Được ngồi cùng với nhau trò chuyện dưới những tán cây xanh mát, xung quanh là hoa cỏ thơm ngát, có làn gió nhẹ nhàng thoáng qua.'),
(53, 19, 'Dụng cụ cắt cành', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 04:26:59', 'Kéo cắt cành là một dụng cụ quan trọng trong công việc làm vườn, chăm sóc cây cối, đặc biệt là trong việc tỉa cây, cắt cành, tạo hình cho cây bonsai, hoặc xử lý các cành cây bị hư hại.'),
(54, 19, 'Cuốc-Xẻng-Bay-Cào', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 04:27:27', 'Cuốc, xẻng, bay và cào là các dụng cụ phổ biến trong nông nghiệp, làm vườn, xây dựng và nhiều công việc khác liên quan đến đất đai. Mỗi loại dụng cụ có chức năng và đặc điểm riêng, phục vụ cho từng mục đích công việc cụ thể.'),
(55, 19, 'Dụng cụ bonsai', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 04:28:14', 'Dụng cụ bonsai là những công cụ chuyên dụng được sử dụng để chăm sóc và tạo hình cho cây bonsai. Các dụng cụ này giúp người chơi bonsai có thể cắt tỉa, uốn nắn, chăm sóc và duy trì sức khỏe cho cây một cách chính xác và hiệu quả.'),
(56, 19, 'Dụng cụ hái quả', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 04:29:49', 'Hái quả không chỉ là một công việc đơn giản mà còn đòi hỏi kỹ thuật và sự chú ý đến từng chi tiết để bảo vệ chất lượng của sản phẩm thu hoạch.'),
(57, 20, 'Cần xịt-vòi tưới', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 04:32:53', 'Vòi xịt tưới cây là một công cụ hữu ích trong việc chăm sóc cây cối, giúp bạn dễ dàng kiểm soát lượng nước tưới cho cây mà không gây hư hại cho đất hay cây trồng.'),
(58, 20, 'Bình xịt tưới', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 04:34:10', 'Bình xịt tưới cây thường được sử dụng để cung cấp nước cho cây trồng một cách nhẹ nhàng, giúp cây phát triển khỏe mạnh và tránh bị ngập úng.'),
(59, 20, 'Béc tưới', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 04:34:30', 'Béc tưới (hay còn gọi là đầu béc tưới cây) là một thiết bị dùng để phân phối nước một cách đều đặn cho cây trồng, giúp duy trì độ ẩm cho đất và cây mà không làm hư hại hoặc ngập úng cây.'),
(61, 22, 'Phân bón', 'https://www.tuvsud.com/-/media/global/images/industries/consumer-products-and-retail/adobestock_272226603-min.jpg?h=1436&w=3248&la=vi-VN&hash=0BF638E53C30D77EC2C96C56B9DD8DCB', '2025-04-05 07:05:53', 'Phân bón là một yếu tố quan trọng trong việc chăm sóc cây trồng, cung cấp các dưỡng chất thiết yếu để cây phát triển khỏe mạnh, cho năng suất cao và cải thiện chất lượng đất.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` int(10) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `phone` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `address` varchar(150) NOT NULL,
  `quantity_pr_buy` int(10) NOT NULL,
  `total_buy` int(10) NOT NULL,
  `avatar` varchar(250) NOT NULL DEFAULT '/images/user_circle.webp',
  `level` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 la đồng, 1 là bạc, 2 là vàng, 3 là kim cương\r\n',
  `role` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0 la admin, 1 la user',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 la binh thuong 2 la khoa',
  `create_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `phone`, `email`, `address`, `quantity_pr_buy`, `total_buy`, `avatar`, `level`, `role`, `status`, `create_date`) VALUES
(2, 'test', '$2b$10$EsoR3GvdxnMOB98XRbEwGesL.Jfq1Lid3gGrsGFwzXG5EHXW1uJgG', 123213, 'test@gmail.com', '', 4, 570000, '/images/user_circle.webp	', 0, 1, 1, '0000-00-00 00:00:00'),
(8, 'dang', '$2b$10$P/jsc83n91UtCTzJH3PBo.6p7L.PKWZDl/8dlNJXBKGprs5YZOn4a', 213123213, 'dangpdhps28240@fpt.edu.vn', '', 0, 0, '/images/user_circle.webp', 0, 1, 1, '0000-00-00 00:00:00'),
(21, 'admin', '$2b$10$xXxJUi7OdqAT8whodxsS3eEHVj1JA47oWTAF73HeAKBoTLTp6ujxi', 364185395, 'admin@gmail.com', '', 0, 0, 'http://localhost:3000/public/images/04-2025_Screenshot 2025-01-13 193119.png', 0, 0, 1, '2025-04-09 13:58:50'),
(27, 'vuongadmin123', '$2b$10$ZkJiIdPkwoIaddN8yU2O0eC4UOztJF1qPPdYvEA88aJzBjL7VyN9O', 364185395, 'vuongweb04@gmail.com', '135 Dông Bắc', 25, 13894000, 'http://localhost:3000/public/images/04-2025_Screenshot 2025-02-06 192448.png', 3, 1, 1, '2025-04-18 12:39:09'),
(29, 'Tran Ba Ho', '$2b$10$8IOFPIY/I3xn.Wmo.mgwiO3GYO5aSR3ouT0UnkxCAI1ws42Q4QRGi', 364185395, 'tranbaho@gmail.com', '13 CÔng viên phần mền quang trung', 3, 668000, '/images/user_circle.webp', 0, 1, 1, '2025-04-23 20:45:22'),
(30, 'Lê Nguyễn Hoàng Oanh', '$2b$10$vFjgh0AJx5gik3c6HY73cunqhu8zzLogR9iyPUYcejuBGSSCJinQa', 987234631, 'oanhle150896@gmail.com', '80 Hoàng Hoa Thám F13, Tân Bình', 8, 5813000, '/images/user_circle.webp', 0, 1, 1, '2025-04-23 21:00:00'),
(31, 'Đinh Hữu Huy', '$2b$10$A0bshrzBmapQIcSAXFVB2.6qQvpXmgzRGYUdkI8kIIQLE9Cx7T80u', 902486301, 'huyrealdepzai199x@gmail.com', 'Đường số `17, An Lạc A', 8, 2995000, '/images/user_circle.webp', 0, 1, 1, '2025-04-23 21:24:08'),
(32, 'Nguyễn Phan Yến Nhi', '$2b$10$yRCZ9hFdUDViFkIr8nZV5.OyPdqTBBJy4k8iDzL2gTfqIKoTryk7S', 909234123, 'binhe2k1@gmail.com', '415 Tên Lửa, Bình tân', 10, 2863000, '/images/user_circle.webp', 0, 1, 1, '2025-04-23 21:57:48'),
(33, 'Nguyễn Đức Thuận', '$2b$10$RvSBq4NMyhAxEJACbWl3xuPi6M01q4KMVvSqv5if8aFx6VCUywXGC', 973245126, 'thuanhoclom123@gmail.com', '78, Hoa Lan, Phú nhuận', 12, 6082000, '/images/user_circle.webp', 0, 1, 1, '2025-04-24 07:49:43'),
(34, 'Phạm Nguyên Ngọc', '$2b$10$V0CADhzqL66CatUPJYfF6Oc.r.OeoqXD/xcst/TbprAZovoON0VBW', 945123234, 'nocnoc123@gmail.com', '123, An Dương Vương, Q8', 20, 35111000, '/images/user_circle.webp', 0, 1, 1, '2025-04-24 08:08:02'),
(35, 'Vương Quỳnh Giang', '$2b$10$zZRBVbaX89fBD9KvU6OXgOF7qh2rvVZgmw/natrobararl80pCI7W', 987123678, 'gianggiang2k1@gmail.com', '113, Tân Hải, f13, tân bình', 14, 9884000, '/images/user_circle.webp', 0, 1, 1, '2025-04-24 08:39:01'),
(36, 'Bùi Minh Trung', '$2b$10$0g57wVr500ZPrzlpT1hh1ubE1b/MQPgIhpZiCmgVzICeYTnFFbFf6', 912345672, 'trungtete2123@gmail.com', '390 Kinh Dương Vương, An Lạc', 20, 11155000, '/images/user_circle.webp', 0, 1, 1, '2025-04-24 10:42:17'),
(37, 'Lê Trần Hồng Nhi', '$2b$10$hMt1pOBz5DhP1Ev54n//s.ZuKfw07p6P7hYnyjdsuG/jLj6zzFx9m', 945389987, 'hongnhi123@gmail.com', 'An Phú Đông, Q12', 15, 24044000, '/images/user_circle.webp', 3, 1, 1, '2025-04-24 11:03:48'),
(38, 'Nguyễn Hoàng Quyên', '$2b$10$tJhQL29BdtydUj1e0Y7XTOlrQodH7HsmSCy.rZmjEQ3DcxXWeuzIG', 976565623, 'quinquin24@gmail.com', 'Nguyễn Kiệm, F3, Phú nhuận', 22, 7370000, '/images/user_circle.webp', 0, 1, 1, '2025-04-24 11:22:25'),
(39, 'Trần Duy Hòa', '$2b$10$oel3o6WWe3lVdXoWKChw7uDWxVmQ.CkoF8HenYk6QjIj8OabNJ5Ku', 937673345, 'vinhan5504@gmail.com', 'ấp 17, Long trung, Cai lậy, Tiền Giang', 31, 13065000, '/images/user_circle.webp', 0, 1, 1, '2025-04-24 11:42:24'),
(40, 'Trần Huy Bình', '$2b$10$Sg04.ip5ieU.3VOgrf7/J.Cd1bHaFPocfTemyDOVw.0pgG73idbqG', 938761216, 'binhtran28@gmail.com', 'Vĩnh Kim, Châu Thành, Tiền Giang', 23, 21140000, '/images/user_circle.webp', 0, 1, 1, '2025-04-24 11:58:59');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `voucher`
--

CREATE TABLE `voucher` (
  `id` int(10) NOT NULL,
  `code` varchar(150) NOT NULL,
  `discount_type` enum('fixed','percent') NOT NULL,
  `discount_value` int(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` datetime NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 la họat dộng',
  `create_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `voucher`
--

INSERT INTO `voucher` (`id`, `code`, `discount_type`, `discount_value`, `start_date`, `end_date`, `quantity`, `status`, `create_date`) VALUES
(1, 'mienphiship', 'fixed', 50000, '2025-03-31', '2025-04-30 15:41:48', 101, 1, '2025-03-31 10:41:48'),
(2, 'giam15%', 'percent', 15, '2025-03-31', '2025-04-16 19:22:27', 100, 1, '2025-03-31 14:22:27'),
(3, 'czxczx', 'percent', 10, '0000-00-00', '2025-04-24 17:00:00', 2, 1, '0000-00-00 00:00:00');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `cate`
--
ALTER TABLE `cate`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `characteristic`
--
ALTER TABLE `characteristic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cate_id` (`cate_id`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `voucher_id` (`voucher_id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `pr_id` (`pr_id`);

--
-- Chỉ mục cho bảng `otp_codes`
--
ALTER TABLE `otp_codes`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cate_id` (`cate_id`);

--
-- Chỉ mục cho bảng `products_favorite`
--
ALTER TABLE `products_favorite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_favorite_ibfk_1` (`pr_id`),
  ADD KEY `products_favorite_ibfk_2` (`user_id`);

--
-- Chỉ mục cho bảng `product_type_cate`
--
ALTER TABLE `product_type_cate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pr_id` (`pr_id`),
  ADD KEY `type_cate_id` (`type_cate_id`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_detail_id` (`order_detail_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `type_cate`
--
ALTER TABLE `type_cate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `characteristic_id` (`characteristic_id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `banner`
--
ALTER TABLE `banner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `cate`
--
ALTER TABLE `cate`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `characteristic`
--
ALTER TABLE `characteristic`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

--
-- AUTO_INCREMENT cho bảng `otp_codes`
--
ALTER TABLE `otp_codes`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=309;

--
-- AUTO_INCREMENT cho bảng `products_favorite`
--
ALTER TABLE `products_favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT cho bảng `product_type_cate`
--
ALTER TABLE `product_type_cate`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=542;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT cho bảng `type_cate`
--
ALTER TABLE `type_cate`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT cho bảng `voucher`
--
ALTER TABLE `voucher`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `characteristic`
--
ALTER TABLE `characteristic`
  ADD CONSTRAINT `characteristic_ibfk_1` FOREIGN KEY (`cate_id`) REFERENCES `cate` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`id`);

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`pr_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `order_detail_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`cate_id`) REFERENCES `cate` (`id`);

--
-- Các ràng buộc cho bảng `products_favorite`
--
ALTER TABLE `products_favorite`
  ADD CONSTRAINT `products_favorite_ibfk_1` FOREIGN KEY (`pr_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_favorite_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `product_type_cate`
--
ALTER TABLE `product_type_cate`
  ADD CONSTRAINT `product_type_cate_ibfk_1` FOREIGN KEY (`pr_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_type_cate_ibfk_2` FOREIGN KEY (`type_cate_id`) REFERENCES `type_cate` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`id`),
  ADD CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `type_cate`
--
ALTER TABLE `type_cate`
  ADD CONSTRAINT `type_cate_ibfk_1` FOREIGN KEY (`characteristic_id`) REFERENCES `characteristic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
