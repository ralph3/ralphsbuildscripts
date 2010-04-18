#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.30.0"

DIR="libgnome-${VERSION}"
TARBALL="libgnome-${VERSION}.tar.bz2"

DEPENDS=(
  esound
  gnome-vfs
  libbonobo
)

SRC1=(
  $(gnome_mirrors libgnome)
)

MD5SUMS=(
1f85adc40b242b953c0e96ad017c2616
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
  gnome_script libgnome install || return 1
}

pre_remove(){
  gnome_script libgnome remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgnome/%minor_version%/'
  VERSION_STRING='libgnome-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/libgnome/%minor_version%/libgnome-%version%.tar.bz2"
  )
}
