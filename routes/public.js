const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Homepage - Daftar Kamar
router.get('/', async (req, res) => {
    try {
        const { tipe, status, search } = req.query;
        
        let query = 'SELECT * FROM kamar WHERE 1=1';
        const params = [];
        
        // Filter berdasarkan tipe
        if (tipe && tipe !== 'Semua') {
            query += ' AND tipe = ?';
            params.push(tipe);
        }
        
        // Filter berdasarkan status
        if (status && status !== 'Semua') {
            query += ' AND status = ?';
            params.push(status);
        }
        
        // Search by nama kamar atau fasilitas
        if (search) {
            query += ' AND (nama_kamar LIKE ? OR fasilitas LIKE ?)';
            params.push(`%${search}%`, `%${search}%`);
        }
        
        query += ' ORDER BY id ASC';
        
        const [kamarList] = await db.query(query, params);
        
        res.render('public/index', {
            title: 'Website Kos-Kosan',
            kamarList,
            filter: { tipe: tipe || 'Semua', status: status || 'Semua', search: search || '' }
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Internal Server Error');
    }
});

// Detail Kamar
router.get('/kamar/:id', async (req, res) => {
    try {
        const [kamar] = await db.query('SELECT * FROM kamar WHERE id = ?', [req.params.id]);
        
        if (kamar.length === 0) {
            return res.status(404).send('Kamar tidak ditemukan');
        }
        
        res.render('public/detail', {
            title: kamar[0].nama_kamar,
            kamar: kamar[0]
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Internal Server Error');
    }
});

// Form Booking
router.post('/booking', async (req, res) => {
    try {
        const { id_kamar, nama_pemesan, email, no_telepon, tanggal_mulai, durasi_bulan, catatan } = req.body;
        
        // Validasi sederhana
        if (!id_kamar || !nama_pemesan || !email || !no_telepon || !tanggal_mulai || !durasi_bulan) {
            return res.status(400).json({ success: false, message: 'Semua field harus diisi!' });
        }
        
        // Cek apakah kamar tersedia
        const [kamar] = await db.query('SELECT status FROM kamar WHERE id = ?', [id_kamar]);
        
        if (kamar.length === 0) {
            return res.status(404).json({ success: false, message: 'Kamar tidak ditemukan!' });
        }
        
        if (kamar[0].status !== 'Tersedia') {
            return res.status(400).json({ success: false, message: 'Kamar tidak tersedia!' });
        }
        
        // Insert pemesanan
        await db.query(
            'INSERT INTO pemesanan (id_kamar, nama_pemesan, email, no_telepon, tanggal_mulai, durasi_bulan, catatan) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [id_kamar, nama_pemesan, email, no_telepon, tanggal_mulai, durasi_bulan, catatan || null]
        );
        
        res.json({ success: true, message: 'Pemesanan berhasil! Mohon tunggu konfirmasi admin.' });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan server' });
    }
});

module.exports = router;
