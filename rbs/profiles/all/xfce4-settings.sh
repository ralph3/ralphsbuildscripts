#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20090419"
SYS_VERSION="0.0.0-20090419-3"

DIR="xfce4-settings-${VERSION}"
TARBALL="xfce4-settings-${VERSION}.tar.xz"

DEPENDS=(
  make
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/xfce/xfce4-settings/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR \
    --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm $TMPROOT/usr/share/applications/{*display*,*accessibility*} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
