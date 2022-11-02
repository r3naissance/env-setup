echo "Removing included docker"
sudo apt-get remove docker docker-engine docker.io containerd runc -y

echo "Installing dependencies"
sudo apt-get install ca-certificates curl gnupg lsb-release-y

echo "Adding docker repo"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

echo "Installing docker from repo"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Cloning serpico source"
cd /opt
git clone https://github.com/r3naissance/Serpico

echo "Building serpico"
cd Serpico
docker build -t serpico .

echo "Starting serpico"
docker run --name serpico -p 8443:8443 -v"$(pwd)/db":/Serpico/db \
  -v"$(pwd)/tmp":/Serpico/tmp -v"$(pwd)/attachments":/Serpico/attachments \
  -v"$(pwd)/certs":/Serpico/certs -it serpico
