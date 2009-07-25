#!/bin/bash

DISABLE_MULTILIB=1

VERSION="7.6"

DIR="tcp_wrappers_${VERSION}"
TARBALL="tcp_wrappers_${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.porcupine.org/pub/security/${TARBALL}
)

MD5SUMS=(
e6fa25f71226d090f34de3f6b122fb5a
)

build(){
  unset SYSTYPE #yep tcp_wrappers has a SYSTYPE var and decides to take a dump
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch tcp_wrappers-7.6-shared_lib_plus_plus-1.patch || return 1
  sed -i -e "s,^extern char \*malloc();,/* & */," scaffold.c || return 1
  sed -i "s%/lib/%/${LIBSDIR}/%g" Makefile || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" REAL_DAEMON_DIR=/usr/sbin \
    STYLE=-DPROCESS_OPTIONS linux || return 1
  mkdir -p $TMPROOT/{etc,usr/{include,$LIBSDIR,share/man/man{3,5,8},sbin}}
  make LIBDIR=/usr/$LIBSDIR install DESTDIR=$TMPROOT || return 1
  echo > $TMPROOT/etc/hosts.allow.tmpnew
  echo > $TMPROOT/etc/hosts.deny.tmpnew
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.porcupine.org/pub/security/'
  VERSION_STRING='tcp_wrappers_%version%.tar.gz'
  MIRRORS=(
    'ftp://ftp.porcupine.org/pub/security/tcp_wrappers_%version%.tar.gz'
  )
}
