#!/bin/bash

# Update system
apt-get update
apt-get install -y curl wget

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs

# Install Docker (optional, for containerized deployment)
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker $USER

# Create application directory
mkdir -p /opt/ace-internal-microservice
cd /opt/ace-internal-microservice

# Copy application source code from GitHub repository
git clone https://github.com/your-username/ace-microservice.git .
# Or if using a private repository, you might need to set up SSH keys
# git clone git@github.com:your-username/ace-microservice.git .

# Install dependencies
npm install --production

# Install Docker Compose (optional)
curl -L "https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create systemd service file
cat > /etc/systemd/system/ace-internal-microservice.service << EOF
[Unit]
Description=ACE Internal Microservice
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/ace-internal-microservice
ExecStart=/usr/bin/node server.js
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