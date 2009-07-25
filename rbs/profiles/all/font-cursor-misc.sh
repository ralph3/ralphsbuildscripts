#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.0"

DIR="font-cursor-misc-${VERSION}"
TARBALL="font-cursor-misc-${VERSION}.tar.bz2"

DEPENDS=(
  fontconfig
  mkfontdir
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/font/${TARBALL}
)

MD5SUMS=(
305fa22cdfefb8f80babd711051a534b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/usr/share || return 1
  cp -a $TMPROOT/usr/$LIBSDIR/* $TMPROOT/usr/share/ || return 1
  rm -rf $TMPROOT/usr/$LIBSDIR || return 1
  rm $TMPROOT/usr/share/X11/fonts/misc/fonts.{dir,scale} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  cd /usr/share/X11/fonts/misc || return 1
  mkfontdir || return 1
  mkfontscale || return 1
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
  VERSION_STRING='font-cursor-misc-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/font/font-cursor-misc-%version%.tar.bz2'
  )
}
