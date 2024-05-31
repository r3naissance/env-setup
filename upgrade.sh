#!/bin/bash

echo -n "Getting sqlmap "
cd /opt/sqlmap
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

echo -n "Getting NSE "
cd /opt/nse
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

echo -n "Getting EATT "
cd /opt/eatt
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

echo "Adding NSE scripts to nmap DB"
find /opt/ -name "*.nse" -exec cp {} /usr/share/nmap/scripts/ \;
nmap --script-updatedb

echo -n "Getting nmap bootstrap "
cd /opt/nmap-bootstrap-xsl
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

echo -n "Getting NMAP to CSV "
cd /opt/Nmap-XML-to-CSV
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

echo -n "Upgrading cors scanner "
cd /opt/cors
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  python3 -m pip install -r requirements.txt
  python3 /opt/cors/cors_scan.py -h
else
  echo "[DONE]"
fi

echo -n "Upgrading hakrawler "
cd /opt/hakrawler
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  go build .
  mv hakrawler /usr/local/bin/
else
  echo "[DONE]"
fi

echo -n "Upgrading log4shell "
cd /opt/nse-log4shell
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

echo -n "Upgrading gospider "
cd /opt/gospider
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  go build .
  mv gospider /usr/local/bin/
  gospider -h
else
  echo "[DONE]"
fi

echo -n "Upgrading dalfox "
cd /opt/dalfox
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  go build .
  mv dalfox /usr/local/bin/
  dalfox -h
else
  echo "[DONE]"
fi

echo -n "Upgrading subfinder "
cd /opt/subfinder
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  cd v2/cmd/subfinder
  go build .
  mv subfinder /usr/local/bin/
  subfinder -h
else
  echo "[DONE]"
fi

echo -n "Upgrading nuclei "
cd /opt/nuclei
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  cd cmd/nuclei
  go build .
  mv nuclei /usr/local/bin/
  nuclei -version
else
  echo "[DONE]"
fi

echo -n "Upgrading httpx "
cd /opt/httpx
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  cd cmd/httpx
  go build .
  mv httpx /usr/local/bin/
  httpx -version
else
  echo "[DONE]"
fi

echo "Updating pip & packages"
python3 -m pip install --upgrade pip
python3 -m pip install sslyze trufflehog

echo "Updating everything and cleaning up"
apt update
apt dist-upgrade -y
apt auto-remove -y
