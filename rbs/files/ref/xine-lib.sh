#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.14"

DIR="xine-lib-${VERSION}"
TARBALL="xine-lib-${VERSION}.tar.bz2"

DEPENDS=(
  aalib
  sdl
)

SRC1=(
http://prdownloads.sourceforge.net/xine/${TARBALL}
)

MD5SUMS=(
5b2edc264ddad48c65e0c03e009aa693
)

build(){
  local CONF F
  CONF=
  [ "$SYSTYPE" == "MULTILIB" ] && [ "$BUILD" == "$BUILD32" ] && {
    CONF="--build=$BUILDTARGET"
  }
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  unset CFLAGS CXXFLAGS
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure $CONF --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-xv-path=/usr \
    --with-w32-path=/usr/$LIBSDIR/codecs || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  F="$TMPROOT/usr/$LIBSDIR/xine/plugins/$VERSION/xineplug_inp_smb.so"
  if [ -f "$F" ]; then
    rm $F || return 1
  fi
  set_multiarch $TMPROOT/usr/bin/xine-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/xine/'
  VERSION_STRING='xine-lib-%version%.tar.bz2'
  VERSION_FILTERS='beta rc alpha'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/xine/xine-lib-%version%.tar.bz2'
  )
}
