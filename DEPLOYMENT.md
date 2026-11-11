# 🚀 Panduan Deployment Website Kos-Kosan

## Panduan Lengkap untuk Deploy di Berbagai Platform

---

## 📦 Deployment dengan Docker (Local/VM)

### Prasyarat
- Docker Desktop atau Docker Engine terinstall
- Docker Compose terinstall
- Minimal 2GB RAM tersedia
- Port 3000 dan 3306 tidak digunakan

### Langkah-langkah

1. **Pastikan Docker sudah berjalan**
   ```bash
   docker --version
   docker-compose --version
   ```

2. **Masuk ke direktori project**
   ```bash
   cd Vmware_Kos-Kosan
   ```

3. **Build dan jalankan dengan Docker Compose**
   ```bash
   docker-compose up --build -d
   ```

4. **Cek status container**
   ```bash
   docker-compose ps
   ```

5. **Lihat logs (jika ada masalah)**
   ```bash
   docker-compose logs -f
   ```

6. **Akses aplikasi**
   - Website: http://localhost:3000
   - Admin: http://localhost:3000/admin/login

7. **Stop aplikasi**
   ```bash
   docker-compose down
   ```

8. **Reset database (hapus semua data)**
   ```bash
   docker-compose down -v
   docker-compose up -d
   ```

---

## ☁️ Deployment di AWS EC2

### Langkah-langkah

1. **Launch EC2 Instance**
   - AMI: Ubuntu 22.04 LTS
   - Instance Type: t2.micro (Free tier)
   - Security Group: Buka port 22 (SSH), 80 (HTTP), 3000

2. **Koneksi SSH ke EC2**
   ```bash
   ssh -i your-key.pem ubuntu@your-ec2-ip
   ```

3. **Install Docker & Docker Compose**
   ```bash
   # Update system
   sudo apt update && sudo apt upgrade -y

   # Install Docker
   sudo apt install docker.io -y
   sudo systemctl start docker
   sudo systemctl enable docker

   # Install Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose

   # Add user to docker group
   sudo usermod -aG docker $USER
   newgrp docker
   ```

4. **Clone atau Upload Project**
   ```bash
   # Menggunakan git (jika ada repository)
   git clone https://github.com/username/kos-kosan.git
   cd kos-kosan

   # Atau upload menggunakan SCP
   # Dari komputer local:
   # scp -i your-key.pem -r Vmware_Kos-Kosan ubuntu@your-ec2-ip:~/
   ```

5. **Jalankan Aplikasi**
   ```bash
   docker-compose up --build -d
   ```

