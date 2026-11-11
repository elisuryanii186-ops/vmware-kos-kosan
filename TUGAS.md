# 📚 Dokumentasi Tugas Cloud Computing

## Aplikasi Website Kos-Kosan

---

## 👨‍🎓 Informasi Tugas

**Mata Kuliah**: Cloud Computing  
**Topik**: Deploy Aplikasi Web dengan Docker Container  
**Aplikasi**: Website Kos-Kosan Management System  

---

## 📝 Deskripsi Aplikasi

Aplikasi web sederhana untuk manajemen kos-kosan yang memungkinkan:
- Pengunjung melihat dan memesan kamar kos
- Admin mengelola data kamar dan pemesanan
- Semua data tersimpan di database MySQL
- Aplikasi berjalan dalam container Docker untuk portabilitas tinggi

---

## 🎯 Tujuan Pembelajaran

1. ✅ Memahami konsep containerization dengan Docker
2. ✅ Implementasi multi-container application dengan Docker Compose
3. ✅ Konfigurasi networking antar container
4. ✅ Pengelolaan persistent data dengan volumes
5. ✅ Environment variables dan configuration management
6. ✅ Deploy aplikasi full-stack (Frontend + Backend + Database)

---

## 🏗️ Arsitektur Aplikasi

```
┌─────────────────────────────────────────────────┐
│                   USER                          │
│              (Web Browser)                      │
└─────────────────┬───────────────────────────────┘
                  │
                  │ HTTP (Port 3000)
                  │
┌─────────────────▼───────────────────────────────┐
│         WEB CONTAINER (Node.js)                 │
│  ┌──────────────────────────────────────────┐   │
│  │   Express.js Server                      │   │
│  │   - Routes (Public & Admin)              │   │
│  │   - EJS Template Engine                  │   │
│  │   - Session Management                   │   │
│  │   - Authentication & Authorization       │   │
│  └──────────────────────────────────────────┘   │
└─────────────────┬───────────────────────────────┘
                  │
                  │ MySQL Protocol (Port 3306)
                  │
┌─────────────────▼───────────────────────────────┐
│       MYSQL CONTAINER (Database)                │
│  ┌──────────────────────────────────────────┐   │
│  │   MySQL 8.0                              │   │
│  │   - Database: koskosan_db                │   │
│  │   - Tables: users, kamar, pemesanan      │   │
│  │   - Persistent Volume                    │   │
│  └──────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
```

---

## 🔧 Teknologi yang Digunakan

### Backend
- **Runtime**: Node.js v18
- **Framework**: Express.js v4.18
- **Template Engine**: EJS v3.1
- **Session**: express-session
- **Security**: bcrypt (password hashing)

### Database
- **DBMS**: MySQL v8.0
- **Driver**: mysql2 (Promise-based)
- **Connection**: Connection pooling

### Frontend
- **CSS Framework**: Bootstrap 5.3
- **Icons**: Bootstrap Icons
- **Design**: Responsive & Mobile-friendly

### DevOps
- **Containerization**: Docker
- **Orchestration**: Docker Compose
- **Base Image**: node:18-alpine, mysql:8.0

---

## 📦 Docker Configuration

### Dockerfile Explanation

```dockerfile
# Base image ringan berbasis Alpine Linux
FROM node:18-alpine

# Set working directory di dalam container
WORKDIR /app

# Copy dependency files dulu (untuk caching layer)
COPY package*.json ./

# Install dependencies production only
RUN npm install --production

# Copy seluruh source code
COPY . .

# Expose port 3000
EXPOSE 3000

# Set environment
ENV NODE_ENV=production

# Command untuk menjalankan aplikasi
CMD ["node", "server.js"]
```

**Kenapa Alpine?**
- Image size lebih kecil (~50MB vs ~300MB)
- Lebih cepat pull dan deploy
- Security footprint lebih kecil

### Docker Compose Explanation

