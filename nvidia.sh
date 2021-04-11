# !/bin/bash
# Ubuntu
if [[ ! `uname -a|grep Ubuntu` ]]; then
    echo "暂时支持Ubuntu"
else
    if [[ $EUID -ne 0 ]]; then
        echo "使用root运行"
        
    else
        apt update
        apt upgrade -y
        apt-get install linux-headers-$(uname -r)
        distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
        h="http"
        if [[ ! `uname -a|grep 16.04` ]]; then
            $h="https"
        fi
        wget $h://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin -O /etc/apt/preferences.d/cuda-repository-pin-600

        apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
        echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | tee /etc/apt/sources.list.d/cuda.list
        apt update
        apt install -y cuda-drivers
        nvidia-smi
    fi
fi
