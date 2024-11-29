#!/bin/bash
apt update -y
apt upgrade -y
apt install lolcat -y
apt install figlet -y
apt install neofetch -y
apt install screenfetch -y
cd
rm -rf /root/udp
mkdir -p /root/udp

# banner
clear

echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█   ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄   ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█   ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat
echo ""
echo ""
echo ""
sleep 5
# change to time GMT+5:30

echo "change to time GMT+5:30 Sri Lanka"
ln -fs /usr/share/zoneinfo/Asia/Colombo /etc/localtime



# install udp-custom
echo downloading udp-custom
wget "https://github.com/ETH973/UDP/raw/main/udp-custom-linux-amd64" -O /root/udp/udp-custom
chmod +x /root/udp/udp-custom

echo downloading default config
wget "https://raw.githubusercontent.com/ETH973/UDP/main/config.json" -O /root/udp/config.json
chmod 644 /root/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team and modify by sslablk

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team and modify by sslablk

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

clear
echo '    Install Custom UDP Manager   ' | lolcat

echo ''
echo ''
echo ''
sleep 5
cd $HOME
mkdir /etc/Sslablk
cd /etc/Sslablk
wget https://github.com/ETH973/UDP/raw/main/system.zip
unzip system
cd /etc/Sslablk/system
mv menu /usr/local/bin
cd /etc/Sslablk/system
chmod +x ChangeUser.sh
chmod +x Adduser.sh
chmod +x DelUser.sh
chmod +x Userlist.sh
chmod +x RemoveScript.sh
chmod +x torrent.sh
cd /usr/local/bin
chmod +x udp
cd /etc/Sslablk
rm system.zip


clear
echo 'UDP Install Script By Project SSLAB LK Dev.Team'
echo 'UDP Custom By ePro Dev. Team'
echo ''
echo ''
echo ' Support US'
echo "Github/noobconner21"
echo "Telegram/SSLAB LK"
sleep 5

echo start service udp-custom
systemctl start udp-custom &>/dev/null

echo enable service udp-custom
systemctl enable udp-custom &>/dev/null
