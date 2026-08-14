#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

# Installer lengkap Hope Pride Roleplay untuk Termux.
# Jalankan dari root repository: bash scripts/termux-install.sh

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DB_DIR="${PREFIX}/var/lib/mysql"
DB_NAME="hope"
DB_USER="hope_web"
ENV_FILE="${APP_DIR}/.env"

if [[ -z "${PREFIX:-}" || ! -d "/data/data/com.termux" ]]; then
  echo "[ERROR] Script ini hanya untuk aplikasi Termux resmi."
  exit 1
fi

printf '\n\033[1;32mHope Pride Roleplay — Termux Installer\033[0m\n'
printf 'Folder aplikasi: %s\n\n' "$APP_DIR"

pkg update -y
pkg install -y nodejs-lts mariadb git

cd "$APP_DIR"
echo "[1/5] Menginstal package website..."
npm ci --omit=dev

echo "[2/5] Menyiapkan MariaDB..."
mkdir -p "$DB_DIR"
if [[ ! -d "$DB_DIR/mysql" ]]; then
  mariadb-install-db --datadir="$DB_DIR" --auth-root-authentication-method=normal >/dev/null
fi

if ! mariadb-admin ping --silent >/dev/null 2>&1; then
  nohup mariadbd-safe --datadir="$DB_DIR" >"$APP_DIR/mariadb.log" 2>&1 &
  echo $! > "$APP_DIR/.mariadb.pid"
  for _ in {1..30}; do
    mariadb-admin ping --silent >/dev/null 2>&1 && break
    sleep 1
  done
fi

if ! mariadb-admin ping --silent >/dev/null 2>&1; then
  echo "[ERROR] MariaDB tidak berhasil hidup. Periksa mariadb.log."
  exit 1
fi

# Gunakan crypto bawaan Node.js supaya tidak bergantung pada binary openssl-tool.
DB_PASSWORD="$(node -e "process.stdout.write(require('crypto').randomBytes(16).toString('hex'))")"
SESSION_SECRET="$(node -e "process.stdout.write(require('crypto').randomBytes(32).toString('hex'))")"

echo "[3/5] Membuat database dan user website..."
mariadb -u root <<SQL
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET latin1 COLLATE latin1_swedish_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}';
ALTER USER '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}';
GRANT SELECT, INSERT, UPDATE ON \`${DB_NAME}\`.* TO '${DB_USER}'@'127.0.0.1';
FLUSH PRIVILEGES;
SQL

TABLE_EXISTS="$(mariadb -u root -Nse "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}' AND table_name='ucp'" 2>/dev/null || echo 0)"
if [[ "$TABLE_EXISTS" == "0" ]]; then
  echo "[4/5] Mengimpor hope.sql (mungkin perlu beberapa menit)..."
  mariadb -u root "$DB_NAME" < "$APP_DIR/hope.sql"
else
  echo "[4/5] Database lama ditemukan; import dilewati agar data tidak tertimpa."
fi

cat > "$ENV_FILE" <<ENV
PORT=3000
NODE_ENV=development
SESSION_SECRET=${SESSION_SECRET}
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=${DB_NAME}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
DB_POOL_SIZE=5
ENV
chmod 600 "$ENV_FILE"

echo "[5/5] Memeriksa aplikasi..."
npm run check

printf '\n\033[1;32mInstalasi selesai!\033[0m\n'
printf 'Jalankan website dengan:\n  cd %s\n  bash scripts/termux-start.sh\n\n' "$APP_DIR"
printf 'Lalu buka: \033[1mhttp://127.0.0.1:3000\033[0m\n'
printf 'Untuk perangkat lain dalam Wi-Fi yang sama, gunakan IP HP, contoh http://192.168.1.5:3000\n'
