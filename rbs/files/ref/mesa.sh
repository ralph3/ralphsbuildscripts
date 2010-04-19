#!/bin/bash

VERSION="7.8.1"
SYS_VERSION="7.8.1-2"

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

SRC3=(
ftp://ftp.freedesktop.org/pub/mesa/${VERSION}/MesaDemos-${VERSION}.tar.bz2
)

MD5SUMS=(
25ec15f8e41fde6d206118cc786dbac4
6bae516a44c6d26ff3152c960ab648e7
9ef47f911869657c6bf2f43ebce86b61
)

build(){
  local CONF
  unset CFLAGS CXXFLAGS
  
  CONF=
  [ "$SYSTYPE" == "MULTILIB" ] && \
    [ "$BUILD" == "$BUILD32" ] && CONF="--enable-32-bit"
  
  mkdir -p $SRCDIR || return 1
  for x in MesaLib-${VERSION}.tar.bz2 \
           MesaGLUT-${VERSION}.tar.bz2 \
           MesaDemos-${VERSION}.tar.bz2; do
    echo -n "Unpacking ${x}..."
    tar xfj $DOWNLOADDIR/$x -C $SRCDIR || return 1
    echo " done"
  done
  
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure $CONF --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  
  mkdir -vp $TMPROOT/usr/bin || return 1
  install -m755 -v progs/xdemos/{glxinfo,glxgears} $TMPROOT/usr/bin/ || return 1
  set_multiarch $TMPROOT/usr/bin/{glxinfo,glxgears} || return 1
  
  if [ "$SYSTYPE" == "MULTILIB" ] && [ "$BUILD" == "$BUILD32" ]; then
    rm -rf $TMPROOT/$LIBSDIR/dri || return 1
  fi
  
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.freedesktop.org/pub/mesa/%version%/'
  VERSION_STRING='MesaLib-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.freedesktop.org/pub/mesa/%version%/MesaLib-%version%.tar.bz2'
    'ftp://ftp.freedesktop.org/pub/mesa/%version%/MesaGLUT-%version%.tar.bz2'
    'ftp://ftp.freedesktop.org/pub/mesa/%version%/MesaDemos-%version%.tar.bz2'
  )
}
