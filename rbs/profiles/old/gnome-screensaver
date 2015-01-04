#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.1"

DIR="gnome-screensaver-${VERSION}"
TARBALL="gnome-screensaver-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors gnome-screensaver)
)

MD5SUMS=(
f0b9cc3108bb9105141a8c22b56bf615
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnome-screensaver \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/etc/gnome/pam.d || return 1
  mkdir -p $TMPROOT/etc/pam.d || return 1
cat << "EOF" > $TMPROOT/etc/pam.d/gnome-screensaver.tmpnew || return 1
auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok
EOF
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-screensaver install || return 1
}

pre_remove(){
  gnome_script gnome-screensaver remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-screensaver/%minor_version%/'
  VERSION_STRING='gnome-screensaver-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-screensaver/%minor_version%/gnome-screensaver-%version%.tar.bz2'
  )
}
