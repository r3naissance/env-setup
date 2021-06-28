#!/bin/bash

git config pull.rebase true

echo "Getting SecLists"
cd /opt/SecLists
git pull

echo "Getting sqlmap"
cd /opt/sqlmap
git pull

echo "Getting NSE"
cd /opt/nse
git pull

echo "Getting nmap bootstrap"
cd /opt/nmap-bootstrap-xsl
git pull

echo "Installing cors scanner"
cd /opt/cors
git pull
python3 -m pip install -r requirements.txt
python3 /opt/cors/cors_scan.py -h

echo "Installing hakrawler"
cd /opt/hakrawler
git pull
go build .
mv hakrawler /usr/local/bin/

echo "Installing gospider"
cd /opt/gospider
git pull
go build .
mv gospider /usr/local/bin/
gospider -h

echo "Installing dalfox"
cd /opt/dalfox
git pull
go build .
mv dalfox /usr/local/bin/
dalfox -h

echo "Installing subfinder"
cd /opt/subfinder
git pull
cd v2/cmd/subfinder
go build .
mv subfinder /usr/local/bin/
subfinder -h

echo "Installing nuclei"
cd /opt/nuclei
git pull
cd v2/cmd/nuclei
go build .
mv nuclei /usr/local/bin/
nuclei -version

echo "Installing httpx"
cd /opt/httpx
git pull
cd cmd/httpx
go build .
mv httpx /usr/local/bin/
httpx -version

echo "Updating everything and cleaning up"
apt update
apt dist-upgrade -y
apt auto-remove -y
