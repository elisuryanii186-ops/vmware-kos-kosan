# 🏠 Website Kos-Kosan

Aplikasi web sederhana untuk manajemen kos-kosan yang dibangun menggunakan **Node.js**, **Express**, **MySQL**, dan **Bootstrap 5**. Aplikasi ini dibuat untuk tugas kuliah Cloud Computing dan dapat dijalankan dalam kontainer Docker.

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=flat&logo=nodedotjs&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Express](https://img.shields.io/badge/Express-000000?style=flat&logo=express&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-7952B3?style=flat&logo=bootstrap&logoColor=white)

---

## 📋 Fitur Utama

### Halaman Publik
- ✅ Landing page dengan daftar kamar kos
- ✅ Filter berdasarkan tipe kamar (Single/Double/VIP)
- ✅ Filter berdasarkan status (Tersedia/Terisi/Maintenance)
- ✅ Search berdasarkan nama kamar atau fasilitas
- ✅ Detail kamar dengan info lengkap
- ✅ Formulir booking online dengan validasi
- ✅ Responsive design (mobile-friendly)

### Halaman Admin
- ✅ Dashboard dengan statistik real-time
- ✅ CRUD Kamar (Create, Read, Update, Delete)
- ✅ Manajemen Pemesanan (View, Approve, Reject)
- ✅ Auto-update status kamar saat pemesanan disetujui

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **Backend** | Node.js v18 + Express.js v4.18 |
| **Database** | MySQL v8.0 |
| **Template Engine** | EJS v3.1 |
| **Frontend** | Bootstrap 5.3 + Bootstrap Icons |
| **Security** | bcrypt + express-session |
| **Container** | Docker + Docker Compose |

---

## 🚀 Quick Start

### Prerequisites

- Docker Desktop (v20.x atau lebih baru)
- Docker Compose (v2.x atau lebih baru)

### Installation

```bash
# 1. Clone repository
git clone https://github.com/your-username/kos-kosan.git
cd kos-kosan

# 2. Start dengan Docker Compose
docker-compose up -d --build

# 3. Tunggu ~15 detik untuk MySQL initialization

# 4. Buka browser
# - Website: http://localhost:8080
# - Admin: http://localhost:8080/admin/dashboard
```

### Stop Application

```bash
docker-compose down
```

### Reset Database

```bash
docker-compose down -v
docker-compose up -d
```

---

## 📁 Struktur Folder

```
kos-kosan/
├── config/
│   └── database.js          # MySQL connection pool
├── database/
│   └── schema.sql           # Database schema + seed data
├── routes/
│   ├── public.js            # Public routes
│   └── admin.js             # Admin routes
├── views/
│   ├── layout/              # Header & footer templates
│   ├── public/              # Public pages (landing, detail)
│   └── admin/               # Admin pages (dashboard)
├── public/images/           # Static images
├── proxysql/                # ProxySQL configuration (optional)
├── .env                     # Environment variables
├── server.js                # Main entry point
├── package.json             # NPM dependencies
├── Dockerfile               # Docker image config
├── docker-compose.yml       # Container orchestration
└── README.md
```

---

## 🗄️ Database Schema

### Tabel `users`
```sql
- id (PK, Auto Increment)
- username (VARCHAR, UNIQUE)
- password (VARCHAR, bcrypt hashed)
- role (ENUM: 'admin')
- created_at (TIMESTAMP)
```

### Tabel `kamar`
```sql
- id (PK, Auto Increment)
- nama_kamar (VARCHAR)
- tipe (ENUM: 'Single', 'Double', 'VIP')
- harga_per_bulan (DECIMAL)
- fasilitas (TEXT)
- status (ENUM: 'Tersedia', 'Terisi', 'Maintenance')
- foto_url (VARCHAR)
- created_at, updated_at (TIMESTAMP)
```

### Tabel `pemesanan`
```sql
- id (PK, Auto Increment)
- id_kamar (FK → kamar.id)
- nama_pemesan (VARCHAR)
- email (VARCHAR)
- no_telepon (VARCHAR)
- tanggal_mulai (DATE)
- durasi_bulan (INT)
- catatan (TEXT)
- status (ENUM: 'Pending', 'Disetujui', 'Ditolak')
- created_at (TIMESTAMP)
```

**Seed Data:**
- 1 admin user (auto-login for demo)
- 8 sample kamar dengan berbagai tipe dan harga
- 3 sample pemesanan

---

## ⚙️ Configuration

### Environment Variables

File `.env`:
```env
DB_HOST=mysql
DB_PORT=3306
DB_USER=root
DB_PASSWORD=root
DB_NAME=koskosan_db
PORT=3000
SESSION_SECRET=koskosan_secret_key_2024
```

### Docker Compose

Setup default menggunakan 2 containers:
- `koskosan_mysql` - MySQL 8.0 database
- `koskosan_web` - Node.js application

**Ports:**
- Web App: `8080:3000`
- MySQL: `3306:3306`

---

## 🔧 Development

### Local Development (tanpa Docker)

```bash
# Install dependencies
npm install

# Setup database manually
mysql -u root -p < database/schema.sql

# Update .env dengan DB_HOST=localhost

# Run development mode
npm run dev
```

### View Logs

```bash
# All containers
docker-compose logs -f

# Specific container
docker-compose logs -f web
docker-compose logs -f mysql
```

---

## 🎯 API Endpoints

### Public Routes
- `GET /` - Landing page dengan daftar kamar
- `GET /kamar/:id` - Detail kamar
- `POST /booking` - Submit pemesanan kamar

### Admin Routes
- `GET /admin/dashboard` - Dashboard admin (auto-login for demo)
- `POST /admin/kamar/add` - Tambah kamar baru
- `POST /admin/kamar/update/:id` - Update kamar
- `POST /admin/kamar/delete/:id` - Hapus kamar
- `POST /admin/pemesanan/status/:id` - Update status pemesanan
- `POST /admin/pemesanan/delete/:id` - Hapus pemesanan

---

## 🔐 Security Features

- ✅ Password hashing dengan bcrypt
- ✅ Session-based authentication
- ✅ SQL injection prevention (prepared statements)
- ✅ Input validation client & server side
- ✅ Environment variables untuk sensitive data

**Note:** Authentication disederhanakan untuk demo (auto-login). Untuk production, re-enable authentication di `routes/admin.js`.

---

## 🐳 Docker Configuration

### Dockerfile

Base image: `node:18-alpine` (lightweight)

Layers:
1. Copy package files
2. Install dependencies
3. Copy application files
4. Expose port 3000
5. Start with `node server.js`

### docker-compose.yml

Services:
- **MySQL**: Database dengan persistent volume
- **Web**: Node.js application dengan environment variables
- **Network**: Custom bridge network untuk container communication

---

## 🚀 Deployment

### Deploy ke Production Server

```bash
# 1. Clone repository di server
git clone https://github.com/your-username/kos-kosan.git
cd kos-kosan

# 2. Update .env dengan production credentials

# 3. Start dengan Docker Compose
docker-compose up -d --build

# 4. (Optional) Setup Nginx reverse proxy
```

### Deploy ke Cloud Platform

**AWS EC2 / DigitalOcean:**
- Install Docker & Docker Compose
- Clone repository
- Run `docker-compose up -d`

**Google Cloud Run:**
- Build image: `docker build -t gcr.io/PROJECT_ID/koskosan .`
- Push: `docker push gcr.io/PROJECT_ID/koskosan`
- Deploy: `gcloud run deploy --image gcr.io/PROJECT_ID/koskosan`

**Heroku:**
- Add `heroku/nodejs` buildpack
- Add `jawsdb` addon untuk MySQL
- Deploy via Git

---

## 🔄 ProxySQL Configuration (Optional)

Folder `proxysql/` berisi konfigurasi lengkap untuk database proxy layer:

```bash
# Start dengan ProxySQL
docker-compose -f docker-compose.proxysql.yml up -d
```

**Benefits:**
- Connection pooling (50x faster)
- Query caching (10-20x faster for repeated queries)
- Query routing & load balancing
- Real-time monitoring

**Access:**
- MySQL Interface: `localhost:6033`
- Admin Interface: `localhost:6032`

---

## 🆘 Troubleshooting

### Port Already in Use

Edit `docker-compose.yml`:
```yaml
ports:
  - "9090:3000"  # Change 8080 to 9090
```

### Container Not Starting

```bash
docker-compose logs
docker-compose down -v
docker-compose up --build -d
```

### Database Connection Error

```bash
# Restart MySQL
docker-compose restart mysql

# Check MySQL logs
docker-compose logs mysql
```

### Reset Everything

```bash
docker-compose down -v
docker volume prune
docker-compose up --build -d
```

---

## 📊 Monitoring

### View Statistics

```bash
# Container stats
docker stats

# Database size
docker exec koskosan_mysql mysql -u root -proot -e "SELECT table_schema AS 'Database', ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)' FROM information_schema.tables WHERE table_schema = 'koskosan_db';"
```

---

## 🎓 Untuk Tugas Kuliah

Project ini mendemonstrasikan konsep Cloud Computing:

1. **Containerization** - Aplikasi dalam Docker containers
2. **Microservices** - Service separation (web + db)
3. **Infrastructure as Code** - Docker Compose configuration
4. **Scalability** - Easy to scale horizontally/vertically
5. **Configuration Management** - Environment-based config
6. **Observability** - Logs dan monitoring built-in

**Cocok untuk:**
- ✅ Tugas Cloud Computing
- ✅ Project akhir semester
- ✅ Portfolio web development
- ✅ Belajar Docker & containerization

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

Dibuat untuk tugas kuliah Cloud Computing

---

## 🙏 Acknowledgments

- Bootstrap team untuk CSS framework
- Express.js community
- Docker untuk containerization
- MySQL team
- Node.js community

---

**Happy Coding! 🚀**

Repository: [https://github.com/your-username/kos-kosan](https://github.com/your-username/kos-kosan)

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
