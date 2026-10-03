#!/usr/bin/env bash
set -euo pipefail
if [[ "${EUID}" -ne 0 ]]; then echo "Run as root: sudo ./install-service.sh"; exit 1; fi
install -d /opt/native-vps-discord-bot
cp -a . /opt/native-vps-discord-bot/
systemctl daemon-reload
systemctl enable --now native-vps-bot.service
systemctl status native-vps-bot.service --no-pager
