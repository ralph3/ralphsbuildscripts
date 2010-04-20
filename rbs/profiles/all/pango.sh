#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.28.0"
SYS_VERSION="1.28.0-2"

DIR="pango-${VERSION}"
TARBALL="pango-${VERSION}.tar.bz2"

DEPENDS=(
  cairo
  gobject-introspection
  libxft
)

SRC1=(
  $(gnome_mirrors pango)
)

MD5SUMS=(
545ae8becf7ed74008120f96f4b095f4
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/pango-querymodules || return 1
  touch $TMPROOT/usr/$LIBSDIR/pango/pango.modules || return 1
  mkdir -p $TMPROOT/usr/sbin || return 1
cat << "EOF" > $TMPROOT/usr/sbin/setup-pango || return 1
#!/bin/bash

[ "$(id -u)" != "0" ] && {
  echo "Run me as root please." >/dev/stderr
  exit 1
}

case $SYSTYPE in
  MULTILIB)
    if [ -d "/usr/${LIBSDIR32}/pango" ]; then
      echo -n "Updating /usr/$LIBSDIR32/pango/pango.modules..."
      USE_ARCH=32 pango-querymodules > \
        /usr/$LIBSDIR32/pango/pango.modules || exit 1
      echo "  Done."
    fi
    if [ -x "/usr/${LIBSDIR64}/pango" ]; then
      echo -n "Updating /usr/$LIBSDIR64/pango/pango.modules..."
      USE_ARCH=64 pango-querymodules > \
        /usr/$LIBSDIR64/pango/pango.modules || exit 1
      echo "  Done."
    fi
  ;;
  *)
    echo -n "Updating /usr/$LIBSDIR/pango/pango.modules..."
    pango-querymodules > /usr/$LIBSDIR/pango/pango.modules || exit 1
    echo "  Done."
  ;;
esac

exit 0
EOF
  chmod 755 $TMPROOT/usr/sbin/setup-pango || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  setup-pango || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/pango/%minor_version%/'
  VERSION_STRING='pango-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/pango/%minor_version%/pango-%version%.tar.bz2'
  )
}
