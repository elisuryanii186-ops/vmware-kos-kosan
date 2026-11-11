const mysql = require('mysql2');
require('dotenv').config();

// Konfigurasi koneksi database dari environment variables
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'koskosan_db',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Promise wrapper untuk async/await
const promisePool = pool.promise();

// Test koneksi
pool.getConnection((err, connection) => {
    if (err) {
        console.error('❌ Error connecting to database:', err.message);
        return;
    }
    console.log('✅ Database connected successfully!');
    connection.release();
});

module.exports = promisePool;
