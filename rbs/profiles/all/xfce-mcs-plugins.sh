#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20090419"
SYS_VERSION="0.0.0-20090419-1"

DIR="xfce-mcs-plugins-${VERSION}"
TARBALL="xfce-mcs-plugins-${VERSION}.tar.xz"

DEPENDS=(
  make
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/xfce/xfce-mcs-plugins/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i 's%-Werror%%g' $(grep -rl "\-Werror" *) || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm $(find $TMPROOT -name '*display*' -type f) || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
