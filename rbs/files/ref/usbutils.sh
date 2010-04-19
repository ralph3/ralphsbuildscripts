#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.72"

DIR="usbutils-${VERSION}"
TARBALL="usbutils-${VERSION}.tar.gz"

DEPENDS=(
  libusb
)

SRC1=(
http://prdownloads.sourceforge.net/linux-usb/${TARBALL}
)

MD5SUMS=(
  ee345fe605ffcfce843dae4aed81122b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i 's|DEST=|&/usr/share/|' update-usbids.sh || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  install -v -m755 update-usbids.sh $TMPROOT/usr/sbin/update-usbids || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
