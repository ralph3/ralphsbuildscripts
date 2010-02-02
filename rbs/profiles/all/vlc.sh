#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.5"

DIR="vlc-${VERSION}"
TARBALL="vlc-${VERSION}.tar.bz2"

DEPENDS=(
  ffmpeg
  fribidi
  libmad
  qt
  sdl
)

SRC1=(
http://download.videolan.org/pub/videolan/vlc/$VERSION/${TARBALL}
)

MD5SUMS=(
d3d99e489ba1ae996af7e1065c0ef313
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --disable-postproc \
    --disable-a52 --disable-remoteosd --enable-faad || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/usr/share/pixmaps || return 1
  ln -vsfn ../vlc/vlc32x32.png $TMPROOT/usr/share/pixmaps/vlc.png || return 1
  sed -i -e 's%VLC media player%Media Player%' \
    $TMPROOT/usr/share/applications/vlc.desktop || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://download.videolan.org/pub/videolan/vlc/%version%/'
  VERSION_STRING='vlc-%version%.tar.bz2'
  MIRRORS=(
    'http://download.videolan.org/pub/videolan/vlc/%version%/vlc-%version%.tar.bz2'
  )
}
