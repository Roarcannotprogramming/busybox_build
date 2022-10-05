#! /bin/bash

# update and install packages
apt update
apt install -y gcc build-essential binutils gawk bison python3 python3-pip linux-libc-dev linux-headers-generic 

# create install directory
mkdir -p /files/usr

# create build directory
mkdir -p /build
cd /build || exit 1

# configure
/glibc/configure --prefix=/files/usr --with-tls --enable-add-ons=nptl

# make & make install
make -j$(nproc)
make install

