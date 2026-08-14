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

echo "Memeriksa database dan Discord..."
if ! node scripts/diagnose.js; then
  echo "[ERROR] Konfigurasi database belum siap. Jalankan: npm run migrate:termux"
  exit 1
fi

# Mencegah Android menidurkan proses jika Termux:API tersedia.
command -v termux-wake-lock >/dev/null 2>&1 && termux-wake-lock || true

BOT_PID=""
if node -e "require('dotenv').config({quiet:true}); process.exit(process.env.DISCORD_TOKEN ? 0 : 1)"; then
  echo "Menyalakan Discord Bot..."
  node bot.js >"$APP_DIR/discord-bot.log" 2>&1 &
  BOT_PID=$!
  echo "$BOT_PID" > "$APP_DIR/.discord-bot.pid"
  sleep 2
  if kill -0 "$BOT_PID" >/dev/null 2>&1; then
    echo "Discord Bot berhasil aktif (PID $BOT_PID)."
  else
    echo "[WARNING] Discord Bot gagal aktif. Detail:"
    tail -n 12 "$APP_DIR/discord-bot.log" || true
    BOT_PID=""
  fi
else
  echo "[INFO] DISCORD_TOKEN belum diisi; website hidup tanpa bot."
fi

cleanup() {
  [[ -n "$BOT_PID" ]] && kill "$BOT_PID" >/dev/null 2>&1 || true
  command -v termux-wake-unlock >/dev/null 2>&1 && termux-wake-unlock || true
}
trap cleanup EXIT INT TERM

printf '\nHope Pride Roleplay aktif. Jangan tutup sesi Termux ini.\n'
printf 'Buka http://127.0.0.1:3000 lalu tekan Ctrl+C untuk berhenti.\n'
printf 'Log Discord Bot: %s/discord-bot.log\n\n' "$APP_DIR"
npm start
