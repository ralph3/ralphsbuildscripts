#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.30.0"
SYS_VERSION="2.30.0-4"

DIR="gnome-python-desktop-${VERSION}"
TARBALL="gnome-python-desktop-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-python
  libgnome-keyring
  libwnck
)

SRC1=(
  $(gnome_mirrors gnome-python-desktop)
)

MD5SUMS=(
a6d448d46a6b3062ce7a1b6a9fddfb48
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib \
    --disable-bugbuddy \
    --enable-rsvg \
    --enable-gnomekeyring || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-python-desktop/%minor_version%/'
  VERSION_STRING='gnome-python-desktop-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/gnome-python-desktop/%minor_version%/gnome-python-desktop-%version%.tar.bz2"
  )
}
