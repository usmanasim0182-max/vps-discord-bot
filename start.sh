#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [[ "${EUID}" -ne 0 ]]; then
  echo "ERROR: This bot must run as root because it creates/manages LXC containers."
  echo "Run: sudo ./start.sh"
  exit 1
fi

exec ./.venv/bin/python bot.py
