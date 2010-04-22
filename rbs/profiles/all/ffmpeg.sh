#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.5.1"
SYS_VERSION="0.5.1-1"

DIR="ffmpeg-${VERSION}"
TARBALL="${DIR}.tar.bz2"

DEPENDS=(
  faac
  faad
  freetype
  xvidcore
)

#my_src1(){
#  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
#    svn://svn.ffmpeg.org/ffmpeg/trunk $DIR || return 1
#}

SRC1=(
http://www.ffmpeg.org/releases/$TARBALL
)

MD5SUMS=(
c7b0e1729f7aafb10496d79bb963bb26
)

build(){
  unpack_tarball "$TARBALL" || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --arch=$(echo $BUILDTARGET | cut -f1 -d'-') --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-shared --enable-pthreads --enable-libfaac \
    --enable-libfaad --enable-libxvid --enable-gpl --enable-nonfree \
    --enable-encoder=mp4a --enable-decoder=mp4a --enable-postproc \
    --enable-swscale || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install DESTDIR=$TMPROOT || return 1
  
  if [ "lib" != "$LIBSDIR" ] && [ -d "$TMPROOT/usr/lib" ]; then
    cp -a $TMPROOT/usr/lib/* $TMPROOT/usr/$LIBSDIR || return 1
    rm -rf $TMPROOT/usr/lib
  fi
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.ffmpeg.org/releases/'
  VERSION_STRING='ffmpeg-%version%.tar.bz2'
  VERSION_FILTERS='export checkout'
  MIRRORS=(
    'http://www.ffmpeg.org/releases/ffmpeg-%version%.tar.bz2'
  )
}
