#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.6"

DIR="libxklavier-${VERSION}"
TARBALL="libxklavier-${VERSION}.tar.gz"

DEPENDS=(
  iso-codes
)

SRC1=(
http://prdownloads.sourceforge.net/gswitchit/$TARBALL
)

MD5SUMS=(
19b5ba95a7295831c0f4d5be1aae1376
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script libxklavier install || return 1
}

pre_remove(){
  gnome_script libxklavier remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/gswitchit/'
  VERSION_STRING='libxklavier-%version%.tar.gz'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://prdownloads.sourceforge.net/gswitchit/libxklavier-%version%.tar.gz'
  )
}
