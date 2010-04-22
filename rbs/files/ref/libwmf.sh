#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.2.8.4"
SYS_VERSION="0.2.8.4-1"

DIR="libwmf-${VERSION}"
TARBALL="libwmf-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
)

SRC1=(
http://prdownloads.sourceforge.net/wvware/${TARBALL}
)

MD5SUMS=(
d1177739bf1ceb07f57421f0cee191e0
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/libwmf-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=10501&package_id=11096'
  VERSION_STRING='libwmf-%version%.tar.gz'
  VERSION_FILTERS='Darwin'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/wvware/libwmf-%version%.tar.gz"
  )
}