#!/bin/bash

cd /opt
nonROOT=$(who am i | awk '{print $1}')

echo "Installing tools via APT"
apt update
apt install python3-pip openvpn terminator jq curl git golang brutespray nmap xsltproc sslscan tmux parallel ike-scan ntpsec seclists -y

echo "Installing tools via PIP"
sudo -u nonROOT python3 -m pip install sslyze trufflehog

echo "Getting sqlmap"
git clone https://github.com/sqlmapproject/sqlmap

echo "Getting aquatone"
mkdir aquatone
wget -O aquatone/aquatone.zip https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone/aquatone.zip -d aquatone
cp aquatone/aquatone /usr/local/bin/

echo "Getting NSE"
git clone https://github.com/r3naissance/nse

echo "Getting EATT"
git clone https://github.com/r3naissance/eatt

echo "Getting NSE Log4Shell"
git clone https://github.com/Diverto/nse-log4shell

echo "Getting nmap bootstrap"
git clone https://github.com/honze-net/nmap-bootstrap-xsl

echo "Getting NMAP to CSV"
git clone https://github.com/NetsecExplained/Nmap-XML-to-CSV

echo "Installing cors scanner"
git clone https://github.com/chenjj/CORScanner cors
python3 -m pip install -r cors/requirements.txt
python3 /opt/cors/cors_scan.py -h

echo "Getting hakrawler"
git clone https://github.com/hakluke/hakrawler
cd hakrawler
go build .
mv hakrawler /usr/local/bin/

echo "Installing gospider"
git clone https://github.com/jaeles-project/gospider
cd gospider
go build .
mv gospider /usr/local/bin/
gospider -h

echo "Installing dalfox"
cd /opt
git clone https://github.com/hahwul/dalfox
cd dalfox
go build .
mv dalfox /usr/local/bin/
dalfox -h

echo "Installing subfinder"
cd /opt
git clone https://github.com/projectdiscovery/subfinder.git
cd subfinder/v2/cmd/subfinder
go build .
mv subfinder /usr/local/bin/
subfinder -h

echo "Installing nuclei"
cd /opt
git clone https://github.com/projectdiscovery/nuclei.git
cd nuclei/v2/cmd/nuclei
go build .
mv nuclei /usr/local/bin/
nuclei -version

echo "Installing httpx"
cd /opt
git clone https://github.com/projectdiscovery/httpx.git
cd httpx/cmd/httpx
go build .
mv httpx /usr/local/bin/
httpx -version

echo "Adding NSE scripts to nmap DB"
find /opt/ -name "*.nse" -exec cp {} /usr/share/nmap/scripts/ \;
nmap --script-updatedb

echo "Updating everything and cleaning up"
apt dist-upgrade -y
apt auto-remove -y
