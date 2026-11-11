# ✅ Checklist Verifikasi - Website Kos-Kosan

## 📋 Panduan Verifikasi Lengkap

Gunakan checklist ini untuk memastikan aplikasi berjalan dengan sempurna sebelum demo atau submit tugas.

---

## 1️⃣ Persiapan (Pre-requisites)

### Docker Installation
- [ ] Docker Desktop terinstall
- [ ] Docker daemon sedang berjalan
- [ ] Command `docker --version` menampilkan versi
- [ ] Command `docker-compose --version` menampilkan versi

**Cara Cek:**
```powershell
docker --version
# Expected: Docker version 20.x.x atau lebih baru

docker-compose --version
# Expected: Docker Compose version v2.x.x atau lebih baru
```

### Port Availability
- [ ] Port 3000 tidak digunakan aplikasi lain
- [ ] Port 3306 tidak digunakan aplikasi lain

**Cara Cek (Windows PowerShell):**
```powershell
netstat -ano | findstr :3000
netstat -ano | findstr :3306
# Jika kosong = port tersedia ✅
# Jika ada output = port digunakan ❌
```

### Sistem Requirement
- [ ] Minimal 2GB RAM tersedia
- [ ] Minimal 5GB disk space tersedia
- [ ] Internet connection (untuk pertama kali pull images)

---

## 2️⃣ File Structure Verification

### Core Files
- [ ] `server.js` ada
- [ ] `package.json` ada
- [ ] `Dockerfile` ada
- [ ] `docker-compose.yml` ada
- [ ] `.env` ada

### Config Files
- [ ] `config/database.js` ada
- [ ] `database/schema.sql` ada

### Routes
- [ ] `routes/public.js` ada
- [ ] `routes/admin.js` ada

### Views
- [ ] `views/layout/header.ejs` ada
- [ ] `views/layout/footer.ejs` ada
- [ ] `views/public/index.ejs` ada
- [ ] `views/public/detail.ejs` ada
- [ ] `views/admin/login.ejs` ada
- [ ] `views/admin/dashboard.ejs` ada
- [ ] `views/404.ejs` ada

### Documentation
- [ ] `README.md` ada
- [ ] `CARA_MENJALANKAN.txt` ada
- [ ] `QUICK_START.md` ada
- [ ] `TUGAS.md` ada
- [ ] `DEPLOYMENT.md` ada

---

## 3️⃣ Docker Build & Run

### Build Process
```powershell
cd C:\Vmware_Kos-Kosan
docker-compose up --build -d
```

**Expected Output:**
```
[+] Building ...
[+] Running 3/3
 ✔ Network koskosan_network      Created
 ✔ Container koskosan_mysql      Started
 ✔ Container koskosan_web        Started
```

### Verification Commands
- [ ] `docker-compose ps` menampilkan 2 container dengan status "running"
- [ ] `docker-compose logs mysql | findstr "ready for connections"` ada output
- [ ] `docker-compose logs web | findstr "Server running"` ada output

**Check Container Status:**
```powershell
docker-compose ps
```

**Expected Output:**
```
NAME              STATUS    PORTS
koskosan_mysql    running   0.0.0.0:3306->3306/tcp
koskosan_web      running   0.0.0.0:3000->3000/tcp
```

---

## 4️⃣ Database Verification

### MySQL Connection
- [ ] MySQL container berjalan
- [ ] Database `koskosan_db` terbuat
- [ ] Tabel `users`, `kamar`, `pemesanan` ada
- [ ] Seed data terinsert

**Cara Cek:**
```powershell
# Masuk ke MySQL container
docker exec -it koskosan_mysql mysql -u root -proot koskosan_db

# Di dalam MySQL CLI:
SHOW TABLES;
# Expected: users, kamar, pemesanan

SELECT COUNT(*) FROM users;
# Expected: 1 (admin user)

SELECT COUNT(*) FROM kamar;
# Expected: 8 (sample rooms)

SELECT COUNT(*) FROM pemesanan;
# Expected: 3 (sample bookings)

# Keluar
EXIT;
```

---

## 5️⃣ Web Application Verification

