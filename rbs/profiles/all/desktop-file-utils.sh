#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.15"

DIR="desktop-file-utils-${VERSION}"
TARBALL="desktop-file-utils-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://freedesktop.org/software/desktop-file-utils/releases/${TARBALL}
)

MD5SUMS=(
2fe8ebe222fc33cd4a959415495b7eed
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/etc/profile.d
cat << "EOF" > $TMPROOT/etc/profile.d/desktop-file-utils.sh
if [ -z "$XDG_DATA_DIRS" ]; then
  XDG_DATA_DIRS=/usr/share
else
  XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share
fi
export XDG_DATA_DIRS
EOF
  chmod 755 $TMPROOT/etc/profile.d/desktop-file-utils.sh || return 1
  source $TMPROOT/etc/profile.d/desktop-file-utils.sh || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://freedesktop.org/software/desktop-file-utils/releases/'
  VERSION_STRING='desktop-file-utils-%version%.tar.gz'
  MIRRORS=(
    'http://freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-%version%.tar.gz'
  )
}
