# Hope Pride Roleplay — Website & UCP

Website komunitas dan User Control Panel modern untuk **Hope Pride Roleplay SA-MP**. Backend dibuat sesuai struktur database `hope.sql` yang sudah ada, tanpa mengubah tabel game.

## Fitur

- Landing page responsif dengan status server, fitur, panduan, dan komunitas
- Login UCP menggunakan tabel `ucp` dan verifikasi hash bcrypt `$2b$`
- Registrasi UCP langsung ke kolom yang sudah tersedia (`username`, `password`, `ip`, `verifycode`, `discordid`, dan lainnya)
- Dashboard karakter IC dari tabel `players`
- Kendaraan (`vehicle`), rumah (`houses`), inventori (`inventory`), dan gaji (`salary`)
- Statistik publik dari database dengan graceful fallback saat database offline
- Demo UCP agar tampilan bisa diuji tanpa koneksi database
- Session aman, Helmet, rate limit autentikasi, parameterized query, dan validasi input

## Menjalankan lokal

1. Gunakan Node.js 18 atau lebih baru.
2. Import `hope.sql` ke MariaDB/MySQL:
   ```sql
   CREATE DATABASE hope;
   ```
   Lalu import melalui phpMyAdmin atau terminal.
3. Salin konfigurasi:
   ```bash
   cp .env.example .env
   ```
4. Isi koneksi database di `.env`.
5. Instal dan jalankan:
   ```bash
   npm install
   npm run dev
   ```
6. Buka `http://localhost:3000`.

Jika variabel `DB_HOST` belum diisi, website tetap berjalan dalam mode tampilan dan statistik demo. Klik **Lihat Demo UCP** pada dialog login.

## Kesesuaian database

| Fitur web | Tabel / relasi |
|---|---|
| Akun UCP | `ucp.id`, `ucp.username` |
| Character IC | `players.ucp = ucp.username` |
| Kendaraan | `vehicle.owner = players.reg_id` |
| Rumah | `houses.owner = players.username` |
| Inventori | `inventory.ownerid = players.reg_id` |
| Riwayat gaji | `salary.owner = players.reg_id` |

Password registrasi memakai bcrypt cost 12 agar kompatibel dengan hash yang sudah tersimpan dalam dump. Akun dengan `verifystatus = 0` harus diverifikasi melalui bot Discord sebelum dapat login.

## Instalasi otomatis di Termux (Android)

> Gunakan Termux dari **F-Droid atau GitHub resmi**, bukan versi Play Store yang sudah usang.

Di Termux, jalankan:

```bash
pkg update -y
pkg install -y git
git clone -b arena/019ffe50-hopeprideweb https://github.com/valngawi-droid/hopeprideweb.git
cd hopeprideweb
bash scripts/termux-install.sh
```

Installer otomatis memasang Node.js dan MariaDB, mengimpor `hope.sql`, membuat user database terbatas, membuat password acak, serta mengisi `.env`. Sesudah selesai, jalankan:

```bash
bash scripts/termux-start.sh
```

Buka **http://127.0.0.1:3000** pada browser HP. Jangan tutup Termux selama server digunakan. Hentikan website dengan `Ctrl+C`; MariaDB dapat dihentikan dengan:

```bash
bash scripts/termux-stop.sh
```

Agar Android tidak mematikan server, nonaktifkan optimasi baterai untuk Termux. Jika ingin `termux-wake-lock`, instal aplikasi Termux:API dan jalankan `pkg install termux-api`.

### Membuka dari perangkat lain

Pastikan perangkat berada pada Wi-Fi yang sama. Cari IP HP dengan `ip addr`, lalu buka `http://IP-HP:3000`. Jangan membuka port ini ke internet secara langsung karena server Termux lokal belum memakai HTTPS.

## Deployment

Jalankan `npm start` menggunakan PM2, systemd, Railway, Render, VPS, atau panel hosting yang mendukung Node.js. Di production, wajib gunakan nilai `SESSION_SECRET` acak dan `NODE_ENV=production` di balik HTTPS/reverse proxy.

> Catatan: alamat server dan tautan Discord saat ini berupa placeholder di `public/index.html`; ganti dengan alamat resmi Hope Pride.
