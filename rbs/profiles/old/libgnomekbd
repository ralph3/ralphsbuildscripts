#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0"

DIR="libgnomekbd-${VERSION}"
TARBALL="libgnomekbd-${VERSION}.tar.bz2"

DEPENDS=(
  desktop-file-utils
  libxklavier
)

SRC1=(
  $(gnome_mirrors libgnomekbd)
)

MD5SUMS=(
43e4d090bc67a1984bebf551637783fd
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script libgnomekbd install || return 1
}

pre_remove(){
  gnome_script libgnomekbd remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnomekbd/%minor_version%/'
  VERSION_STRING='libgnomekbd-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/libgnomekbd/%minor_version%/libgnomekbd-%version%.tar.bz2"
  )
}
