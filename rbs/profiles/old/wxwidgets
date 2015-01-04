#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.8.8"

DIR="wxWidgets-${VERSION}"
TARBALL="wxWidgets-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
  libxinerama
)

SRC1=(
  http://prdownloads.sourceforge.net/wxwindows/${TARBALL}
)

MD5SUMS=(
647b94f636db8f3e6ba7170d0d691eb6
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --sysconfdir=/etc --enable-unicode || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  ln -sfn "/$(readlink $TMPROOT/usr/bin/wx-config | sed "s%${TMPROOT}%%")" \
    $TMPROOT/usr/bin/wx-config || return 1
  set_multiarch $TMPROOT/usr/bin/wx-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/wxwindows/'
  VERSION_STRING='wxWidgets-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  VERSION_FILTERS='rc'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/wxwindows/wxWidgets-%version%.tar.bz2'
  )
}
