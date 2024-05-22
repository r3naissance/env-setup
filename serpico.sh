echo "Removing included docker"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

echo "Installing dependencies"
sudo apt-get install ca-certificates curl gnupg lsb-release-y

echo "Adding docker repo"
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Installing docker from repo"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl start docker
sudo systemctl enable docker

echo "Cloning serpico source"
cd /opt
git clone https://github.com/r3naissance/Serpico

echo "Building serpico"
cd Serpico
docker build -t serpico .

echo "Creating service"
cat > /etc/systemd/system/serpico.service <<EOL
[Unit]
Description=Serpico Reporting Server
After=network.target auditd.service syslog.target docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
RemainAfterExit=yes

ExecStart=/usr/bin/docker start serpico
ExecStop=/usr/bin/docker stop serpico
Restart=always

AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
EOL

echo "Starting and enabling service"
sudo systemctl daemon-reload
sudo systemctl enable serpico.service

echo "Starting serpico"
docker run --name serpico -p 8443:8443 -v"$(pwd)/db":/Serpico/db \
  -v"$(pwd)/tmp":/Serpico/tmp -v"$(pwd)/attachments":/Serpico/attachments \
  -v"$(pwd)/certs":/Serpico/certs -it serpico
