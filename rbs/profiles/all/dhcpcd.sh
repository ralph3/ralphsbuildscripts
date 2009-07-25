#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.22-pl4"

DIR="dhcpcd-${VERSION}"
TARBALL="dhcpcd-${VERSION}.tar.gz"

DEPENDS=(
  glibc
)

SRC1=(
http://www.phystech.com/ftp/${TARBALL}
)

MD5SUMS=(
dd627a121e43835bead3ffef5b1a72fd
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch dhcpcd-1.3.22-pl4-fhs-1.patch || return 1
  sed -i 's%ia64 |%& x86_64 |%g;s%ia64-* |%& x86_64-* |%g' \
    config.sub || return 1
  ./configure --build=${BUILDHOST} --host=${BUILDTARGET} --prefix="" \
    --mandir=/usr/share/man --sysconfdir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.phystech.com/ftp/'
  VERSION_STRING='dhcpcd-%version%.tar.gz'
  MIRRORS=(
    'http://www.phystech.com/ftp/dhcpcd-%version%.tar.gz'
  )
}
