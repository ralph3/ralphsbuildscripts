#!/bin/bash

VERSION="1.5.1"
SYS_VERSION="1.5.1-2"

DIR="glew"
TARBALL="glew-${VERSION}-src.tgz"

DEPENDS=(
  mesa
)

SRC1=(
http://prdownloads.sourceforge.net/glew/${TARBALL}
)

MD5SUMS=(
759a59853dfaae4d007b414a3c1712f2
)

build(){
  local TMACH
  TMACH=$(echo $BUILDTARGET | cut -f1 -d'-')
  
  mkdir -p $SRCDIR || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
  
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  mkdir -p $PWD/RBS-Bin || return 1
  echo "echo $TMACH" > RBS-Bin/arch || return 1
  chmod 755 RBS-Bin/arch || return 1
  export PATH=$PWD/RBS-Bin:$PATH
  
  sed -i 's%/X11R6%%g' config/* || return 1
  sed -i "s% cc% $CC $BUILD%g" config/* || return 1
  echo "echo ${TMACH}-unknown-linux-gnu" > config/config.guess || return 1
  chmod 755 config/config.guess || return 1
  
  make || return 1
  
  make BINDIR=$TMPROOT/usr/bin INCDIR=$TMPROOT/usr/include/GL \
    LIBDIR=$TMPROOT/usr/$LIBSDIR install || return 1
  
  set_multiarch $TMPROOT/usr/bin/* || return 1
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/projects/glew/files/'
  VERSION_STRING='glew-%version%-src.tgz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/glew/glew-%version%-src.tgz'
  )
}
