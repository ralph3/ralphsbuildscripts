#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20090419"
SYS_VERSION="0.0.0-20090419-1"

DIR="xfce4-taskmanager-${VERSION}"
TARBALL="xfce4-taskmanager-${VERSION}.tar.xz"

DEPENDS=(
  gtk+
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/goodies/xfce4-taskmanager/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  sed -i -e 's%Xfce4 Taskmanager%Taskmanager%' -e 's%System\;Utility%System%' \
    $TMPROOT/usr/share/applications/xfce4-taskmanager.desktop || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
