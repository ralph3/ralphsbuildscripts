#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.4.7"

DIR="libgphoto2-${VERSION}"
TARBALL="libgphoto2-${VERSION}.tar.bz2"

DEPENDS=(
  dbus
  hal
  libjpeg
  libtool
  libusb
)

SRC1=(
http://prdownloads.sourceforge.net/gphoto/${TARBALL}
)

MD5SUMS=(
3c1f1b1e56214e83b97e2bc7aadba4c5
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --with-ltdl \
    --with-drivers=all || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/gphoto2{,-port}-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=8874&package_id=8957'
  VERSION_STRING='libgphoto2-%version%.tar.bz2'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/gphoto/libgphoto2-%version%.tar.gz'
  )
}
