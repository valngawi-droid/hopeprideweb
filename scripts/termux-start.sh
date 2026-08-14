#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DB_DIR="${PREFIX}/var/lib/mysql"
cd "$APP_DIR"

if [[ ! -f .env ]]; then
  echo "[ERROR] File .env belum ada. Jalankan: bash scripts/termux-install.sh"
  exit 1
fi

if ! mariadb-admin ping --silent >/dev/null 2>&1; then
  echo "Menyalakan MariaDB..."
  nohup mariadbd-safe --datadir="$DB_DIR" >"$APP_DIR/mariadb.log" 2>&1 &
  echo $! > "$APP_DIR/.mariadb.pid"
  for _ in {1..30}; do
    mariadb-admin ping --silent >/dev/null 2>&1 && break
    sleep 1
  done
fi

if ! mariadb-admin ping --silent >/dev/null 2>&1; then
  echo "[ERROR] MariaDB gagal hidup. Periksa $APP_DIR/mariadb.log"
  exit 1
fi

# Mencegah Android menidurkan proses jika Termux:API tersedia.
command -v termux-wake-lock >/dev/null 2>&1 && termux-wake-lock || true

printf '\nHope Pride Roleplay aktif. Jangan tutup sesi Termux ini.\n'
printf 'Buka http://127.0.0.1:3000 lalu tekan Ctrl+C untuk berhenti.\n\n'
exec npm start
