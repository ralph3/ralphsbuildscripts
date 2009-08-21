#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.4.7"

DIR="gphoto2-${VERSION}"
TARBALL="gphoto2-${VERSION}.tar.bz2"

DEPENDS=(
  aalib
  libgphoto2
  popt
)

SRC1=(
http://prdownloads.sourceforge.net/gphoto/${TARBALL}
)

MD5SUMS=(
a0bd7629040735f16e510b63edf386dd
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=8874&package_id=66654'
  VERSION_STRING='gphoto2-%version%.tar.bz2'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/gphoto/gphoto2-%version%.tar.gz'
  )
}
