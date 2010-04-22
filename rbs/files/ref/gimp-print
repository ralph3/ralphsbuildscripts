#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.2.7"
SYS_VERSION="4.2.7-1"

DIR="gimp-print-${VERSION}"
TARBALL="gimp-print-${VERSION}.tar.gz"

DEPENDS=(
  cups
  readline
)

SRC1=(
http://prdownloads.sourceforge.net/gimp-print/${TARBALL}
)

MD5SUMS=(
766be49f44a6a682d857e5aefec414d4
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" LDFLAGS="-L/usr/${LIBSDIR}" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/gimpprint-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/gimp-print/'
  VERSION_STRING='gimp-print-%version%.tar.gz'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/gimp-print/gimp-print-%version%.tar.gz'
  )
}
