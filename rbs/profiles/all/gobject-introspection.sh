#!/bin/bash

VERSION="0.6.10"
SYS_VERSION="0.6.10-1"

DIR="gobject-introspection-${VERSION}"
TARBALL="gobject-introspection-${VERSION}.tar.bz2"

DEPENDS=(
  glib
  libffi
  python
  cairo
)

SRC1=(
  $(gnome_mirrors gobject-introspection)
)

MD5SUMS=(
cdf7af644a0407c3fd2d57ba2bb3549f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin \
    --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  if [ "$SYSTYPE" == "MULTILIB" ]; then
    for x in $(grep -l /usr/bin/python $TMPROOT/usr/bin/*); do
      sed -i "s%/usr/bin/python%&-${USE_ARCH}%" $x || return 1
    done
    set_multiarch $TMPROOT/usr/bin/* || return 1
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gobject-introspection/%minor_version%/'
  VERSION_STRING='gobject-introspection-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/gobject-introspection/%minor_version%/gobject-introspection-%version%.tar.bz2"
  )
}
