#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.10"

DIR="ttf-bitstream-vera-${VERSION}"
TARBALL="ttf-bitstream-vera-${VERSION}.tar.bz2"

DEPENDS=(
  mkfontdir
  mkfontscale
  fontconfig
)

SRC1=(
  $(gnome_mirrors ttf-bitstream-vera)
)

MD5SUMS=(
bb22bd5b4675f5dbe17c6963d8c00ed6
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  mkdir -pv $TMPROOT/usr/share/X11/fonts/TTF || return 1
  install -vm 0644 *.ttf $TMPROOT/usr/share/X11/fonts/TTF/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  cd /usr/share/X11/fonts/TTF || return 1
  mkfontdir || return 1
  mkfontscale || return 1
  fc-cache || return 1
}

post_upgrade(){
  post_install || return 1
}

post_remove(){
  [ -d "/usr/share/X11/fonts/TTF" ] && {
    cd /usr/share/X11/fonts/TTF || return 1
    mkfontdir || return 1
    mkfontscale || return 1
  }
  fc-cache || return 1
  return 0
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/%minor_version%/'
  VERSION_STRING='ttf-bitstream-vera-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/%minor_version%/ttf-bitstream-vera-%version%.tar.bz2'
  )
}