### Homepage (Public)
- [ ] Buka http://localhost:3000
- [ ] Halaman loading tanpa error
- [ ] Navbar muncul dengan logo "Kos-Kosan"
- [ ] Judul "Temukan Kamar Kos Impian Anda" terlihat
- [ ] Filter section muncul (Search, Tipe, Status)
- [ ] 8 kamar cards terlihat
- [ ] Setiap card punya: nama, tipe, harga, fasilitas, status, button detail
- [ ] Footer muncul di bawah

**Screenshot untuk Laporan:** ✅

### Filter & Search
- [ ] Filter "Tipe: Single" → 4 kamar muncul
- [ ] Filter "Tipe: Double" → 3 kamar muncul
- [ ] Filter "Tipe: VIP" → 1 kamar muncul
- [ ] Filter "Status: Tersedia" → 6 kamar muncul
- [ ] Filter "Status: Terisi" → 1 kamar muncul
- [ ] Filter "Status: Maintenance" → 1 kamar muncul
- [ ] Search "WiFi" → minimal 1 kamar muncul
- [ ] Search "VIP" → 1 kamar muncul
- [ ] Button "Filter" berfungsi

**Screenshot untuk Laporan:** ✅

### Detail Kamar
- [ ] Klik "Lihat Detail" pada Kamar A1
- [ ] URL berubah ke `/kamar/1`
- [ ] Breadcrumb: Beranda > Kamar A1
- [ ] Foto kamar terlihat (placeholder OK)
- [ ] Nama kamar: "Kamar A1"
- [ ] Badge tipe: "Single"
- [ ] Harga: "Rp 800.000 /bulan"
- [ ] Fasilitas terbaca lengkap
- [ ] Badge status: "Tersedia" (hijau)
- [ ] Button "Pesan Sekarang" aktif (tidak disabled)

**Screenshot untuk Laporan:** ✅

### Form Booking
- [ ] Klik button "Pesan Sekarang"
- [ ] Modal form booking muncul
- [ ] Form memiliki field: Nama, Email, No Telepon, Tanggal Mulai, Durasi, Catatan
- [ ] Semua field dengan tanda * required
- [ ] Isi form dengan data valid:
  - Nama: Test User
  - Email: test@example.com
  - No Telepon: 081234567890
  - Tanggal Mulai: pilih tanggal
  - Durasi: 6
  - Catatan: Test booking
- [ ] Klik "Kirim Pemesanan"
- [ ] Toast notification muncul: "Pemesanan berhasil! Mohon tunggu konfirmasi admin."
- [ ] Modal tertutup otomatis
- [ ] Redirect ke homepage dalam 2 detik

**Screenshot untuk Laporan:** ✅

---

## 6️⃣ Admin Panel Verification

### Login Page
- [ ] Buka http://localhost:3000/admin/login
- [ ] Background gradient terlihat (ungu/biru)
- [ ] Form login muncul dengan icon shield
- [ ] Judul "Admin Login" terlihat
- [ ] Ada field Username dan Password
- [ ] Ada hint credentials: admin / admin123
- [ ] Ada link "Kembali ke Beranda"

**Screenshot untuk Laporan:** ✅

### Login Process
- [ ] Input username: `admin`
- [ ] Input password: `admin123`
- [ ] Klik button "Login"
- [ ] Redirect ke `/admin/dashboard`
- [ ] Navbar berubah (ada username dan logout)

### Dashboard - Statistics
- [ ] Navbar menampilkan "Admin Dashboard"
- [ ] Username "admin" terlihat di navbar
- [ ] 3 card statistik muncul:
  - Total Kamar: 8
  - Kamar Tersedia: 6 (atau sesuai data terkini)
  - Pemesanan Pending: 2-3 (atau sesuai data terkini)

**Screenshot untuk Laporan:** ✅

### Dashboard - Tabel Kamar
- [ ] Tabel "Manajemen Kamar" terlihat
- [ ] Button "Tambah Kamar" ada di header
- [ ] Tabel punya kolom: ID, Nama, Tipe, Harga, Fasilitas, Status, Aksi
- [ ] 8 baris data kamar terlihat
- [ ] Setiap row punya button Edit (icon pensil) dan Delete (icon trash)
- [ ] Badge tipe berwarna biru
- [ ] Badge status berwarna sesuai (hijau/merah/kuning)

