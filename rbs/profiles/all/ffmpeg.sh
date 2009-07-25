#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20090601"
SYS_VERSION="0.0.0-20090601-3"

DIR="ffmpeg-${VERSION}"
TARBALL="${DIR}.tar.xz"

DEPENDS=(
  faac
  faad
  freetype
  xvidcore
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    svn://svn.ffmpeg.org/ffmpeg/trunk $DIR || return 1
}

build(){
  unpack_tarball "$TARBALL" || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --arch=$(echo $BUILDTARGET | cut -f1 -d'-') --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-shared --enable-pthreads --enable-libfaac \
    --enable-libfaad --enable-libxvid --enable-gpl --enable-nonfree \
    --enable-encoder=mp4a --enable-decoder=mp4a --enable-postproc || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install DESTDIR=$TMPROOT || return 1
  
  if [ "lib" != "$LIBSDIR" ] && [ -d "$TMPROOT/usr/lib" ]; then
    cp -a $TMPROOT/usr/lib/* $TMPROOT/usr/$LIBSDIR || return 1
    rm -rf $TMPROOT/usr/lib
  fi
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

