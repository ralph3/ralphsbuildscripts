#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.7"
SYS_VERSION="1.1.7-1"

DIR="xvidcap-${VERSION}"
TARBALL="xvidcap-${VERSION}.tar.gz"

DEPENDS=(
  ffmpeg
  gtk+
)

SRC1=(
http://prdownloads.sourceforge.net/xvidcap/${TARBALL}
)

MD5SUMS=(
b39a682d3ef9fcbf424af771936780e2
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  do_patch xvidcap-1.1.7-ffmpeg-20090601x-1.patch || return 1
  
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  for x in C de es it; do
    touch doc/xvidcap/$x/xvidcap-${x}.omf.out || return 1
  done
  make install DESTDIR=$TMPROOT || return 1
  sed -i -e 's%XVidCap Screen Capture%Video Screen Capture%' \
    -e 's%X11 Screencam%Video Screen Capture%' \
    $TMPROOT/usr/share/applications/xvidcap.desktop || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=81535&package_id=83441'
  VERSION_STRING='xvidcap-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/xvidcap/xvidcap-%version%.tar.gz'
  )
}
