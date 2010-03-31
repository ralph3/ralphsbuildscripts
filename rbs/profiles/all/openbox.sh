#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.4.11.1"
SYS_VERSION="3.4.11.1-1"

DIR="openbox-${VERSION}"
TARBALL="openbox-${VERSION}.tar.gz"

DEPENDS=(
  libx11
  startup-notification
)

SRC1=(
http://openbox.org/dist/openbox/${TARBALL}
)

MD5SUMS=(
56d1b365a95b119e4809802aeea734fb
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  tar xfj $FILESDIR/obindustrial.tar.bz2 -C $TMPROOT/usr/share/themes/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://openbox.org/dist/openbox"
  VERSION_STRING="openbox-%version%.tar.gz"
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    "http://openbox.org/dist/openbox/openbox-%version%.tar.gz"
  )
}
