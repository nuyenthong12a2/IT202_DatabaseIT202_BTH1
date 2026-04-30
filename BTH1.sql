-- 1. Tạo bảng movies (Thông tin phim)
CREATE TABLE IF NOT EXISTS movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT NOT NULL,
    age_restriction INT DEFAULT 0 CHECK (age_restriction IN (0, 13, 16, 18))
);

-- 2. Tạo bảng rooms (Phòng chiếu)
CREATE TABLE IF NOT EXISTS rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    max_seats INT NOT NULL,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'maintenance'))
);

-- 3. Tạo bảng showtimes (Suất chiếu)
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