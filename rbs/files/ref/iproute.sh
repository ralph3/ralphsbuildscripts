#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.33"

DIR="iproute2-${VERSION}"
TARBALL="iproute2-${VERSION}.tar.bz2"

DEPENDS=(
  flex
)

SRC1=(
  http://developer.osdl.org/dev/iproute2/download/$TARBALL
)

MD5SUMS=(
b371fca3fcb5e436e69a7c2111d84a3c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i '/^TARGETS/s@arpd@@g' misc/Makefile || return 1
  sed -i "s%/lib/tc%/${LIBSDIR}/tc%g" $(grep -rl "/lib/tc" *) || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" LIBDIR=/usr/$LIBSDIR \
    SBINDIR=/sbin || return 1
  make LIBDIR=/usr/$LIBSDIR  SBINDIR=/sbin install \
    DESTDIR=$TMPROOT || return 1
  if [ "$LIBSDIR" != "lib" ] && [ -d "$TMPROOT/usr/lib" ]; then
    cp -a $TMPROOT/usr/lib $TMPROOT/usr/$LIBSDIR || return 1
    rm -rf $TMPROOT/usr/lib || return 1
  fi
  for x in $TMPROOT/etc/iproute2/*; do
    [ -f "$x" ] && mv $x ${x}.tmpnew
  done
  [ -e "$TMPROOT/sbin/arpd" ] && {
    mkdir -p $TMPROOT/usr/sbin
    mv $TMPROOT/sbin/arpd $TMPROOT/usr/sbin/ || return 1
  }
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://developer.osdl.org/dev/iproute2/download/'
  VERSION_STRING='iproute2-%version%.tar.bz2'
  MINOR_VERSION="2"
  VERSION_FILTERS="rc"
  MIRRORS=(
    'http://ftp.gnu.org/gnu/iproute2/iproute2-%version%.tar.bz2'
  )
}