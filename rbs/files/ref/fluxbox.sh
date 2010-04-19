#!/bin/bash

VERSION="1.1.1"

DIR="fluxbox-${VERSION}"
TARBALL="fluxbox-${VERSION}.tar.bz2"

DEPENDS=(
  xorg-server
)

SRC1=(
http://prdownloads.sourceforge.net/fluxbox/${TARBALL}
)

MD5SUMS=(
fa9fa8fe9a44f86522de5754f8b285ca
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
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=35398&package_id=27561&release_id=627066'
  VERSION_STRING='fluxbox-%version%.tar.bz2'
  MIRRORS=(
    'http://fluxboxgraphics.org/releases/fluxbox-%version%.tar.bz2'
  )
}
