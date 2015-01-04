#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="gnome-session-${VERSION}"
TARBALL="gnome-session-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-settings-daemon
  sound-theme-freedesktop
)

SRC1=(
  $(gnome_mirrors gnome-session)
)

MD5SUMS=(
5daf3307ec791953436484696b263093
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" LDFLAGS="-L/usr/${LIBSDIR}" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  mkdir -p $TMPROOT/etc/X11/xinit
cat << "EOF" > $TMPROOT/etc/X11/xinit/gnome.xinitrc
dbus-launch --exit-with-session gnome-session
EOF
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-session install || return 1
  if [ ! -e "/etc/X11/xinit/default.xinitrc" ]; then
    ln -sfn gnome.xinitrc /etc/X11/xinit/default.xinitrc || return 1
  fi
}

pre_remove(){
  gnome_script gnome-session remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-session/%minor_version%/'
  VERSION_STRING='gnome-session-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-session/%minor_version%/gnome-session-%version%.tar.bz2'
  )
}
