#!/bin/bash

VERSION="7.5"
SYS_VERSION="7.5-2"

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
http://prdownloads.sourceforge.net/mesa3d/MesaLib-${VERSION}.tar.bz2
)

SRC2=(
http://prdownloads.sourceforge.net/mesa3d/MesaGLUT-${VERSION}.tar.bz2
)

MD5SUMS=(
459f332551f6ebb86f384d21dd15e1f0
baa7a1e850b6e39bae58868fd0684004
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
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=3&package_id=2436'
  VERSION_STRING='MesaLib-%version%.tar.bz2'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/mesa3d/MesaLib-%version%.tar.bz2'
    'http://prdownloads.sourceforge.net/mesa3d/MesaGLUT-%version%.tar.bz2'
  )
}
