#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.10.10"

DIR="gthumb-${VERSION}"
TARBALL="gthumb-${VERSION}.tar.bz2"

DEPENDS=(
  libexif
  libgnomeprintui
  libgnomeui
  libgphoto2
)

SRC1=(
  $(gnome_mirrors gthumb)
)

MD5SUMS=(
b3344b31f82830fdcf86865f4ecb7a95
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gthumb \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gthumb install || return 1
}

pre_remove(){
  gnome_script gthumb remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gthumb/%minor_version%/'
  VERSION_STRING='gthumb-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gthumb/%minor_version%/gthumb-%version%.tar.bz2'
  )
}
