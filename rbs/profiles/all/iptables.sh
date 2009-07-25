#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.4"

DIR="iptables-${VERSION}"
TARBALL="iptables-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://www.netfilter.org/projects/iptables/files/${TARBALL}
)

MD5SUMS=(
08cd9196881657ea0615d926334cb7e9
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.netfilter.org/projects/iptables/downloads.html'
  VERSION_STRING='iptables-%version%.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://www.us.netfilter.org/projects/iptables/files/iptables-%version%.tar.bz2'
  )
}
