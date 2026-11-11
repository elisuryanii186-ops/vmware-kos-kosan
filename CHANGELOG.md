# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2024-11-11

### 🎉 Initial Release

#### ✨ Features
- **Public Website**
  - Landing page with list of available rooms
  - Filter by room type (Single, Double, VIP)
  - Filter by status (Available, Occupied, Maintenance)
  - Search by room name or facilities
  - Room detail page with full information
  - Online booking form with validation
  - Toast notifications for user feedback
  - Fully responsive design (mobile-friendly)

- **Admin Panel**
  - Secure login with bcrypt password hashing
  - Session-based authentication
  - Dashboard with statistics (total rooms, available rooms, pending bookings)
  - CRUD operations for rooms (Create, Read, Update, Delete)
  - Booking management (View, Approve, Reject)
  - Automatic room status update on booking approval
  - Logout functionality

#### 🛠️ Technical Implementation
- **Backend**: Node.js with Express.js framework
- **Database**: MySQL 8.0 with connection pooling
- **Template Engine**: EJS for server-side rendering
- **Frontend**: Bootstrap 5 with Bootstrap Icons
- **Security**: bcrypt password hashing, prepared SQL statements
- **Session**: express-session for authentication
- **Containerization**: Docker with multi-container setup

#### 🐳 Docker Setup
- Dockerfile for Node.js application
- docker-compose.yml for orchestration
- MySQL container with automatic schema initialization
- Named volumes for data persistence
- Custom bridge network for container communication
- Health check for MySQL container
- Environment-based configuration

#### 📦 Database Schema
- `users` table for admin authentication
- `kamar` table for room data
- `pemesanan` table for bookings
- Foreign key relationships
- Seed data with 8 sample rooms and 3 sample bookings

#### 📚 Documentation
- README.md with comprehensive documentation
- QUICK_START.md for fast setup
- TUGAS.md for university assignment explanation
- DEPLOYMENT.md for cloud deployment guides
- CARA_MENJALANKAN.txt for step-by-step instructions (Indonesian)
- COMMANDS.txt with Docker command cheatsheet

#### 🎓 Educational Value
- Perfect for Cloud Computing course projects
- Demonstrates containerization concepts
- Shows multi-container orchestration
- Implements full-stack development
- Includes security best practices
- Production-ready architecture

#### 📝 Seed Data
- 1 admin user (username: admin, password: admin123)
- 8 sample rooms with various types and prices
- 3 sample bookings with different statuses

### 🔧 Configuration
- Environment variables for all sensitive data
- Separate .env.example template
- Docker Compose with configurable ports
- MySQL credentials configurable via environment

### 🎨 UI/UX
- Modern gradient navbar
- Card-based design for rooms
- Color-coded status badges
- Smooth hover effects
- Modal forms for better UX
- Breadcrumb navigation
- Custom 404 page

### 🔒 Security Features
- Password hashing with bcrypt (10 salt rounds)
- Session-based authentication with secret key
- SQL injection prevention via prepared statements
- Input validation on client and server side
- Environment variables for sensitive data
- Protected admin routes with middleware

### 🚀 Deployment Ready
- Dockerized for portability
- Works on any platform with Docker
- Easy to scale horizontally or vertically
- Guides for AWS EC2, GCP, DigitalOcean, Heroku
- Nginx reverse proxy configuration included

---

## Future Enhancements (Planned)

### Version 1.1.0 (Planned)
- [ ] Image upload for rooms
- [ ] Email notifications for bookings
- [ ] User registration for tenants
- [ ] Payment integration
- [ ] Room availability calendar
- [ ] Tenant portal
- [ ] Contract management
- [ ] Billing system

### Version 1.2.0 (Planned)
- [ ] RESTful API endpoints
- [ ] Mobile app (React Native)
- [ ] Advanced analytics dashboard
- [ ] Multi-language support
- [ ] Dark mode
- [ ] Export data to PDF/Excel

### Version 2.0.0 (Planned)
- [ ] Microservices architecture
- [ ] Message queue (RabbitMQ/Kafka)
- [ ] Redis caching
- [ ] Elasticsearch for advanced search
- [ ] Real-time chat support
- [ ] AI-powered room recommendations

---

## Known Issues

### Version 1.0.0
- Room images use placeholder URLs (need to add actual images to public/images/)
- No email notifications (manual confirmation needed)
- Admin password change feature not implemented yet
- No pagination for large datasets
- Basic error handling (can be improved)

---

## Contributing

Contributions are welcome! Please follow these guidelines:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## Versioning

We use [SemVer](http://semver.org/) for versioning.

- **MAJOR** version for incompatible API changes
- **MINOR** version for backward-compatible functionality additions
- **PATCH** version for backward-compatible bug fixes

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Authors

- **Initial Development** - Created for Cloud Computing course project

---

## Acknowledgments

- Bootstrap team for the amazing CSS framework
- Express.js community
- Docker for containerization technology
- MySQL team
- Node.js community
- All contributors and users

---

**Last Updated**: November 11, 2024
