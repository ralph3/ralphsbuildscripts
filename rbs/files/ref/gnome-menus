#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.2"

DIR="gnome-menus-${VERSION}"
TARBALL="gnome-menus-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors gnome-menus)
)

MD5SUMS=(
ca8e25b031fd7024b3f9abe1c6865d2c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/etc/profile.d
cat << "EOF" > $TMPROOT/etc/profile.d/gnome-menus.sh
if [ -z "$XDG_CONFIG_DIRS" ]; then
  XDG_CONFIG_DIRS=/etc/gnome/xdg
else
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/etc/gnome/xdg
fi
export XDG_CONFIG_DIRS
EOF
  chmod 755 $TMPROOT/etc/profile.d/gnome-menus.sh
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-menus/%minor_version%/'
  VERSION_STRING='gnome-menus-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-menus/%minor_version%/gnome-menus-%version%.tar.bz2'
  )
}
