# Hope Pride Roleplay — Website & UCP

Website komunitas dan User Control Panel modern untuk **Hope Pride Roleplay SA-MP**. Backend dibuat sesuai struktur database `hope.sql` yang sudah ada, tanpa mengubah tabel game.

## Fitur

- Landing page responsif dengan status server, fitur, panduan, dan komunitas
- Login UCP menggunakan tabel `ucp` dan verifikasi hash bcrypt `$2b$`
- Registrasi UCP langsung ke kolom yang sudah tersedia (`username`, `password`, `ip`, `verifycode`, `discordid`, dan lainnya)
- Dashboard karakter IC dari tabel `players`
- Kendaraan (`vehicle`), rumah (`houses`), inventori (`inventory`), dan gaji (`salary`)
- Statistik publik dari database dengan graceful fallback saat database offline
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

Website adalah mode produksi tanpa data contoh. Jika database belum terhubung, status menampilkan **Database Offline**, statistik menjadi nol, dan autentikasi ditolak sampai konfigurasi diperbaiki.

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

## Discord Bot

Bot menggunakan database `hope.sql` yang sama dan menyediakan slash command:

- `/id` — menampilkan Discord User ID
- `/verify kode` — memverifikasi `ucp.verifycode` dan mencocokkan `ucp.discordid`
- `/akun` dan `/karakter` — informasi akun serta character IC milik pengguna
- `/server`, `/leaderboard`, `/bantuan` — statistik, peringkat, dan bantuan
- `/aset`, `/inventori` — aset serta item character dari database
- `/reset-password` — reset password aman melalui Discord yang sudah terhubung
- `/admin-stats`, `/admin-ucp`, `/admin-player`, `/admin-cari` — pencarian dan alat administrator
- `/admin-discord`, `/admin-reset-verifikasi` — reset Discord ID dan verifikasi UCP

Akses admin diberikan jika pengguna memiliki permission **Administrator** Discord, role pada `DISCORD_ADMIN_ROLE_ID`, `ucp.admin > 0`, atau salah satu character miliknya memiliki `players.admin > 0`.

1. Buka Discord Developer Portal dan buat/reset bot token.
2. Aktifkan scope `bot` dan `applications.commands` pada URL Generator, lalu undang bot ke server.
3. Isi `.env` (token tidak boleh dimasukkan ke Git):
   ```env
   DISCORD_CLIENT_ID=1457210040871161977
   DISCORD_TOKEN=token-baru-dari-developer-portal
   DISCORD_GUILD_ID=id-server-discord
   DISCORD_ADMIN_ROLE_ID=id-role-admin
   ```
4. Jalankan `npm run bot`. Pada Termux, `termux-start.sh` otomatis menyalakan bot jika token telah diisi.

Bot mendaftarkan command ke guild jika `DISCORD_GUILD_ID` tersedia sehingga command muncul cepat. Tanpa Guild ID, command didaftarkan secara global dan dapat membutuhkan waktu untuk muncul.

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
