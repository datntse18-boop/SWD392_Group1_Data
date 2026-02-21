USE bike_marketplace;

-- ========================
-- INSERT BRANDS
-- ========================
INSERT INTO brands (brand_name) VALUES
('Trek'),
('Giant'),
('Cannondale'),
('Specialized'),
('Merida'),
('Twitter'),
('Trinx');

-- ========================
-- INSERT CATEGORIES
-- ========================
INSERT INTO categories (category_name) VALUES
('Road Bike'),
('Mountain Bike'),
('Hybrid Bike'),
('Gravel Bike');

-- ========================
-- INSERT USERS
-- ========================

-- Admin
INSERT INTO users (full_name, email, password, role_id)
VALUES ('System Admin', 'admin@bike.com', '123456', 1);

-- Sellers
INSERT INTO users (full_name, email, password, phone, address, role_id)
VALUES
('Nguyen Van Minh', 'minh.seller@gmail.com', '123456', '0901111222', 'Ho Chi Minh City', 3),
('Tran Duc Anh', 'anh.seller@gmail.com', '123456', '0902222333', 'Ha Noi', 3),
('Pham Quoc Huy', 'huy.seller@gmail.com', '123456', '0903333444', 'Da Nang', 3);

-- Buyers
INSERT INTO users (full_name, email, password, phone, address, role_id)
VALUES
('Le Thi Mai', 'mai.buyer@gmail.com', '123456', '0904444555', 'Ho Chi Minh City', 2),
('Hoang Gia Bao', 'bao.buyer@gmail.com', '123456', '0905555666', 'Ha Noi', 2),
('Vo Thanh Dat', 'dat.buyer@gmail.com', '123456', '0906666777', 'Can Tho', 2);

-- Inspector
INSERT INTO users (full_name, email, password, role_id)
VALUES ('Bike Inspector', 'inspector@bike.com', '123456', 4);

-- ========================
-- INSERT BIKES
-- ========================

INSERT INTO bikes
(seller_id, title, description, price, brand_id, category_id, frame_size, bike_condition, status)
VALUES
(2, 'Trek Domane AL 2 - 2022', 'Lightweight road bike, smooth shifting, well maintained.', 18500000, 1, 1, '54cm', 'USED_LIKE_NEW', 'APPROVED'),
(3, 'Giant Talon 1 MTB', 'Mountain bike, hydraulic brakes, excellent for trail.', 12500000, 2, 2, 'M', 'USED_GOOD', 'APPROVED'),
(4, 'Cannondale Topstone Gravel', 'Gravel bike, perfect for long-distance riding.', 22000000, 3, 4, '56cm', 'USED_LIKE_NEW', 'APPROVED');

-- ========================
-- INSERT BIKE IMAGES
-- ========================
INSERT INTO bike_images (bike_id, image_url) VALUES
(1, 'images/trek1.jpg'),
(1, 'images/trek2.jpg'),
(2, 'images/giant1.jpg'),
(3, 'images/cannondale1.jpg');

-- ========================
-- INSERT INSPECTION REPORT
-- ========================
INSERT INTO inspection_reports
(bike_id, inspector_id, frame_condition, brake_condition, drivetrain_condition, overall_comment, inspection_status)
VALUES
(1, 8, 'Frame in excellent condition, no cracks.',
 'Brakes responsive and smooth.',
 'Drivetrain clean and shifting perfectly.',
 'Bike is in near-new condition.',
 'APPROVED');

-- ========================
-- INSERT ORDERS
-- ========================
INSERT INTO orders
(bike_id, buyer_id, seller_id, total_amount, deposit_amount, status)
VALUES
(1, 5, 2, 18500000, 2000000, 'COMPLETED'),
(2, 6, 3, 12500000, 1000000, 'DEPOSITED');

-- ========================
-- INSERT REVIEWS
-- ========================
INSERT INTO reviews
(order_id, buyer_id, seller_id, rating, comment)
VALUES
(1, 5, 2, 5, 'Seller was very professional and bike matched description.');

-- ========================
-- INSERT WISHLIST
-- ========================
INSERT INTO wishlist (buyer_id, bike_id)
VALUES
(6, 3),
(7, 1);

-- ========================
-- INSERT MESSAGES
-- ========================
INSERT INTO messages
(sender_id, receiver_id, bike_id, content)
VALUES
(5, 2, 1, 'Is this bike still available?'),
(2, 5, 1, 'Yes, it is still available.');