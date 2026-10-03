# Native Ubuntu VPS Discord Bot — No Docker

This is a rebuilt version of the supplied Discord VPS bot. It uses **native LXC containers** on the Ubuntu host instead of Docker.

## Important architecture note

This creates isolated Linux containers, not KVM/QEMU virtual machines. It is therefore lightweight and does not require Docker, but it is not a hardware-virtualized VPS platform.

## Ubuntu requirements

- Ubuntu host with root/sudo access
- Internet access (the LXC `download` template downloads the selected OS image)
- Discord bot token
- Discord application commands enabled

## Install

```bash
unzip native-vps-discord-bot.zip
cd native-vps-discord-bot
sudo ./setup.sh
nano .env
sudo ./start.sh
```

The bot requires root because LXC container creation, cgroups, networking, and lifecycle operations are host-level operations.

## Commands

### User
- `/create <os>`
- `/list`
- `/vps-info [vps_id]`
- `/start <vps_id>`
- `/stop <vps_id>`
- `/restart <vps_id>`
- `/ssh [vps_id]`
- `/reinstall <vps_id> [os]`
- `/delete <vps_id>`
- `/logs <vps_id> [lines]`
- `/about`
- `/ping`
- `/help`

### Admin
- `/admin-create <user> <os> [ram] [cpu] [disk]`
- `/admin-manage <user> <vps> <action>`
- `/admin-users`
- `/admin-list`
- `/admin-stats`
- `/admin-vps-info <user> <vps>`
- `/admin-logs <user> <vps> [lines]`
- `/admin-del-user <user>`
- `/admin-ban <user>`
- `/admin-unban <user>`
- `/admin-stop-all`

## SSH access

The bot installs and launches SSHX inside the LXC guest, matching the access style of the supplied bot. If SSHX cannot be reached from the guest, `/ssh` will report the failure instead of pretending a session was created.

## Resource limits

RAM and CPU are applied through cgroup v2 when supported by the Ubuntu host. `DEFAULT_DISK` is retained as an allocation/display value; this build does **not** claim to enforce a hard disk quota.

## Security

Do not expose this bot's admin ID/token publicly. Running a bot with root access is powerful: keep the Ubuntu host updated and restrict who can use admin commands.