6. **Setup Nginx sebagai Reverse Proxy (Optional)**
   ```bash
   sudo apt install nginx -y

   # Edit konfigurasi Nginx
   sudo nano /etc/nginx/sites-available/koskosan
   ```

   Isi file:
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;

       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

   ```bash
   sudo ln -s /etc/nginx/sites-available/koskosan /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

---

## 🌐 Deployment di DigitalOcean Droplet

### Langkah-langkah

1. **Buat Droplet**
   - Image: Docker on Ubuntu 22.04
   - Size: Basic ($6/month)
   - Region: Pilih terdekat

2. **SSH ke Droplet**
   ```bash
   ssh root@your-droplet-ip
   ```

3. **Upload dan Jalankan Project**
   ```bash
   # Upload project (dari local)
   scp -r Vmware_Kos-Kosan root@your-droplet-ip:~/

   # Di droplet
   cd Vmware_Kos-Kosan
   docker-compose up --build -d
   ```

4. **Setup Firewall**
   ```bash
   ufw allow 22
   ufw allow 80
   ufw allow 3000
   ufw enable
   ```

---

## 🐳 Deployment di Google Cloud Platform (GCP)

### Menggunakan Google Compute Engine

1. **Buat VM Instance**
   - Machine type: e2-micro (Free tier)
   - Boot disk: Ubuntu 22.04 LTS
   - Firewall: Allow HTTP, HTTPS traffic

2. **SSH dari Console atau gcloud CLI**

3. **Install Docker dan Deploy**
   (Ikuti langkah yang sama dengan AWS EC2)

### Menggunakan Google Cloud Run (Serverless)

1. **Push Image ke Container Registry**
   ```bash
   # Build image
   docker build -t gcr.io/PROJECT_ID/koskosan-web .

   # Push ke GCR
   docker push gcr.io/PROJECT_ID/koskosan-web

   # Deploy ke Cloud Run
   gcloud run deploy koskosan-web \
     --image gcr.io/PROJECT_ID/koskosan-web \
     --platform managed \
     --region asia-southeast2 \
     --allow-unauthenticated
   ```

---

## 📱 Deployment di Heroku

### Langkah-langkah

1. **Install Heroku CLI**
   ```bash
   curl https://cli-assets.heroku.com/install.sh | sh
   ```

2. **Login dan Setup**
   ```bash
   heroku login
   heroku create koskosan-app
   ```

3. **Add MySQL Addon**
   ```bash
   heroku addons:create jawsdb:kitefin
   ```

4. **Set Environment Variables**
   ```bash
   heroku config:set SESSION_SECRET=your_secret_key
   ```

5. **Deploy**
   ```bash
   git init
   heroku git:remote -a koskosan-app
   git add .
   git commit -m "Initial commit"
   git push heroku main
   ```

---

## 🔧 Konfigurasi Production

### Environment Variables untuk Production

Buat file `.env.production`:
```env
# Database
DB_HOST=your_production_db_host
DB_PORT=3306
DB_USER=your_db_user
DB_PASSWORD=your_strong_password
DB_NAME=koskosan_db

# Server
PORT=3000
NODE_ENV=production
SESSION_SECRET=your_very_strong_random_secret_key

# Admin
ADMIN_USERNAME=admin
ADMIN_PASSWORD=change_this_in_production
```

### Security Checklist

✅ Ganti password admin default
✅ Gunakan SESSION_SECRET yang kuat dan random
✅ Gunakan HTTPS (SSL/TLS certificate)
✅ Setup firewall yang proper
✅ Backup database secara berkala
✅ Update dependencies secara berkala
✅ Monitor logs aplikasi
✅ Batasi akses SSH hanya IP tertentu

---

## 🔄 Update Aplikasi

### Update di Docker

```bash
# Pull update terbaru
git pull origin main

# Rebuild dan restart
docker-compose down
docker-compose up --build -d
```

### Backup Database Sebelum Update

```bash
# Backup
docker exec koskosan_mysql mysqldump -u root -proot koskosan_db > backup_$(date +%Y%m%d).sql

# Restore jika diperlukan
docker exec -i koskosan_mysql mysql -u root -proot koskosan_db < backup_20240101.sql
```

---

## 📊 Monitoring

### Cek Resource Usage

```bash
# Lihat resource yang digunakan container
docker stats

# Lihat logs aplikasi
docker-compose logs -f web

# Lihat logs database
docker-compose logs -f mysql
```

### Setup Monitoring Tools (Optional)

- **Portainer**: UI untuk manage Docker
- **Prometheus + Grafana**: Monitoring & visualization
- **PM2**: Process manager untuk Node.js

---

## 🆘 Troubleshooting

### Container tidak bisa start
```bash
docker-compose logs
docker-compose down -v
docker-compose up --build
```

### Database connection error
```bash
# Cek apakah MySQL sudah ready
docker-compose logs mysql

# Restart container
docker-compose restart
```

### Port sudah digunakan
Edit `docker-compose.yml` dan ubah port mapping:
```yaml
ports:
  - "8080:3000"  # Ganti 8080 dengan port yang tersedia
```

### Memory issue
```bash
# Bersihkan unused images
docker system prune -a

# Increase swap (Linux)
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

---

## 📞 Support

Jika menemui masalah saat deployment, cek:
1. Log aplikasi: `docker-compose logs -f`
2. Status container: `docker-compose ps`
3. Network issues: `docker network ls`

---

**Happy Deploying! 🎉**
