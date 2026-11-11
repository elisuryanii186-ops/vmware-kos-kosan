-- Database: koskosan_db
CREATE DATABASE IF NOT EXISTS koskosan_db;
USE koskosan_db;

-- Tabel Users (Admin)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin') DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Kamar
CREATE TABLE IF NOT EXISTS kamar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kamar VARCHAR(100) NOT NULL,
    tipe ENUM('Single', 'Double', 'VIP') NOT NULL,
    harga_per_bulan DECIMAL(10, 2) NOT NULL,
    fasilitas TEXT,
    status ENUM('Tersedia', 'Terisi', 'Maintenance') DEFAULT 'Tersedia',
    foto_url VARCHAR(255) DEFAULT '/images/kamar-default.jpg',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Pemesanan
CREATE TABLE IF NOT EXISTS pemesanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_kamar INT NOT NULL,
    nama_pemesan VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    no_telepon VARCHAR(20) NOT NULL,
    tanggal_mulai DATE NOT NULL,
    durasi_bulan INT NOT NULL,
    catatan TEXT,
    status ENUM('Pending', 'Disetujui', 'Ditolak') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_kamar) REFERENCES kamar(id) ON DELETE CASCADE
);

-- Insert Admin Default
-- Password: admin123 (hashed dengan bcrypt)
INSERT INTO users (username, password, role) VALUES 
('admin', '$2b$10$8JKxE8qF4LqL0rZKp4F8LOyYhE.jFZhY3gZBjFqvPqHKGKjYqKF8e', 'admin');

-- Insert Data Dummy Kamar
INSERT INTO kamar (nama_kamar, tipe, harga_per_bulan, fasilitas, status, foto_url) VALUES
('Kamar A1', 'Single', 800000, 'Kasur, Lemari, AC, WiFi, Kamar Mandi Dalam', 'Tersedia', '/images/kamar-1.jpg'),
('Kamar A2', 'Single', 750000, 'Kasur, Lemari, Kipas Angin, WiFi, Kamar Mandi Luar', 'Tersedia', '/images/kamar-2.jpg'),
('Kamar B1', 'Double', 1200000, 'Kasur 2 Buah, Lemari, AC, WiFi, TV, Kamar Mandi Dalam', 'Tersedia', '/images/kamar-3.jpg'),
('Kamar B2', 'Double', 1100000, 'Kasur 2 Buah, Lemari, AC, WiFi, Kamar Mandi Dalam', 'Terisi', '/images/kamar-4.jpg'),
('Kamar VIP1', 'VIP', 2000000, 'Kasur King Size, AC 2 Unit, TV LED 43", WiFi, Kitchen Set, Kamar Mandi Dalam', 'Tersedia', '/images/kamar-vip.jpg'),
('Kamar A3', 'Single', 850000, 'Kasur, Lemari, AC, WiFi, Meja Belajar, Kamar Mandi Dalam', 'Tersedia', '/images/kamar-1.jpg'),
('Kamar B3', 'Double', 1300000, 'Kasur 2 Buah, Lemari Besar, AC, WiFi, TV, Balkon, Kamar Mandi Dalam', 'Maintenance', '/images/kamar-3.jpg'),
('Kamar A4', 'Single', 700000, 'Kasur, Lemari, Kipas Angin, WiFi', 'Tersedia', '/images/kamar-2.jpg');

-- Insert Data Dummy Pemesanan
INSERT INTO pemesanan (id_kamar, nama_pemesan, email, no_telepon, tanggal_mulai, durasi_bulan, catatan, status) VALUES
(1, 'Budi Santoso', 'budi@email.com', '081234567890', '2024-02-01', 6, 'Minta kamar lantai 2', 'Disetujui'),
(3, 'Siti Aminah', 'siti@email.com', '082345678901', '2024-02-15', 12, 'Perlu parkir motor', 'Pending'),
(5, 'Joko Widodo', 'joko@email.com', '083456789012', '2024-03-01', 3, 'Kontrak 3 bulan dulu', 'Pending');
