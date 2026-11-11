# 🏠 Website Kos-Kosan

Aplikasi web sederhana untuk manajemen kos-kosan yang dibangun menggunakan **Node.js**, **Express**, **MySQL**, dan **Bootstrap 5**. Aplikasi ini dibuat untuk tugas kuliah Cloud Computing dan dapat dijalankan dalam kontainer Docker.

## 📋 Fitur Utama

### Halaman Publik
- **Landing Page**: Menampilkan daftar kamar kos dengan informasi lengkap
- **Filter & Pencarian**: Filter berdasarkan tipe kamar, status, dan pencarian nama/fasilitas
- **Detail Kamar**: Informasi lengkap setiap kamar beserta fasilitas
- **Formulir Booking**: Pengunjung dapat melakukan pemesanan kamar secara online

### Halaman Admin
- **Dashboard**: Statistik dan overview data kamar dan pemesanan
- **CRUD Kamar**: Tambah, Edit, Hapus, dan Ubah Status kamar
- **Manajemen Pemesanan**: Lihat, Setujui, atau Tolak pemesanan dari pengunjung
- **Autentikasi**: Login aman dengan bcrypt password hashing

## 🛠️ Tech Stack

- **Backend**: Node.js + Express.js
- **Database**: MySQL 8.0
- **Template Engine**: EJS (Embedded JavaScript)
- **Frontend**: Bootstrap 5 + Bootstrap Icons
- **Containerization**: Docker + Docker Compose
- **Session Management**: express-session
- **Password Security**: bcrypt

## 📁 Struktur Folder

```
Vmware_Kos-Kosan/
├── config/
│   └── database.js          # Konfigurasi koneksi database
├── database/
│   └── schema.sql           # Schema database & seed data
├── routes/
│   ├── public.js            # Routes untuk halaman publik
│   └── admin.js             # Routes untuk admin panel
├── views/
│   ├── layout/
│   │   ├── header.ejs       # Header template
│   │   └── footer.ejs       # Footer template
│   ├── public/
│   │   ├── index.ejs        # Landing page
│   │   └── detail.ejs       # Detail kamar
│   ├── admin/
│   │   ├── login.ejs        # Login admin
│   │   └── dashboard.ejs    # Dashboard admin
│   └── 404.ejs              # 404 error page
├── .env                     # Environment variables
├── .env.example             # Template environment variables
├── .gitignore
├── .dockerignore
├── Dockerfile               # Docker image configuration
├── docker-compose.yml       # Docker Compose orchestration
├── package.json             # NPM dependencies
├── server.js                # Entry point aplikasi
└── README.md
```

## 🚀 Cara Menjalankan Aplikasi

### Prasyarat
- Docker Desktop terinstall
- Docker Compose terinstall
- Port 3000 dan 3306 tersedia

### Metode 1: Menggunakan Docker Compose (Recommended)

1. **Clone atau Extract Project**
   ```bash
   cd Vmware_Kos-Kosan
   ```

2. **Build dan Jalankan Container**
   ```bash
   docker-compose up --build
   ```

3. **Akses Aplikasi**
   - Website: http://localhost:3000
   - Admin Panel: http://localhost:3000/admin/login

4. **Stop Container**
   ```bash
   docker-compose down
   ```

5. **Stop dan Hapus Volume (Reset Database)**
   ```bash
   docker-compose down -v
   ```

### Metode 2: Menjalankan Lokal (Tanpa Docker)

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Setup Database MySQL**
   - Buat database `koskosan_db`
   - Import file `database/schema.sql`

3. **Konfigurasi Environment**
   - Copy `.env.example` ke `.env`
   - Sesuaikan kredensial database

4. **Jalankan Aplikasi**
   ```bash
   npm start
   ```
   Atau untuk development dengan auto-reload:
   ```bash
   npm run dev
   ```

## 🔑 Login Admin Default

```
Username: admin
Password: admin123
```

**⚠️ PENTING**: Ganti password default setelah login pertama untuk keamanan!

## 📊 Database Schema

