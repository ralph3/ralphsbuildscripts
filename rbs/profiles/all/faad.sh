#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.7"

DIR="faad2-$VERSION"
TARBALL="faad2-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/faac/${TARBALL}
)

MD5SUMS=(
ee1b4d67ea2d76ee52c5621bc6dbf61e
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/${DIR} || return 1
  echo > plugins/Makefile.am || return 1
  echo > plugins/xmms/src/Makefile.am || return 1
  sed -i '/E_B/d' configure.in || return 1
  sed -i '/AC_PROG_CXX/s/dnl //' configure.in || return 1
  autoreconf -vif || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --with-mp4v2 --with-drm || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=704&package_id=85086'
  VERSION_STRING='faad2-%version%.tar.gz'
  VERSION_FILTERS='/'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/faac/faad2-%version%.tar.gz"
  )
}
