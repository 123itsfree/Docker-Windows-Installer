#!/bin/bash
# Optimized Docker-Windows-Installer (No Key)

echo "Starting Windows Docker Installer..."

# Use environment variables if provided (Pterodactyl style)
# Otherwise, prompt the user
USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"password123"}
RAM_SIZE=${RAM_SIZE:-"4G"}
CPU_CORES=${CPU_CORES:-"2"}
DISK_SIZE=${DISK_SIZE:-"64G"}

cat <<EOF > win10.yml
version: '3'
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "10"
      USERNAME: "$USERNAME"
      PASSWORD: "$PASSWORD"
      RAM_SIZE: "$RAM_SIZE"
      CPU_CORES: "$CPU_CORES"
      DISK_SIZE: "$DISK_SIZE"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - "8006:8006"
      - "3389:3389/tcp"
      - "3389:3389/udp"
    stop_grace_period: 2m
EOF

docker-compose -f win10.yml up -d
echo "Windows is now booting. Access via port 8006 (Web) or 3389 (RDP)."
