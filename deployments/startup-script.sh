#!/bin/bash

# Update system
apt-get update
apt-get install -y curl wget git

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs

# Create application directory
mkdir -p /opt/ace-internal-microservice
cd /opt/ace-internal-microservice

# Clone the repository from GitHub
git clone https://github.com/ace-ai-technologies/ace-internal-microservice.git .
git checkout master

# Install dependencies
npm install --production

# Create systemd service file
cat > /etc/systemd/system/ace-internal-microservice.service << EOF
[Unit]
Description=ACE Internal Microservice
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/ace-internal-microservice
ExecStart=/usr/bin/node src/server.js
Restart=always
RestartSec=10
Environment=NODE_ENV=production
Environment=PORT=3000
Environment=JWT_SECRET=your-production-jwt-secret-here
Environment=ALLOWED_ORIGINS=https://your-domain.com

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
systemctl daemon-reload
systemctl enable ace-internal-microservice
systemctl start ace-internal-microservice

echo "ACE Internal Microservice setup completed!"
echo "Service status: systemctl status ace-internal-microservice"
echo "Service logs: journalctl -u ace-internal-microservice -f"