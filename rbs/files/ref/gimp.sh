#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.8"

DIR="gimp-${VERSION}"
TARBALL="gimp-${VERSION}.tar.bz2"

DEPENDS=(
  aalib
  alsa-lib
  babl
  curl
  gegl
  lcms
  libmng
  librsvg
  libwmf
  poppler
  pygtk
)

SRC1=(
http://gimp.mirrors.hoobly.com/gimp/v2.6/${TARBALL}
ftp://ftp.cs.umn.edu/pub/gimp/v2.6/${TARBALL}
ftp://ftp.gimp.org/pub/gimp/v2.6/${TARBALL}
)

MD5SUMS=(
a4d9462c9420954824a80c9b1963f9d9
)

build(){
  local GIMPMV
  GIMPMV="$(echo $VERSION | cut -f-2 -d'.')"
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CFLAGS="$CFLAGS -fomit-frame-pointer"
  CXXFLAGS="$CFLAGS"
  export CFLAGS CXXFLAGS
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  sed -i -e 's%GNU Image Manipulation Program%Image Editor%' \
    $TMPROOT/usr/share/applications/gimp.desktop || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  update-desktop-database -q || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.gimp.org/pub/gimp/v%minor_version%/'
  VERSION_STRING='gimp-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'ftp://ftp.gimp.org/pub/gimp/v%minor_version%/gimp-%version%.tar.bz2'
  )
}
