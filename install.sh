cd /opt

echo "Installing tools via APT"
apt update
apt install -y golang brutespary nmap xsltproc sslscan python3-pip tmux parallel ike-scan

echo "Installing tools via PIP"
python3 -m pip install sslyze trufflehog

echo "Getting SecLists"
git clone https://github.com/danielmiessler/SecLists

echo "Getting NSE"
git clone https://github.com/r3naissance/nse

echo "Getting nmap bootstrap"
git clone https://github.com/honze-net/nmap-bootstrap-xsl

echo "Installing cors scanner"
git clone https://github.com/chenjj/CORScanner
python3 -m pip install -r requirements.txt
cors_scan.py -h >> /tmp/install.log

echo "Installing gospider"
git clone https://github.com/jaeles-project/gospider
go build .
mv gospider /usr/local/bin/
gospider -h >> /tmp/install.log

echo "Installing dalfox"
git clone https://github.com/hahwul/dalfox
go build .
mv dalfox /usr/local/bin/
dalfox -h >> /tmp/install.log

echo "Installing subfinder"
git clone https://github.com/projectdiscovery/subfinder.git
cd subfinder/v2/cmd/subfinder
go build .
mv subfinder /usr/local/bin/
subfinder -h >> /tmp/install.log

echo "Installing nuclei"
git clone https://github.com/projectdiscovery/nuclei.git
cd nuclei/v2/cmd/nuclei
go build .
mv nuclei /usr/local/bin/
nuclei -version >> /tmp/install.log

echo "Installing httpx"
git clone https://github.com/projectdiscovery/httpx.git
cd httpx/cmd/httpx
go build .
mv httpx /usr/local/bin/
httpx -version >> /tmp/install.log

echo "Updating everything and cleaning up"
apt dist-upgrade -y
apt auto-remove -y