### Tabel `users`
- `id`: INT (Primary Key, Auto Increment)
- `username`: VARCHAR(50) - Username admin
- `password`: VARCHAR(255) - Password terenkripsi bcrypt
- `role`: ENUM('admin') - Role user
- `created_at`: TIMESTAMP

### Tabel `kamar`
- `id`: INT (Primary Key, Auto Increment)
- `nama_kamar`: VARCHAR(100) - Nama kamar (contoh: Kamar A1)
- `tipe`: ENUM('Single', 'Double', 'VIP')
- `harga_per_bulan`: DECIMAL(10,2) - Harga sewa per bulan
- `fasilitas`: TEXT - Deskripsi fasilitas kamar
- `status`: ENUM('Tersedia', 'Terisi', 'Maintenance')
- `foto_url`: VARCHAR(255) - URL foto kamar
- `created_at`: TIMESTAMP
- `updated_at`: TIMESTAMP

### Tabel `pemesanan`
- `id`: INT (Primary Key, Auto Increment)
- `id_kamar`: INT (Foreign Key → kamar.id)
- `nama_pemesan`: VARCHAR(100)
- `email`: VARCHAR(100)
- `no_telepon`: VARCHAR(20)
- `tanggal_mulai`: DATE
- `durasi_bulan`: INT
- `catatan`: TEXT
- `status`: ENUM('Pending', 'Disetujui', 'Ditolak')
- `created_at`: TIMESTAMP

## 🌐 Environment Variables

| Variable | Deskripsi | Default |
|----------|-----------|---------|
| DB_HOST | Host database MySQL | localhost |
| DB_PORT | Port database MySQL | 3306 |
| DB_USER | Username database | root |
| DB_PASSWORD | Password database | root |
| DB_NAME | Nama database | koskosan_db |
| PORT | Port aplikasi web | 3000 |
| SESSION_SECRET | Secret key untuk session | koskosan_secret_key_2024 |

## 📸 Screenshots

### Landing Page (Public)
- Menampilkan daftar semua kamar kos
- Filter berdasarkan tipe dan status
- Search berdasarkan nama kamar atau fasilitas

### Detail Kamar
- Informasi lengkap kamar
- Harga dan fasilitas
- Form booking langsung

### Admin Dashboard
- Statistik kamar
- CRUD management kamar
- Kelola pemesanan (approve/reject)

## 🔧 Fitur Teknis

- ✅ RESTful API architecture
- ✅ Session-based authentication
- ✅ Password hashing dengan bcrypt
- ✅ Responsive design (mobile-friendly)
- ✅ SQL injection protection
- ✅ Environment-based configuration
- ✅ Docker containerization
- ✅ Database connection pooling
- ✅ Error handling & logging

## 📝 API Endpoints

### Public Routes
- `GET /` - Landing page dengan daftar kamar
- `GET /kamar/:id` - Detail kamar
- `POST /booking` - Submit pemesanan kamar

### Admin Routes
- `GET /admin/login` - Halaman login admin
- `POST /admin/login` - Proses login
- `GET /admin/logout` - Logout
- `GET /admin/dashboard` - Dashboard admin (protected)
- `POST /admin/kamar/add` - Tambah kamar baru (protected)
- `POST /admin/kamar/update/:id` - Update kamar (protected)
- `POST /admin/kamar/delete/:id` - Hapus kamar (protected)
- `POST /admin/pemesanan/status/:id` - Update status pemesanan (protected)
- `POST /admin/pemesanan/delete/:id` - Hapus pemesanan (protected)

## 🐛 Troubleshooting

### Port sudah digunakan
Jika port 3000 atau 3306 sudah digunakan, ubah di `docker-compose.yml`:
```yaml
ports:
  - "8080:3000"  # Ubah 8080 sesuai kebutuhan
```

### Database connection error
- Pastikan MySQL container sudah running
- Cek kredensial database di `.env`
- Tunggu beberapa detik sampai MySQL selesai initialize

### Cannot find module error
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up
```

## 👨‍💻 Developer

Dibuat untuk tugas kuliah **Cloud Computing**

## 📄 License

MIT License - Bebas digunakan untuk keperluan edukasi

---

**Happy Coding! 🚀**
