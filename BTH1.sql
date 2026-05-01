-- 1. Tạo bảng movies 
CREATE TABLE IF NOT EXISTS movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT NOT NULL,
    age_restriction INT DEFAULT 0 CHECK (age_restriction IN (0, 13, 16, 18))
);

-- 2. Tạo bảng rooms 
CREATE TABLE IF NOT EXISTS rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    max_seats INT NOT NULL,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'maintenance'))
);

-- 3. Tạo bảng showtimes 
CREATE TABLE IF NOT EXISTS showtimes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    room_id INT,
    show_time DATETIME NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL CHECK (ticket_price >= 0),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);

-- 4. Tạo bảng bookings (Đặt vé)
CREATE TABLE IF NOT EXISTS bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    showtime_id INT,
    customer_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (showtime_id) REFERENCES showtimes(id) ON DELETE CASCADE
);
-- Thêm 4 bộ phim 
INSERT INTO movies (title, duration_minutes, age_restriction) 
VALUES 
(N'Doraemon: Bản giao hưởng của Nobita', 115, 0),
(N'Heo 5 móng: Truyền thuyết Khmer', 138, 16),
(N'Deadpool & Wolverine', 125, 18), -- Phim giới hạn 18 tuổi
(N'Inside Out 2', 96, 0);
 -- Thêm 3 phòng chiếu 
INSERT INTO rooms (name, max_seats, status) 
VALUES 
(N'Phòng 01 - IMAX', 200, 'active'),
(N'Phòng 02 - Standard', 150, 'active'),
(N'Phòng 03 - Deluxe', 100, 'maintenance'); 
INSERT INTO showtimes (movie_id, room_id, show_time, ticket_price) 
VALUES 
(1, 1, '2026-05-20 09:00:00', 80000),  
(2, 2, '2026-05-20 14:00:00', 90000),  
(3, 1, '2026-05-20 19:30:00', 120000), 
(4, 2, '2026-05-20 21:00:00', 85000),  
(1, 2, '2026-05-21 10:30:00', 80000);  
INSERT INTO bookings (showtime_id, customer_name, phone) 
VALUES 
(1, N'Nguyễn Văn A', '0901234567'),
(1, N'Trần Thị B', '0902345678'),
(2, N'Lê Văn C', '0903456789'),
(3, N'Phạm Minh D', '0904567890'),
(3, N'Hoàng Lan E', '0905678901'),
(4, N'Đặng Văn F', '0906789012'),
(4, N'Bùi Thị G', '0907890123'),
(5, N'Vũ Hoàng H', '0908901234'),
(5, N'Ngô Tất I', '0909012345'),
(2, N'Lý Tiểu K', '0909123456');
 