```yaml
version: '3.8'

services:
  # Service MySQL Database
  mysql:
    image: mysql:8.0
    container_name: koskosan_mysql
    restart: always  # Auto restart jika crash
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: koskosan_db
      MYSQL_USER: koskosan_user
      MYSQL_PASSWORD: koskosan_pass
    ports:
      - "3306:3306"  # Port mapping
    volumes:
      - mysql_data:/var/lib/mysql  # Persistent storage
      - ./database/schema.sql:/docker-entrypoint-initdb.d/schema.sql  # Auto init
    networks:
      - koskosan_network  # Custom network
    healthcheck:  # Health check untuk dependency
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Service Web Application
  web:
    build: .  # Build dari Dockerfile
    container_name: koskosan_web
    restart: always
    ports:
      - "3000:3000"
    environment:
      DB_HOST: mysql  # Gunakan service name sebagai hostname
      DB_PORT: 3306
      DB_USER: root
      DB_PASSWORD: root
      DB_NAME: koskosan_db
      PORT: 3000
      SESSION_SECRET: koskosan_secret_key_2024
    depends_on:
      mysql:
        condition: service_healthy  # Tunggu MySQL ready
    networks:
      - koskosan_network
    volumes:
      - .:/app  # Bind mount untuk development
      - /app/node_modules  # Anonymous volume untuk node_modules

# Named volumes
volumes:
  mysql_data:  # Persistent data MySQL

# Custom network
networks:
  koskosan_network:
    driver: bridge
```

**Poin Penting:**
- `depends_on` memastikan urutan start container
- `healthcheck` memastikan MySQL benar-benar ready sebelum web start
- `volumes` untuk persistent data (data tidak hilang saat restart)
- `networks` untuk isolasi dan komunikasi antar container

---

## 🗄️ Database Design

### Entity Relationship Diagram

```
┌─────────────┐
│   users     │
├─────────────┤
│ id (PK)     │
│ username    │
│ password    │
│ role        │
│ created_at  │
└─────────────┘

┌─────────────────────┐
│       kamar         │
├─────────────────────┤
│ id (PK)             │
│ nama_kamar          │
│ tipe                │
│ harga_per_bulan     │
│ fasilitas           │
│ status              │
│ foto_url            │
│ created_at          │
│ updated_at          │
└──────────┬──────────┘
           │
           │ 1:N
           │
┌──────────▼──────────┐
│    pemesanan        │
├─────────────────────┤
│ id (PK)             │
│ id_kamar (FK)       │
│ nama_pemesan        │
│ email               │
│ no_telepon          │
│ tanggal_mulai       │
│ durasi_bulan        │
│ catatan             │
│ status              │
│ created_at          │
└─────────────────────┘
```

---

## 🚀 Cara Menjalankan

### 1. Persiapan

```bash
# Pastikan Docker sudah terinstall
docker --version
docker-compose --version

# Clone atau extract project
cd Vmware_Kos-Kosan
```

### 2. Build dan Run

```bash
# Build image dan start containers
docker-compose up --build -d

# Cek status
docker-compose ps

# Output expected:
# NAME               STATUS    PORTS
# koskosan_mysql     running   0.0.0.0:3306->3306/tcp
# koskosan_web       running   0.0.0.0:3000->3000/tcp
```

### 3. Akses Aplikasi

- **Website**: http://localhost:3000
- **Admin Panel**: http://localhost:3000/admin/login
- **Credentials**: admin / admin123

### 4. Testing

**Test Public Pages:**
1. Buka http://localhost:3000
2. Lihat daftar kamar
3. Coba filter dan search
4. Klik "Lihat Detail" pada salah satu kamar
5. Isi form booking dan submit

**Test Admin Panel:**
1. Login di http://localhost:3000/admin/login
2. Lihat dashboard dan statistics
3. Tambah kamar baru
4. Edit dan hapus kamar
5. Approve/reject pemesanan

