#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.2.0"

DIR="kdebase-${VERSION}"
TARBALL="kdebase-${VERSION}.tar.bz2"

DEPENDS=(
  kdelibs
  samba
)

SRC1=(
ftp://ftp.kde.org/pub/kde/stable/latest/src/$TARBALL
)

MD5SUMS=(
da86a8ad624e86eda3a7509f39272060
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc/kde --libdir=/usr/$LIBSDIR \
    --disable-dependency-tracking || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/etc/profile.d || return 1
cat << "EOF" > $TMPROOT/etc/profile.d/kde.sh || return 1
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS}:/etc/kde/xdg
EOF
  chmod 755 $TMPROOT/etc/profile.d/kde.sh || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.kde.org/pub/kde/stable/latest/src/'
  VERSION_STRING='kdebase-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.kde.org/pub/kde/stable/latest/src/kdebase-%version%.tar.bz2'
  )
}
