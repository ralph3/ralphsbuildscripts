#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20081027"
SYS_VERSION="0.0.0-20081027-1"

DIR="terminal-${VERSION}"
TARBALL="terminal-${VERSION}.tar.bz2"

DEPENDS=(
  vte
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/xfce/terminal/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR \
    --sysconfdir=/etc || return 1
  find -name 'Makefile' -exec sed -i 's%-Werror%%g' {} \;
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}