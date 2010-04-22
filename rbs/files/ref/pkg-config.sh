#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.23"

DIR="pkg-config-${VERSION}"
TARBALL="pkg-config-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
  http://pkgconfig.freedesktop.org/releases/$TARBALL
)

MD5SUMS=(
d922a88782b64441d06547632fd85744
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-pc-path=/usr/share/pkgconfig || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/etc/profile.d
  case $SYSTYPE in
    MULTILIB)
cat << "EOF" > $TMPROOT/etc/profile.d/pkg-config.sh || return 1
export PKG_CONFIG_PATH32=$PKG_CONFIG_PATH32:/usr/${LIBSDIR32}/pkgconfig:/usr/share/pkgconfig
export PKG_CONFIG_PATH64=$PKG_CONFIG_PATH64:/usr/${LIBSDIR64}/pkgconfig:/usr/share/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH64
EOF
    ;;
    *)
cat << "EOF" > $TMPROOT/etc/profile.d/pkg-config.sh || return 1
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/$LIBSDIR/pkgconfig:/usr/share/pkgconfig
EOF
    ;;
  esac
  chmod 755 $TMPROOT/etc/profile.d/pkg-config.sh || return 1
  source $TMPROOT/etc/profile.d/pkg-config.sh || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://pkgconfig.freedesktop.org/releases/'
  VERSION_STRING='pkg-config-%version%.tar.gz'
  ONLY_EVEN_MINORS=0
  MIRRORS=(
    'http://pkgconfig.freedesktop.org/releases/pkg-config-%version%.tar.gz'
  )
}