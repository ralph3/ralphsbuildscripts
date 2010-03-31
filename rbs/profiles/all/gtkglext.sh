#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.0"
SYS_VERSION="1.2.0-1"

DIR="gtkglext-${VERSION}"
TARBALL="gtkglext-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
)

SRC1=(
  $(gnome_mirrors gtkglext)
)

MD5SUMS=(
ed7ba24ce06a8630c07f2d0ee5f04ab4
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ####
  #
  # GTK 2.20.* fix
  #
  sed -i -e 's%GTK_WIDGET_REALIZED%gtk_widget_get_realized%g' \
    -e 's%GTK_WIDGET_TOPLEVEL%gtk_widget_is_toplevel%g' \
    -e 's%GTK_WIDGET_NO_WINDOW%gtk_widget_get_has_window%g' \
    gtk/gtkglwidget.c || return 1
  #
  #####
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gtkglext/%minor_version%/'
  VERSION_STRING='gtkglext-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/gtkglext/%minor_version%/gtkglext-%version%.tar.bz2"
  )
}