**Screenshot untuk Laporan:** ✅

### CRUD Kamar - Create
- [ ] Klik button "Tambah Kamar"
- [ ] Modal "Tambah Kamar Baru" muncul
- [ ] Isi form:
  - Nama Kamar: Kamar Test
  - Tipe: Single
  - Harga: 900000
  - Fasilitas: Kasur, AC, WiFi, Test
  - Status: Tersedia
- [ ] Klik "Simpan"
- [ ] Toast notification: "Kamar berhasil ditambahkan!"
- [ ] Halaman reload
- [ ] Kamar baru muncul di tabel (9 kamar total)

### CRUD Kamar - Update
- [ ] Klik button Edit (pensil) pada kamar yang baru dibuat
- [ ] Modal "Edit Kamar" muncul
- [ ] Data kamar terisi otomatis
- [ ] Ubah harga menjadi: 950000
- [ ] Ubah status menjadi: Maintenance
- [ ] Klik "Update"
- [ ] Toast notification: "Kamar berhasil diupdate!"
- [ ] Halaman reload
- [ ] Perubahan terlihat di tabel

### CRUD Kamar - Delete
- [ ] Klik button Delete (trash) pada kamar test
- [ ] Konfirmasi dialog muncul: "Yakin ingin menghapus kamar ini?"
- [ ] Klik OK
- [ ] Toast notification: "Kamar berhasil dihapus!"
- [ ] Halaman reload
- [ ] Kamar test hilang dari tabel (kembali 8 kamar)

### Dashboard - Tabel Pemesanan
- [ ] Scroll ke bawah, tabel "Daftar Pemesanan" terlihat
- [ ] Tabel punya kolom: ID, Kamar, Nama Pemesan, Kontak, Tanggal Mulai, Durasi, Status, Aksi
- [ ] Minimal 3-4 baris pemesanan (termasuk yang tadi dibuat via public)
- [ ] Badge status berwarna (kuning: Pending, hijau: Disetujui, merah: Ditolak)
- [ ] Pemesanan dengan status Pending punya button "Setujui" dan "Tolak"
- [ ] Pemesanan dengan status lain punya button Delete

**Screenshot untuk Laporan:** ✅

### Manajemen Pemesanan - Approve
- [ ] Cari pemesanan dengan status "Pending"
- [ ] Catat ID kamar yang dipesan (misal: Kamar A1)
- [ ] Klik button "Setujui" (hijau dengan icon check)
- [ ] Toast notification: "Status pemesanan berhasil diupdate!"
- [ ] Halaman reload
- [ ] Status pemesanan berubah jadi "Disetujui"
- [ ] Status kamar di tabel atas berubah jadi "Terisi" ✅ (ini yang penting!)

### Logout
- [ ] Klik link "Logout" di navbar
- [ ] Redirect ke `/admin/login`
- [ ] Session cleared
- [ ] Akses `/admin/dashboard` tanpa login → redirect ke login

---

## 7️⃣ Error Handling Verification

### 404 Page
- [ ] Buka http://localhost:3000/halaman-tidak-ada
- [ ] Custom 404 page muncul
- [ ] Judul besar "404"
- [ ] Pesan "Halaman Tidak Ditemukan"
- [ ] Button "Kembali ke Beranda" ada

### Invalid Login
- [ ] Buka `/admin/login`
- [ ] Input username: `wrong`
- [ ] Input password: `wrong`
- [ ] Klik Login
- [ ] Error message: "Username atau password salah!"
- [ ] Tidak redirect, tetap di login page

### Form Validation
- [ ] Buka detail kamar
- [ ] Klik "Pesan Sekarang"
- [ ] Klik "Kirim Pemesanan" tanpa isi form
- [ ] Browser validation muncul (HTML5 required)
- [ ] Form tidak tersubmit

---

## 8️⃣ Responsive Design Verification

### Desktop (1920x1080)
- [ ] Layout rapi, tidak ada horizontal scroll
- [ ] Card kamar 3 kolom
- [ ] Tabel tidak overflow

### Tablet (768px)
- [ ] Card kamar 2 kolom
- [ ] Navbar collapsible
- [ ] Form tetap readable

