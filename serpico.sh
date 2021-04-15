echo "Removing included docker"
apt remove docker docker-engine docker.io containerd runc -y

echo "Installing dependencies"
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

echo "Adding docker repo"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update

echo "Installing docker from repo"
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo "Cloning serpico source"
cd /opt
git clone https://github.com/r3naissance/Serpico

echo "Building serpico"
cd Serpico
docker build -t serpico .

echo "Adding reveal.js"
cd public
git clone https://github.com/hakimel/reveal.js

echo "Starting serpico"
docker run --name serpico -p 8443:8443 -v"$(pwd)/db":/Serpico/db \
  -v"$(pwd)/tmp":/Serpico/tmp -v"$(pwd)/attachments":/Serpico/attachments \
  -v"$(pwd)/public":/Serpico/public -it serpico
