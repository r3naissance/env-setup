#!/bin/bash

echo -n "Getting SecLists "
cd /opt/SecLists
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

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

echo -n "Getting nmap bootstrap "
cd /opt/nmap-bootstrap-xsl
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
else
  echo "[DONE]"
fi

echo -n "Installing cors scanner "
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

echo -n "Installing hakrawler "
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

echo -n "Installing gospider "
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

echo -n "Installing dalfox "
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

echo -n "Installing subfinder "
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

echo -n "Installing nuclei "
cd /opt/nuclei
git config pull.rebase true
gp=$(git pull)
if [[ ! $gp == 'Already up to date.' ]]; then
  echo $gp
  cd v2/cmd/nuclei
  go build .
  mv nuclei /usr/local/bin/
  nuclei -version
else
  echo "[DONE]"
fi

echo -n "Installing httpx "
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

echo "Updating everything and cleaning up"
apt update
apt dist-upgrade -y
apt auto-remove -y
