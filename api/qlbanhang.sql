-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th2 01, 2026 lúc 10:11 AM
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
-- Cơ sở dữ liệu: `qlbanhang`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Đồ uống'),
(2, 'Thực phẩm'),
(3, 'Gia dụng');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `import_orders`
--

CREATE TABLE `import_orders` (
  `import_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `import_date` datetime DEFAULT current_timestamp(),
  `total_amount` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `import_orders`
--

INSERT INTO `import_orders` (`import_id`, `supplier_id`, `user_id`, `import_date`, `total_amount`) VALUES
(1, 1, 1, '2026-02-01 08:15:16', 3000000.00),
(2, 2, 2, '2026-02-01 08:15:16', 1500000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `import_order_details`
--

CREATE TABLE `import_order_details` (
  `import_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `import_price` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `import_order_details`
--

INSERT INTO `import_order_details` (`import_id`, `product_id`, `quantity`, `import_price`) VALUES
(1, 1, 100, 8000.00),
(1, 2, 80, 7000.00),
(2, 3, 200, 3500.00),
(2, 4, 50, 20000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `promotion_id` int(11) DEFAULT NULL,
  `invoice_date` datetime DEFAULT current_timestamp(),
  `total_amount` decimal(12,2) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `final_amount` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `user_id`, `promotion_id`, `invoice_date`, `total_amount`, `discount_amount`, `final_amount`) VALUES
(1, 2, 1, '2026-02-01 08:15:16', 200000.00, 20000.00, 180000.00),
(2, 3, NULL, '2026-02-01 08:15:16', 150000.00, 0.00, 150000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoice_details`
--

CREATE TABLE `invoice_details` (
  `invoice_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoice_details`
--

INSERT INTO `invoice_details` (`invoice_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 5, 10000.00),
(1, 3, 10, 4500.00),
(2, 2, 5, 9000.00),
(2, 4, 3, 25000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_date` datetime DEFAULT current_timestamp(),
  `amount` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payments`
--

INSERT INTO `payments` (`payment_id`, `invoice_id`, `payment_method`, `payment_date`, `amount`) VALUES
(1, 1, 'Tiền mặt', '2026-02-01 08:15:16', 180000.00),
(2, 2, 'Chuyển khoản', '2026-02-01 08:15:16', 150000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `description` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category_id`, `price`, `stock`, `description`, `status`) VALUES
(1, 'Coca Cola', 1, 10000.00, 100, 'Nước ngọt Coca', 1),
(2, 'Pepsi', 1, 9000.00, 80, 'Nước ngọt Pepsi', 1),
(3, 'Mì Hảo Hảo', 2, 4500.00, 200, 'Mì ăn liền', 1),
(4, 'Gạo ST25', 2, 25000.00, 50, 'Gạo thơm', 1),
(5, 'Nồi cơm điện', 3, 650000.00, 20, 'Nồi cơm 1.8L', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `promotions`
--

CREATE TABLE `promotions` (
  `promotion_id` int(11) NOT NULL,
  `promotion_name` varchar(100) DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `promotions`
--

INSERT INTO `promotions` (`promotion_id`, `promotion_name`, `discount_percent`, `start_date`, `end_date`) VALUES
(1, 'Khuyến mãi Tết', 10, '2026-01-01', '2026-01-31'),
(2, 'Giảm giá cuối tuần', 5, '2026-01-01', '2026-12-31');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(1, 'Admin'),
(2, 'Nhân viên');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `phone`, `address`) VALUES
(1, 'Công ty Nước Giải Khát', '090111222', 'TP HCM'),
(2, 'Công ty Thực Phẩm Việt', '090333444', 'Hà Nội'),
(3, 'Công ty Gia Dụng ABC', '090555666', 'Đà Nẵng');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `full_name`, `role_id`, `status`, `created_at`) VALUES
(1, 'admin', '123456', 'Quản trị hệ thống', 1, 1, '2026-02-01 01:15:16'),
(2, 'nv01', '123456', 'Nguyễn Văn A', 2, 1, '2026-02-01 01:15:16'),
(3, 'nv02', '123456', 'Trần Thị Nở', 2, 1, '2026-02-01 01:15:16'),
(7, 'dsa', '$2y$10$GkQpdz6Jcnk6oaAUa.w36uoJLVeOYcFOYnmrNHmp0Hq/ptSscQlUy', 'dasd', 2, 1, '2026-02-01 07:53:36'),
(8, 'das', '$2y$10$ZTaYYvgSMXXBU4xR33d3LumAsLWS4cK3Nf2bjN0HPtjm.zMXxeaYG', 'das', 2, 1, '2026-02-01 07:53:41'),
(9, 'dasd', '$2y$10$hwdF377ShKJsAzLbwctbz.orWjIc20omHTXGCuZ.HlQCu4NjvPdM2', 'sada', 2, 1, '2026-02-01 07:53:50');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `import_orders`
--
ALTER TABLE `import_orders`
  ADD PRIMARY KEY (`import_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `import_order_details`
--
ALTER TABLE `import_order_details`
  ADD PRIMARY KEY (`import_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `promotion_id` (`promotion_id`);

--
-- Chỉ mục cho bảng `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD PRIMARY KEY (`invoice_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`promotion_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Chỉ mục cho bảng `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `import_orders`
--
ALTER TABLE `import_orders`
  MODIFY `import_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `promotions`
--
ALTER TABLE `promotions`
  MODIFY `promotion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `import_orders`
--
ALTER TABLE `import_orders`
  ADD CONSTRAINT `import_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `import_orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `import_order_details`
--
ALTER TABLE `import_order_details`
  ADD CONSTRAINT `import_order_details_ibfk_1` FOREIGN KEY (`import_id`) REFERENCES `import_orders` (`import_id`),
  ADD CONSTRAINT `import_order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Các ràng buộc cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`);

--
-- Các ràng buộc cho bảng `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD CONSTRAINT `invoice_details_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`),
  ADD CONSTRAINT `invoice_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Các ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
