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


echo -e "     ████████████████████████████████    " | lolcat
echo -e "     █▄─▄▄─█─▄─▄─█─█─█░▄▄░█▄▄▄░█▄▄▄░█    " | lolcat
echo -e "     ██─▄█▀███─███─▄─█▄▄▄░███░███▄▄░█    " | lolcat
echo -e "     ▀▄▄▄▄▄▀▀▄▄▄▀▀▄▀▄▀▄▄▄▄▀▀▄██▀▄▄▄▄▀    " | lolcat
echo ""
echo ""
echo ""
sleep 6
# change to time GMT+5:30

echo "Cambiando zona horaria a GMT-5 Colombia"
sudo timedatectl set-timezone America/Bogota
ln -fs /usr/share/zoneinfo/America/Bogota /etc/localtime


# install udp-custom and block ports
echo downloading udp-custom
wget "https://github.com/ETH973/UDP/raw/main/udp-custom-linux-amd64" -O /root/udp/udp-custom
chmod +x /root/udp/udp-custom

echo downloading default config
wget "https://raw.githubusercontent.com/ETH973/UDP/main/config.json" -O /root/udp/config.json
chmod 644 /root/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team and modify by ETH973 - Sslablk

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude=53,5300,443,8080,8443,35172
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
echo '    Instalando servicio UDP Custom   ' | lolcat

echo ''
echo ''
echo ''
sleep 5
cd $HOME
mkdir /etc/ETH973
cd /etc/ETH973
wget https://github.com/ETH973/UDP/raw/main/system.zip
unzip system
cd /etc/ETH973/system
mv udp /usr/local/bin
cd /etc/ETH973/system
chmod +x ChangeUser.sh
chmod +x Adduser.sh
chmod +x DelUser.sh
chmod +x Userlist.sh
chmod +x RemoveScript.sh
chmod +x torrent.sh
cd /usr/local/bin
chmod +x udp
cd /etc/ETH973
rm system.zip
rm install.sh


clear
echo 'Script UDP editada por ETH973 -TeamV24'
echo 'UDP Custom By ePro Dev. Team'
echo ''
echo ''
echo "Github/ETH973"
sleep 5

echo Deshabilitando IPv6
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

echo Iniciando servicio udp-custom
systemctl start udp-custom &>/dev/null
echo Habilitando servicio udp-custom
systemctl enable udp-custom &>/dev/null
echo -e "\nEnter para ingresar al menu"; read
udp
