#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.0"

DIR="font-misc-misc-${VERSION}"
TARBALL="font-misc-misc-${VERSION}.tar.bz2"

DEPENDS=(
  font-util
  fontconfig
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/font/${TARBALL}
)

MD5SUMS=(
878bfd4e9f14c1279cea3a8392e0dbdd
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make MAPFILES_PATH=/usr/share/X11/fonts/util \
    UTIL_DIR=/usr/share/X11/fonts/util || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/usr/share || return 1
  cp -a $TMPROOT/usr/$LIBSDIR/* $TMPROOT/usr/share/ || return 1
  rm -rf $TMPROOT/usr/$LIBSDIR || return 1
  rm $TMPROOT/usr/share/X11/fonts/misc/fonts.{scale,dir} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  cd /usr/share/X11/fonts/misc || return 1
  mkfontdir  || return 1
  mkfontscale  || return 1
  fc-cache || return 1
}

post_upgrade(){
  post_install || return 1
}

post_remove(){
  [ -d "/usr/lib/X11/fonts/misc" ] && {
    cd /usr/lib/X11/fonts/misc || return 1
    mkfontdir || return 1
    mkfontscale || return 1
  }
  fc-cache || return 1
  return 0
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/font/'
  VERSION_STRING='font-misc-misc-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/font/font-misc-misc-%version%.tar.bz2'
  )
}
