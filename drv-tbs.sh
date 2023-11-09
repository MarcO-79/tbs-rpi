#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root!"
  exit
fi

echo 'Prepare system' 

if [ -n "`which apt-get`" ]; then

V=$(uname -r | awk -F. '{print $1*100+$2}')
if [ $V -lt 41 ]; then
    echo "Please, install kernel ...."
    exit 1
fi
    apt-get update
    apt-get -y upgrade
    apt-get dist-upgrade
    apt-get -y install \
        curl \
        wget \
        gcc \
        build-essential \
        patchutils \
        make \
        cmake \
        libproc-processtable-perl \
        libdigest-sha-perl \
        build-essential \
        subversion \
        mercurial \
        openssl \
        gettext \
        libssl-dev \
        libv4l-dev \
        raspberrypi-kernel-headers \
        screen
systemctl disable apt-daily.service
systemctl disable apt-daily.timer
rm -rf /usr/src/media_build /usr/src/media /usr/src/dvb-firmwares.tar.bz2
cd /usr/src
git clone --depth=1 https://github.com/tbsdtv/media_build.git
git clone --depth=1 https://github.com/tbsdtv/linux_media.git -b latest ./media


elif [ -n "`which yum`" ]; then
        yum -y update
        yum -y upgrade
        yum -y group install "Development Tools"
        yum -y install epel-release
        yum -y install \
        perl-core \
        perl-Proc-ProcessTable \
        perl-Digest-SHA \
        kernel-headers \
        kernel-devel \
        elfutils-libelf-devel
rm -rf /usr/src/media_build /usr/src/media /usr/src/dvb-firmwares.tar.bz2
cd /usr/src
git clone --depth=1 https://github.com/tbsdtv/media_build.git
git clone --depth=1 https://github.com/tbsdtv/linux_media.git -b latest ./media
sed -i '/vm_fault_t;/d' /usr/src/media_build/v4l/compat.h
sed -i '/add v4.20_access_ok.patch/d' /usr/src/media_build/backports/backports.txt

fi

rm -rf /lib/modules/$(uname -r)/extra
rm -rf /lib/modules/$(uname -r)/kernel/drivers/media
rm -rf /lib/modules/$(uname -r)/kernel/drivers/staging/media

curl -L https://github.com/tbsdtv/media_build/releases/download/latest/dvb-firmwares.tar.bz2 | \
    tar -jxf - -C /lib/firmware/


cd /usr/src/media_build
make dir DIR=../media && \
    make allyesconfig && \
    make -j4 && \
    make install && \
    echo 'Done! Please reboot the server'

