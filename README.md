# Hope Pride Roleplay — Website & UCP

Website komunitas dan User Control Panel modern untuk **Hope Pride Roleplay SA-MP**. Backend dibuat sesuai struktur database `hope.sql` yang sudah ada, tanpa mengubah tabel game.

## Fitur

- Landing page responsif dengan status server, fitur, panduan, dan komunitas
- Login UCP menggunakan tabel `ucp` dan verifikasi hash bcrypt `$2b$`
- Registrasi UCP langsung ke kolom yang tersedia dan menampilkan PIN aktivasi in-game dari `ucp.verifycode`
- Dashboard karakter IC dari tabel `players`
- Kendaraan (`vehicle`), rumah (`houses`), bisnis (`bisnis`), inventori (`inventory`), dan gaji (`salary`)
- Direktori kota realtime untuk warung, toko umum, toko pakaian, dan usaha khusus
- Admin dapat menambahkan bisnis, voucher, dan family langsung dari panel atau Discord
- Forum komunitas berbasis UCP: kategori, topic, balasan, pencarian, pin, dan lock
- Daftar staff/admin langsung dari `players.admin` dan `players.helper`
- Backup database `.sql` streaming dari Admin Panel, dibatasi lima kali per jam
- Animasi halus, mobile navigation, responsive cards, dan dukungan reduced-motion
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
| Warung / toko / pakaian | `bisnis.owner = players.username`, `bisnis.type` |
| Voucher admin | `vouchers` |
| Family admin | `familys` |
| Forum kategori | `web_forum_categories` |
| Forum topic | `web_forum_topics` |
| Forum balasan | `web_forum_posts` |
| Daftar staff | `players.admin`, `players.helper`, `ucp.discordid` |
| Inventori | `inventory.ownerid = players.reg_id` |
| Riwayat gaji | `salary.owner = players.reg_id` |

Password registrasi memakai bcrypt cost 12 agar kompatibel dengan hash yang sudah tersimpan dalam dump. PIN aktivasi in-game menggunakan format `HP-######` dan disimpan pada kolom asli `ucp.verifycode`. PIN ditampilkan setelah registrasi serta pada Ringkasan dan Pengaturan UCP. Akun dengan `verifystatus = 0` harus diverifikasi melalui bot Discord sebelum dapat login.

## Administrator Command Center

Admin UI kini memakai enam tab responsif agar tidak menumpuk dalam satu halaman: **Overview, UCP & Player, Economy, City Assets, Security Log,** dan **Create Tools**. Fitur administrasi yang tersedia:

1. Session login persisten tujuh hari
2. Auto-restore halaman UCP setelah refresh
3. Dashboard KPI realtime
4. Database size dan jumlah tabel
5. Daftar staff dan administrator
6. Status verifikasi staff
7. Pencarian UCP dan Discord ID
8. Verifikasi/unverify UCP
9. Reset PIN in-game
10. Ganti Discord ID pemain
11. Backup SQL streaming
12. Export UCP ke CSV
13. Monitor staff command terbaru
14. Audit log lengkap
15. Daftar blacklist
16. Monitor warn dan jail
17. Daftar pemain VIP
18. Statistik distribusi job
19. Statistik distribusi faction
20. Server treasury monitor
21. Stok material, component, gas, product, dan food
22. Daftar harga ekonomi server
23. Top item inventory
24. Direktori bisnis admin
25. Direktori family admin
26. Direktori workshop admin
27. Monitor voucher
28. Membuat bisnis
29. Membuat voucher
30. Membuat family

Pada HP, menu admin berubah menjadi tab horizontal, tabel dapat digeser, kartu menjadi satu kolom, dan action button membungkus otomatis. Pada PC, data memakai grid dan panel multi-kolom.

## Migrasi forum dan backup

Website menggunakan empat tabel berawalan `web_` (`web_sessions` dan tiga tabel forum) agar tidak mengganggu gamemode. Pada instalasi baru migrasi diterapkan otomatis. Untuk instalasi Termux yang sudah berjalan:

```bash
cd ~/hopeprideweb
npm run migrate:termux
```

Migrasi bersifat idempotent: aman dijalankan berulang dan tidak menghapus topic. Backup tersedia di **UCP → Admin Panel → Download .SQL**. File dibuat langsung oleh `mariadb-dump`, tidak disimpan di folder publik, hanya tersedia untuk admin, dan dibatasi lima unduhan per jam.

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
- `/admin-add-bisnis`, `/admin-voucher` — membuat bisnis atau voucher langsung dari Discord

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
