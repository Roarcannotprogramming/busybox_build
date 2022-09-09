#! /bin/bash

# update and install packages
apt update
apt install -y curl cpio tree

# copy config file
cp /config-${VERSION} /busybox/.config

cd /busybox || exit 1

# apply patches
for patch in /patch.d/*; do
    source $patch
done

# build busybox
make -j$(nproc)
make install

# prepare rootfs
cd _install || exit 1

for post_install in /post_install.d/*; do
    source $post_install
done

# debug tree
tree .

# make rootfs.cpio file
mkdir -p /files/output
find . -print0 | cpio --null -ov --format=newc | gzip -9 -n > /files/output/rootfs.cpio