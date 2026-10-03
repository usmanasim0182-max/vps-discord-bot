#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  SUDO=sudo
else
  SUDO=
fi

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  python3 python3-venv python3-pip \
  lxc lxc-utils lxc-templates bridge-utils debootstrap uidmap \
  curl wget ca-certificates

# Enable LXC networking services when available.
if systemctl list-unit-files | grep -q '^lxc-net.service'; then
  systemctl enable --now lxc-net.service || true
fi

# Create an isolated Python environment for the Discord bot.
if [[ ! -d .venv ]]; then
  python3 -m venv .venv
fi
./.venv/bin/python -m pip install --upgrade pip wheel
./.venv/bin/pip install -r requirements.txt

if [[ ! -f .env ]]; then
  cp .env.example .env
  echo "Created .env from .env.example. Edit TOKEN and ADMIN_ID before starting."
fi

chmod +x start.sh stop.sh

echo
echo "Installation complete."
echo "1) Edit .env"
echo "2) Make sure the host allows the bot to run as root (LXC creation requires root)."
echo "3) Run: sudo ./start.sh"
