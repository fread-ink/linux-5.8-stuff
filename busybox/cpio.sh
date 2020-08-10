#!/bin/bash

set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" >&2
   exit 1
fi

cp ../init _install/
chmod 755 _install/init
rm -f _install/linuxrc

cd _install/
mkdir -p {proc,sys,etc,etc/init.d,lib,mnt,tmp}
rm -rf dev
../makenodes.sh
rm -rf ../initramfs.cpio
echo "Go"
find . -print0 | cpio --null -H newc -o > ../initramfs.cpio
echo "Wrote ./initramfs.cpio"


set +e
