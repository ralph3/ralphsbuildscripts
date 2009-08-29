#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.5.0"

DIR="enchant-${VERSION}"
TARBALL="enchant-${VERSION}.tar.gz"

DEPENDS=(
  aspell-en
  glib
)

SRC1=(
http://www.abisource.com/downloads/enchant/${VERSION}/${TARBALL}
)

MD5SUMS=(
7dfaed14e142b4a0004b770c9568ed02
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  find -type f -name 'Makefile' -exec sed -i "s%-L/usr/lib%-L/usr/${LIBSDIR}%g" {} \;
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://www.abisource.com/downloads/enchant/%version%/"
  VERSION_STRING="enchant-%version%.tar.gz"
  MIRRORS=(
    "http://www.abisource.com/downloads/enchant/%version%/enchant-%version%.tar.gz"
  )
}
