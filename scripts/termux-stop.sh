#!/data/data/com.termux/files/usr/bin/bash
set -u

# Website yang berjalan di foreground dihentikan dengan Ctrl+C.
# Script ini mematikan layanan MariaDB lokal secara bersih.
if mariadb-admin ping --silent >/dev/null 2>&1; then
  mariadb-admin -u root shutdown
  echo "MariaDB dihentikan."
else
  echo "MariaDB tidak sedang berjalan."
fi

command -v termux-wake-unlock >/dev/null 2>&1 && termux-wake-unlock || true
