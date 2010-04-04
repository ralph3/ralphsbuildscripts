#!/bin/bash

VERSION="7.8"

DIR="Mesa-${VERSION}"

DEPENDS=(
  dri2proto
  expat
  libdrm
  libxdamage
  libxi
  libxmu
  libxxf86vm
)

SRC1=(
ftp://ftp.freedesktop.org/pub/mesa/${VERSION}/MesaLib-${VERSION}.tar.bz2
)

SRC2=(
ftp://ftp.freedesktop.org/pub/mesa/${VERSION}/MesaGLUT-${VERSION}.tar.bz2
)

MD5SUMS=(
85cb891eecb89aae4fdd3499cccd934b
ca7048a4aa7a437dcc84cc2c7d731336
)

build(){
  local CONF
  unset CFLAGS CXXFLAGS
  
  CONF=
  [ "$SYSTYPE" == "MULTILIB" ] && \
    [ "$BUILD" == "$BUILD32" ] && CONF="--enable-32-bit"
  
  mkdir -p $SRCDIR || return 1
  for x in MesaLib-${VERSION}.tar.bz2 \
           MesaGLUT-${VERSION}.tar.bz2 ; do
    echo -n "Unpacking ${x}..."
    tar xfj $DOWNLOADDIR/$x -C $SRCDIR || return 1
    echo " done"
  done
  
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure $CONF --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.freedesktop.org/pub/mesa/%version%/'
  VERSION_STRING='MesaLib-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.freedesktop.org/pub/mesa/%version%/MesaLib-%version%.tar.bz2'
    'ftp://ftp.freedesktop.org/pub/mesa/%version%/MesaGLUT-%version%.tar.bz2'
  )
}
