const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const db = require('../config/database');

// Middleware untuk cek login (DISABLED untuk demo)
function isAuthenticated(req, res, next) {
    // Auto-login untuk demo/testing
    req.session.adminLoggedIn = true;
    req.session.adminUsername = 'admin';
    return next();
    
    /* Original code (re-enable untuk production):
    if (req.session.adminLoggedIn) {
        return next();
    }
    res.redirect('/admin/login');
    */
}

// Login Page (AUTO REDIRECT untuk demo)
router.get('/login', (req, res) => {
    // Auto-login dan redirect ke dashboard
    req.session.adminLoggedIn = true;
    req.session.adminUsername = 'admin';
    return res.redirect('/admin/dashboard');
    
    /* Original code (re-enable untuk production):
    if (req.session.adminLoggedIn) {
        return res.redirect('/admin/dashboard');
    }
    res.render('admin/login', { title: 'Admin Login', error: null });
    */
});

// Login Process
router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;
        
        const [users] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
        
        if (users.length === 0) {
            return res.render('admin/login', { title: 'Admin Login', error: 'Username atau password salah!' });
        }
        
        const user = users[0];
        const match = await bcrypt.compare(password, user.password);
        
        if (!match) {
            return res.render('admin/login', { title: 'Admin Login', error: 'Username atau password salah!' });
        }
        
        req.session.adminLoggedIn = true;
        req.session.adminUsername = user.username;
        res.redirect('/admin/dashboard');
    } catch (error) {
        console.error('Error:', error);
        res.render('admin/login', { title: 'Admin Login', error: 'Terjadi kesalahan server' });
    }
});

// Logout
router.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/admin/login');
});

// Dashboard
router.get('/dashboard', isAuthenticated, async (req, res) => {
    try {
        const [kamarList] = await db.query('SELECT * FROM kamar ORDER BY id ASC');
        const [pemesananList] = await db.query(`
            SELECT p.*, k.nama_kamar, k.tipe, k.harga_per_bulan 
            FROM pemesanan p 
            JOIN kamar k ON p.id_kamar = k.id 
            ORDER BY p.created_at DESC
        `);
        
        res.render('admin/dashboard', {
            title: 'Admin Dashboard',
            username: req.session.adminUsername,
            kamarList,
            pemesananList
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Internal Server Error');
    }
});

// API: Tambah Kamar
router.post('/kamar/add', isAuthenticated, async (req, res) => {
    try {
        const { nama_kamar, tipe, harga_per_bulan, fasilitas, status } = req.body;
        
        await db.query(
            'INSERT INTO kamar (nama_kamar, tipe, harga_per_bulan, fasilitas, status) VALUES (?, ?, ?, ?, ?)',
            [nama_kamar, tipe, harga_per_bulan, fasilitas, status]
        );
        
        res.json({ success: true, message: 'Kamar berhasil ditambahkan!' });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan server' });
    }
});

// API: Update Kamar
router.post('/kamar/update/:id', isAuthenticated, async (req, res) => {
    try {
        const { nama_kamar, tipe, harga_per_bulan, fasilitas, status } = req.body;
        
        await db.query(
            'UPDATE kamar SET nama_kamar = ?, tipe = ?, harga_per_bulan = ?, fasilitas = ?, status = ? WHERE id = ?',
            [nama_kamar, tipe, harga_per_bulan, fasilitas, status, req.params.id]
        );
        
        res.json({ success: true, message: 'Kamar berhasil diupdate!' });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan server' });
    }
});

// API: Delete Kamar
router.post('/kamar/delete/:id', isAuthenticated, async (req, res) => {
    try {
        await db.query('DELETE FROM kamar WHERE id = ?', [req.params.id]);
        res.json({ success: true, message: 'Kamar berhasil dihapus!' });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan server' });
    }
});

// API: Update Status Pemesanan
router.post('/pemesanan/status/:id', isAuthenticated, async (req, res) => {
    try {
        const { status } = req.body;
        
        await db.query('UPDATE pemesanan SET status = ? WHERE id = ?', [status, req.params.id]);
        
        // Jika disetujui, ubah status kamar jadi terisi
        if (status === 'Disetujui') {
            const [pemesanan] = await db.query('SELECT id_kamar FROM pemesanan WHERE id = ?', [req.params.id]);
            if (pemesanan.length > 0) {
                await db.query('UPDATE kamar SET status = ? WHERE id = ?', ['Terisi', pemesanan[0].id_kamar]);
            }
        }
        
        res.json({ success: true, message: 'Status pemesanan berhasil diupdate!' });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan server' });
    }
});

// API: Delete Pemesanan
router.post('/pemesanan/delete/:id', isAuthenticated, async (req, res) => {
    try {
        await db.query('DELETE FROM pemesanan WHERE id = ?', [req.params.id]);
        res.json({ success: true, message: 'Pemesanan berhasil dihapus!' });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan server' });
    }
});

module.exports = router;
