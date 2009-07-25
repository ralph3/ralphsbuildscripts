#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20090419"

DIR="xfwm4-themes-${VERSION}"
TARBALL="xfwm4-themes-${VERSION}.tar.xz"

DEPENDS=(
  make
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/xfce/xfwm4-themes/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch xfwm4-themes-0.0.0-20090419-automake-1.11-1.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --enable-compositor || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
