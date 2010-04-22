#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.6"

DIR="mktemp-$VERSION"
TARBALL="mktemp-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.mktemp.org/pub/mktemp/${TARBALL}
)

MD5SUMS=(
3e66f91f8a39c7dc0a67b158aeb9c2ac
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e 's/-s $(PROG)/$(PROG)/' Makefile.in || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --with-libc || return 1
  make || return 1
  mkdir -vp $TMPROOT/usr/{bin,share/man} || return 1
  make install bindir=$TMPROOT/usr/bin \
    mandir=$TMPROOT/usr/share/man || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.mktemp.org/pub/mktemp/'
  VERSION_STRING='mktemp-%version%.tar.gz'
  MIRRORS=(
    'ftp://ftp.mktemp.org/pub/mktemp/mktemp-%version%.tar.gz'
  )
}