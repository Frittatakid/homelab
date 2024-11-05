#!/bin/sh -e

# Create or overwrite the /etc/rc.local script
cat << 'EOF' > /etc/rc.local
#!/bin/sh -e

# Wait for 100 seconds and then start the Docker Compose service
sleep 100
/usr/bin/docker compose -f /root/services/jellyfin/docker-compose.yml up -d

exit 0
EOF

# Make the rc.local script executable
chmod +x /etc/rc.local
