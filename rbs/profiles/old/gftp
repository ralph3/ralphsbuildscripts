#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.0.19"

DIR="gftp-${VERSION}"
TARBALL="gftp-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
  openssl
  readline
)

SRC1=(
  http://gftp.seul.org/${TARBALL}
)

MD5SUMS=(
5183cb4955d94be0e03c892585547c64
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
  gnome_script gftp install || return 1
}

pre_remove(){
  gnome_script gftp remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://gftp.seul.org/'
  VERSION_STRING='gftp-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://gftp.seul.org/gftp-%version%.tar.bz2'
  )
}
