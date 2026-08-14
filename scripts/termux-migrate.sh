#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$APP_DIR"
if ! command -v mariadb >/dev/null 2>&1; then echo "MariaDB belum terpasang."; exit 1; fi
if ! mariadb-admin ping --silent >/dev/null 2>&1; then echo "MariaDB belum aktif. Jalankan termux-start.sh dahulu."; exit 1; fi
mariadb -u root hope < migrations/001_web_forum.sql
echo "Migrasi forum berhasil. Tabel web_forum_* siap digunakan."
