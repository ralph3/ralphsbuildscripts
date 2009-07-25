#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20090419"
SYS_VERSION="0.0.0-20090419-2"

DIR="xfcalendar-${VERSION}"
TARBALL="xfcalendar-${VERSION}.tar.xz"

DEPENDS=(
  xfce4-panel
  xfce-mcs-manager
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/xfce/xfcalendar/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm $TMPROOT/usr/share/applications/xfcalendar.desktop || return 1
  sed -i -e 's%Xfce 4 Calendar Settings%Calendar%' \
    $TMPROOT/usr/share/applications/xfce-xfcalendar-settings.desktop || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