### Mobile (375px)
- [ ] Card kamar 1 kolom
- [ ] Navbar hamburger menu
- [ ] Filter form stacked vertical
- [ ] Tabel scrollable horizontal
- [ ] Touch-friendly button size

**Cara Test:** Buka Developer Tools (F12) → Toggle Device Toolbar (Ctrl+Shift+M)

---

## 9️⃣ Performance Verification

### Page Load Time
- [ ] Homepage load < 2 detik
- [ ] Detail kamar load < 1 detik
- [ ] Dashboard load < 2 detik

### Resource Usage
```powershell
docker stats
```

**Expected:**
- [ ] Web container: CPU < 5%, Memory < 200MB
- [ ] MySQL container: CPU < 5%, Memory < 300MB

---

## 🔟 Security Verification

### Password Hashing
```powershell
docker exec -it koskosan_mysql mysql -u root -proot koskosan_db -e "SELECT password FROM users WHERE username='admin';"
```

- [ ] Password NOT plaintext
- [ ] Password hash starts with `$2b$` (bcrypt)

### SQL Injection Prevention
- [ ] Search dengan input: `' OR 1=1 --`
- [ ] Tidak return semua data / error
- [ ] Aplikasi tetap normal

### Session Management
- [ ] Login admin
- [ ] Copy session cookie
- [ ] Logout
- [ ] Paste session cookie → tidak bisa akses dashboard

---

## 📸 Screenshot Checklist untuk Laporan

Pastikan sudah ambil screenshot ini:

1. ✅ Output `docker-compose ps` (2 container running)
2. ✅ Landing page lengkap (navbar + cards + footer)
3. ✅ Filter active (misal: tipe Single)
4. ✅ Search active (misal: search "WiFi")
5. ✅ Detail kamar dengan semua info lengkap
6. ✅ Modal form booking yang sudah diisi
7. ✅ Toast notification "Pemesanan berhasil"
8. ✅ Admin login page
9. ✅ Dashboard admin - statistik cards
10. ✅ Dashboard admin - tabel kamar lengkap
11. ✅ Modal tambah kamar
12. ✅ Modal edit kamar
13. ✅ Dashboard admin - tabel pemesanan
14. ✅ Before approve (status Pending)
15. ✅ After approve (status Disetujui + kamar jadi Terisi)
16. ✅ Output `docker stats` (resource usage)

---

## 📊 Final Checklist Summary

### Critical (Must Pass)
- [ ] Docker containers running
- [ ] Database connection OK
- [ ] Homepage loads successfully
- [ ] Admin login works
- [ ] CRUD kamar berfungsi semua
- [ ] Approve booking mengubah status kamar

### Important (Should Pass)
- [ ] Filter & search berfungsi
- [ ] Form validation berfungsi
- [ ] Responsive design OK
- [ ] Error handling proper
- [ ] Security measures implemented

### Nice to Have (Optional)
- [ ] Performance optimal
- [ ] Custom 404 page
- [ ] Smooth animations
- [ ] Toast notifications

---

## ✅ Skor Akhir

**Total Checklist Items:** 150+

**Passing Grade:**
- 🟢 **Excellent** (90-100%): Siap demo/submit
- 🟡 **Good** (75-89%): Perlu minor fixes
- 🟠 **Fair** (60-74%): Perlu review & fixes
- 🔴 **Poor** (<60%): Perlu troubleshooting serius

---

## 🆘 Jika Ada yang Gagal

1. **Lihat logs:** `docker-compose logs -f`
2. **Cek troubleshooting:** CARA_MENJALANKAN.txt
3. **Reset database:** `docker-compose down -v` → `docker-compose up -d`
4. **Rebuild:** `docker-compose build --no-cache`

---

## 🎓 Untuk Laporan Tugas

Setelah semua checklist ✅, Anda bisa:

1. ✅ Submit dengan percaya diri
2. ✅ Demo aplikasi lancar
3. ✅ Jawab pertanyaan dosen dengan yakin
4. ✅ Dapat nilai maksimal!

---

**Selamat! Aplikasi Anda 100% Verified! 🎉**

*Checklist ini dirancang untuk memastikan ZERO ERROR saat demo/submit.*
