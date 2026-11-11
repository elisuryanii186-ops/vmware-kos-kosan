# 📑 Index - Website Kos-Kosan Project

## 🚀 Mulai dari Sini!

Baru pertama kali buka project ini? Ikuti urutan berikut:

1. **CARA_MENJALANKAN.txt** - Baca ini dulu! (Bahasa Indonesia, step-by-step)
2. **QUICK_START.md** - Panduan cepat 3 langkah
3. **README.md** - Dokumentasi lengkap teknis

---

## 📂 Navigasi File

### 🎯 Quick Access

| File | Deskripsi | Kapan Digunakan |
|------|-----------|-----------------|
| [CARA_MENJALANKAN.txt](CARA_MENJALANKAN.txt) | Petunjuk langkah-demi-langkah (Indonesia) | **MULAI DI SINI!** |
| [QUICK_START.md](QUICK_START.md) | Panduan cepat 3 langkah | Butuh start cepat |
| [COMMANDS.txt](COMMANDS.txt) | Cheatsheet Docker commands | Lupa command apa |
| [README.md](README.md) | Dokumentasi lengkap | Perlu penjelasan detail |

### 📚 Dokumentasi

| File | Isi | Target Pembaca |
|------|-----|----------------|
| [README.md](README.md) | Dokumentasi lengkap aplikasi, fitur, tech stack | Developer, Reviewer |
| [TUGAS.md](TUGAS.md) | Penjelasan tugas kuliah, arsitektur, konsep cloud | Mahasiswa, Dosen |
| [DEPLOYMENT.md](DEPLOYMENT.md) | Cara deploy ke AWS, GCP, DigitalOcean, Heroku | DevOps, Deploy ke cloud |
| [QUICK_START.md](QUICK_START.md) | 3 langkah cepat menjalankan | Pengguna baru |
| [CARA_MENJALANKAN.txt](CARA_MENJALANKAN.txt) | Step-by-step detail (Bahasa Indonesia) | Pemula, Testing |
| [COMMANDS.txt](COMMANDS.txt) | Docker command reference | Daily use, Troubleshooting |
| [CHANGELOG.md](CHANGELOG.md) | Version history & roadmap | Developer, Contributor |
| [LICENSE](LICENSE) | MIT License | Legal, Distribution |

### 🔧 Core Application

| File/Folder | Fungsi |
|-------------|--------|
| [server.js](server.js) | Entry point aplikasi Express.js |
| [package.json](package.json) | NPM dependencies & scripts |
| [config/database.js](config/database.js) | Konfigurasi MySQL connection pool |
| [routes/public.js](routes/public.js) | Routes halaman publik (landing, detail, booking) |
| [routes/admin.js](routes/admin.js) | Routes admin panel (login, dashboard, CRUD) |
| [database/schema.sql](database/schema.sql) | Database schema & seed data |

### 🎨 Views (Templates)

| File | Halaman |
|------|---------|
| [views/layout/header.ejs](views/layout/header.ejs) | Global header (HTML head, CSS, navbar) |
| [views/layout/footer.ejs](views/layout/footer.ejs) | Global footer (scripts, footer content) |
| [views/public/index.ejs](views/public/index.ejs) | Landing page (daftar kamar + filter) |
| [views/public/detail.ejs](views/public/detail.ejs) | Detail kamar + form booking |
| [views/admin/login.ejs](views/admin/login.ejs) | Halaman login admin |
| [views/admin/dashboard.ejs](views/admin/dashboard.ejs) | Dashboard admin (CRUD kamar & pemesanan) |
| [views/404.ejs](views/404.ejs) | 404 error page |

### 🐳 Docker

| File | Fungsi |
|------|--------|
| [Dockerfile](Dockerfile) | Blueprint Docker image aplikasi web |
| [docker-compose.yml](docker-compose.yml) | Orchestration 2 container (web + mysql) |
| [.dockerignore](.dockerignore) | File yang diabaikan saat build image |

### ⚙️ Configuration

| File | Fungsi |
|------|--------|
| [.env](.env) | Environment variables (development) |
| [.env.example](.env.example) | Template environment variables |
| [.gitignore](.gitignore) | Git ignore rules |

---

## 🎯 Use Cases & File yang Relevan

### Skenario 1: "Saya baru pertama kali buka project ini"
👉 Baca: **CARA_MENJALANKAN.txt** → **QUICK_START.md**

### Skenario 2: "Saya ingin menjalankan aplikasi sekarang"
👉 Baca: **QUICK_START.md**  
👉 Command:
```bash
cd C:\Vmware_Kos-Kosan
docker-compose up -d
```

### Skenario 3: "Saya lupa command Docker apa saja"
👉 Baca: **COMMANDS.txt**

### Skenario 4: "Saya perlu memahami arsitektur untuk laporan tugas"
👉 Baca: **TUGAS.md** → bagian "Arsitektur Aplikasi"

### Skenario 5: "Saya ingin deploy ke AWS/GCP"
👉 Baca: **DEPLOYMENT.md** → pilih platform yang diinginkan

