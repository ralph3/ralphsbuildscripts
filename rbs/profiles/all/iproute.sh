#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.22-070710"
SYS_VERSION="2.6.22-070710-2"

DIR="iproute-${VERSION}"
TARBALL="iproute2-${VERSION}.tar.gz"

DEPENDS=(
  db
  flex
)

SRC1=(
  http://developer.osdl.org/dev/iproute2/download/$TARBALL
)

MD5SUMS=(
20ef2767896a0f156b6fbabd47936f79
)

build(){
  mkdir -p $SRCDIR/$DIR || return 1
  cd $SRCDIR/$DIR || return 1
  tar xfz $DOWNLOADDIR/$TARBALL || return 1
  for dir in ip misc tc; do
    sed -i 's/0755 -s/0755/' ${dir}/Makefile || return 1
  done
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
  VERSION_STRING='iproute2-%version%.tar.gz'
  MINOR_VERSION="2"
  VERSION_FILTERS="rc"
  MIRRORS=(
    'http://ftp.gnu.org/gnu/iproute2/iproute2-%version%.tar.gz'
  )
}
