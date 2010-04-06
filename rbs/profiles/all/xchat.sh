#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.8.6"

DIR="xchat-${VERSION}"
TARBALL="xchat-${VERSION}.tar.bz2"

DEPENDS=(
  dbus-glib
  enchant
  gtk+
)

SRC1=(
http://www.xchat.org/files/source/$(echo ${VERSION} | cut -f-2 -d'.')/${TARBALL}
)

MD5SUMS=(
1f2670865d43a23a9abc596dde999aca
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --enable-spell=static || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  update-desktop-database -q || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://www.xchat.org/files/source/%minor_version%/'
  VERSION_STRING='xchat-%version%.tar.bz2'
  MIRRORS=(
    'http://www.xchat.org/files/source/%minor_version%/xchat-%version%.tar.bz2'
  )
}