### Skenario 6: "Aplikasi error, butuh troubleshooting"
👉 Baca: **CARA_MENJALANKAN.txt** → bagian "TROUBLESHOOTING"  
👉 Command:
```bash
docker-compose logs -f
```

### Skenario 7: "Saya ingin tahu detail fitur aplikasi"
👉 Baca: **README.md** → bagian "Fitur Utama"

### Skenario 8: "Saya ingin modifikasi kode"
👉 Lihat struktur di **README.md** → edit file di folder yang sesuai:
- Routes: `routes/public.js` atau `routes/admin.js`
- Views: `views/public/` atau `views/admin/`
- Database: `config/database.js` atau `database/schema.sql`

### Skenario 9: "Saya ingin testing semua fitur"
👉 Baca: **QUICK_START.md** → bagian "Checklist Testing"

### Skenario 10: "Saya butuh screenshot untuk laporan"
👉 Baca: **QUICK_START.md** → bagian "Screenshot untuk Laporan"

---

## 🗺️ Roadmap Pembelajaran

### Level 1: Pemula (Hari 1)
1. ✅ Baca **CARA_MENJALANKAN.txt**
2. ✅ Jalankan aplikasi dengan Docker Compose
3. ✅ Test halaman public (filter, search, booking)
4. ✅ Test halaman admin (login, CRUD)
5. ✅ Ambil screenshot

### Level 2: Intermediate (Hari 2-3)
1. ✅ Baca **README.md** untuk memahami tech stack
2. ✅ Baca **TUGAS.md** untuk memahami konsep cloud
3. ✅ Pelajari struktur kode (server.js, routes, views)
4. ✅ Pahami database schema (schema.sql)
5. ✅ Eksperimen modifikasi data dummy

### Level 3: Advanced (Hari 4-5)
1. ✅ Baca **DEPLOYMENT.md** untuk deploy
2. ✅ Deploy ke cloud (AWS/GCP/DigitalOcean)
3. ✅ Setup domain & SSL certificate
4. ✅ Modifikasi fitur (tambah field, ubah UI)
5. ✅ Buat laporan lengkap

---

## 📊 Statistik Project

- **Total Files**: 28 files
- **Total Folders**: 6 folders
- **Lines of Code**: ~2,500 lines
- **Documentation**: 8 files
- **Code Files**: 13 files
- **Languages**: JavaScript, SQL, EJS, YAML, Markdown

### Breakdown by Type

| Type | Count |
|------|-------|
| JavaScript (*.js) | 4 files |
| EJS Templates (*.ejs) | 7 files |
| SQL (*.sql) | 1 file |
| Markdown (*.md) | 5 files |
| Text (*.txt) | 2 files |
| Docker (Dockerfile, *.yml) | 2 files |
| Config (*.json, .env*) | 3 files |
| Other (.*ignore, LICENSE) | 4 files |

---

## 🔗 Quick Links

### URLs (Setelah aplikasi berjalan)
- **Website Publik**: http://localhost:3000
- **Admin Login**: http://localhost:3000/admin/login
- **Admin Dashboard**: http://localhost:3000/admin/dashboard

### Default Credentials
- **Username**: admin
- **Password**: admin123

### Database Access
- **Host**: localhost
- **Port**: 3306
- **User**: root
- **Password**: root
- **Database**: koskosan_db

---

## 🆘 Emergency Quick Reference

### Aplikasi Tidak Bisa Start?
```bash
docker-compose down -v
docker-compose up --build
```

### Lihat Error Message?
```bash
docker-compose logs -f
```

### Reset Semua Data?
```bash
docker-compose down -v
docker-compose up -d
```

### Port Sudah Dipakai?
Edit `docker-compose.yml`, ubah `3000:3000` menjadi `8080:3000`

---

## 📞 Support

Jika menemui masalah:

1. **Cek Troubleshooting** di CARA_MENJALANKAN.txt
2. **Lihat Logs**: `docker-compose logs -f`
3. **Cek Status**: `docker-compose ps`
4. **Baca FAQ** di README.md

---

## ✅ Checklist Sebelum Submit Tugas

- [ ] Aplikasi bisa dijalankan dengan Docker
- [ ] Semua fitur publik berfungsi (filter, search, booking)
- [ ] Semua fitur admin berfungsi (login, CRUD, approve)
- [ ] Screenshot lengkap sudah diambil
- [ ] Penjelasan arsitektur sudah dipahami
- [ ] Laporan sudah ditulis (gunakan TUGAS.md sebagai referensi)
- [ ] Code sudah di-push ke Git (jika diminta)

---

## 🎓 Credit

Project ini dibuat untuk tugas kuliah **Cloud Computing**.

**Tech Stack**:
- Node.js + Express.js
- MySQL 8.0
- Bootstrap 5
- Docker + Docker Compose

**License**: MIT License

---

**Happy Coding! 🚀**

*Last Updated: November 11, 2024*
