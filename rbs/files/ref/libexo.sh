#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20081027"
SYS_VERSION="0.0.0-20081027-1"

DIR="libexo-${VERSION}"
TARBALL="libexo-${VERSION}.tar.bz2"

DEPENDS=(
  intltool
  libxfce4util
  perl-uri
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/xfce/libexo/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/libexo \
    --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
