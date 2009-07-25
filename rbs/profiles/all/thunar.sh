#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20090419"
SYS_VERSION="0.0.0-20090419-3"

DIR="thunar-${VERSION}"
TARBALL="thunar-${VERSION}.tar.xz"

DEPENDS=(
  gamin
  startup-notification
  xfconf
  xfce4-icon-theme
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    http://svn.xfce.org/svn/xfce/thunar/trunk/ $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./autogen.sh --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/thunarx-1 \
    --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm $(find $TMPROOT -name '*ename*' -type f | sed '/\.h$/d') || return 1
  sed -i -e 's%Thunar File Manager%File Manager%' \
    -e 's%System\;Utility\;Core\;GTK\;FileManager%System%' \
    $TMPROOT/usr/share/applications/Thunar.desktop || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
