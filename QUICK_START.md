# ⚡ Quick Start Guide - Website Kos-Kosan

## 🚀 Cara Tercepat Menjalankan Aplikasi

### Prasyarat
- ✅ Docker Desktop terinstall
- ✅ Port 3000 dan 3306 tersedia

### 3 Langkah Mudah

```bash
# 1. Masuk ke folder project
cd Vmware_Kos-Kosan

# 2. Jalankan Docker Compose
docker-compose up --build -d

# 3. Tunggu 10-15 detik, lalu akses
```

**Buka Browser:**
- Website: http://localhost:3000
- Admin: http://localhost:3000/admin/login

**Login Admin:**
- Username: `admin`
- Password: `admin123`

### Stop Aplikasi
```bash
docker-compose down
```

### Reset Database
```bash
docker-compose down -v
docker-compose up -d
```

---

## 📋 Checklist Testing

### ✅ Test Halaman Public
1. [ ] Buka http://localhost:3000 - Landing page muncul
2. [ ] Lihat daftar kamar (ada 8 kamar)
3. [ ] Coba filter "Tipe: Single"
4. [ ] Coba search "VIP"
5. [ ] Klik "Lihat Detail" pada kamar A1
6. [ ] Isi form booking dan submit
7. [ ] Muncul notifikasi sukses

### ✅ Test Halaman Admin
1. [ ] Buka http://localhost:3000/admin/login
2. [ ] Login dengan admin/admin123
3. [ ] Dashboard muncul dengan statistik
4. [ ] Lihat 8 kamar di tabel
5. [ ] Klik "Tambah Kamar" dan isi form
6. [ ] Klik Edit pada kamar
7. [ ] Lihat pemesanan yang tadi dibuat
8. [ ] Klik "Setujui" pada pemesanan
9. [ ] Status kamar berubah jadi "Terisi"
10. [ ] Logout

---

## 🔧 Troubleshooting Cepat

**Container tidak mau start?**
```bash
docker-compose down -v
docker-compose up --build
```

**Lihat error message:**
```bash
docker-compose logs -f
```

**Port sudah digunakan?**
Edit `docker-compose.yml`, ubah port 3000 ke 8080:
```yaml
ports:
  - "8080:3000"
```

---

## 📸 Screenshot untuk Laporan

Ambil screenshot ini:
1. Output `docker-compose ps`
2. Landing page (halaman utama)
3. Halaman detail kamar
4. Form booking
5. Login admin
6. Dashboard admin
7. Tabel kamar di admin
8. Tabel pemesanan di admin

---

**Selamat Mencoba! 🎉**