### 5. Stop Aplikasi

```bash
# Stop tanpa menghapus data
docker-compose down

# Stop dan hapus semua data (reset)
docker-compose down -v
```

---

## 📊 Monitoring & Debugging

### Lihat Logs

```bash
# Logs semua container
docker-compose logs -f

# Logs container tertentu
docker-compose logs -f web
docker-compose logs -f mysql
```

### Cek Resource Usage

```bash
docker stats
```

### Masuk ke Container

```bash
# Masuk ke web container
docker exec -it koskosan_web sh

# Masuk ke MySQL container
docker exec -it koskosan_mysql bash

# Connect ke MySQL CLI
docker exec -it koskosan_mysql mysql -u root -proot koskosan_db
```

---

## 🔐 Security Features

1. **Password Hashing**: Menggunakan bcrypt dengan salt rounds 10
2. **Session Management**: Secure session dengan secret key
3. **SQL Injection Prevention**: Menggunakan prepared statements
4. **Input Validation**: Validasi di client-side dan server-side
5. **Environment Variables**: Sensitive data tidak di-hardcode

---

## 📈 Scalability Considerations

### Horizontal Scaling
```yaml
# docker-compose.yml untuk scaling
services:
  web:
    deploy:
      replicas: 3  # 3 instance web server
      
  # Tambahkan load balancer
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    depends_on:
      - web
```

### Vertical Scaling
```yaml
services:
  web:
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 2G
        reservations:
          cpus: '1'
          memory: 1G
```

---

## 🎓 Pembelajaran Cloud Computing

### Konsep yang Diterapkan

1. **Containerization**
   - Aplikasi terisolasi dalam container
   - Portabilitas tinggi (run anywhere)
   - Consistency antara development dan production

2. **Microservices Architecture**
   - Web app dan database sebagai service terpisah
   - Loose coupling, high cohesion
   - Independent deployment

3. **Infrastructure as Code**
   - Semua konfigurasi dalam file (Dockerfile, docker-compose.yml)
   - Version control-able
   - Reproducible

4. **Configuration Management**
   - Environment variables untuk konfigurasi
   - Separation of concerns
   - Easy to change per environment

5. **Persistent Storage**
   - Docker volumes untuk data persistence
   - Data tidak hilang saat container restart
   - Backup dan restore capability

---

## 📝 Laporan Tugas

### Screenshot yang Diperlukan

1. ✅ Output `docker-compose ps` menunjukkan container running
2. ✅ Halaman landing page dengan daftar kamar
3. ✅ Halaman detail kamar
4. ✅ Form booking
5. ✅ Halaman login admin
6. ✅ Dashboard admin dengan tabel kamar
7. ✅ Dashboard admin dengan tabel pemesanan
8. ✅ Output `docker stats` menunjukkan resource usage

### Penjelasan yang Perlu Dituliskan

1. Arsitektur aplikasi dan alasan pemilihan teknologi
2. Penjelasan Dockerfile dan docker-compose.yml
3. Database schema dan relasi antar tabel
4. Fitur-fitur aplikasi dan cara kerjanya
5. Langkah-langkah deployment
6. Troubleshooting yang dilakukan (jika ada)
7. Kesimpulan dan pembelajaran

---

## 🎯 Kesimpulan

Aplikasi Website Kos-Kosan ini berhasil mendemonstrasikan:
- Implementasi aplikasi full-stack dengan Node.js dan MySQL
- Containerization dengan Docker untuk portabilitas
- Orchestration dengan Docker Compose untuk multi-container app
- Configuration management dengan environment variables
- Data persistence dengan Docker volumes
- Best practices dalam web development dan cloud deployment

Aplikasi ini siap di-deploy ke berbagai platform cloud seperti AWS, GCP, Azure, atau DigitalOcean dengan minimal modification.

---

**Selamat Mengerjakan Tugas! 🎓**
