#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.28"
SYS_VERSION="1.28-3"

DIR="faac-$VERSION"
TARBALL="faac-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/faac/${TARBALL}
)

MD5SUMS=(
80763728d392c7d789cde25614c878f6
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/${DIR} || return 1
  do_patch faac-1.28-gcc-4.4.0-1.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=704&package_id=10773'
  VERSION_STRING='faac-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/faac/faac-%version%.tar.gz"
  )
}
