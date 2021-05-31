# !/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "使用root运行"
    exit
fi
apt update
apt upgrade -y

if [[ `lspci | grep NVIDIA` ]]; then
    curl -s https://raw.githubusercontent.com/Rehtt/AWS_Script/main/nvidia.sh | bash -
fi

apt install ffmpeg -y
curl -L https://github.com/Rehtt/AWS_Script/raw/main/font/WeiRuanYaHei-1.ttf -o /usr/share/fonts/truetype/dejavu/WeiRuanYaHei-1.ttf
fc-cache -fv