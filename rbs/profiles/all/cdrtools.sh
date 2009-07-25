#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.01"

DIR="cdrtools-${VERSION}"
TARBALL="cdrtools-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
 http://mirror.cict.fr/blfs/svn/c/${TARBALL}
 ftp://ftp.berlios.de/pub/cdrecord/${TARBALL}
)

MD5SUMS=(
d44a81460e97ae02931c31188fe8d3fd
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch cdrtools-2.01-glibc-2.10.1-1.patch || return 1
  make INS_BASE=/usr DEFINSUSR=root DEFINSGRP=root CC="$CC $BUILD" \
    CXX="$CXX $BUILD" || return 1
  make INS_BASE=$TMPROOT/usr DEFINSUSR=root DEFINSGRP=root install || return 1
  if [ ! -d "$TMPROOT/usr/$LIBSDIR" ]; then
    mv $TMPROOT/usr/lib $TMPROOT/usr/$LIBSDIR || return 1
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.berlios.de/pub/cdrecord/'
  VERSION_STRING='cdrtools-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.berlios.de/pub/cdrecord/cdrtools-%version%.tar.bz2'
  )
}
