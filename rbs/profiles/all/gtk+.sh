#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.18.1"

DIR="gtk+-${VERSION}"
TARBALL="gtk+-${VERSION}.tar.bz2"

DEPENDS=(
  atk
  cups
  gtk-doc
  libtiff
  libxcursor
  libxinerama
  pango
)

SRC1=(
  $(gnome_mirrors gtk+)
)

MD5SUMS=(
d6e0f982a84d393cd11e2ea90a9e3775
)

build(){
  local MV
  MV="$(echo $VERSION | cut -b1).0"
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/usr/$LIBSDIR \
    --disable-gtk-doc --without-libjasper || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR \
    sysconfdir=$TMPROOT/usr/$LIBSDIR || return 1
  set_multiarch $TMPROOT/usr/bin/gdk-pixbuf-query-loaders || return 1
  set_multiarch $TMPROOT/usr/bin/gtk-query-immodules-${MV} || return 1
  mkdir -p $TMPROOT/usr/sbin || return 1
cat << "EOF" > $TMPROOT/usr/sbin/setup-gtk || return 1
#!/bin/bash

[ "$(id -u)" != "0" ] && {
  echo "Run me as root please." >/dev/stderr
  exit 1
}

GTKMV="$(cat /var/lib/packages/current/gtk+/version | cut -b1).0"

query_crap(){
  if [ -d "/usr/${1}/gtk-${GTKMV}" ]; then
    echo -n "Updating /usr/$1/gtk-${GTKMV}/gdk-pixbuf.loaders..."
    gdk-pixbuf-query-loaders > /usr/$1/gtk-${GTKMV}/gdk-pixbuf.loaders || return 1
    echo "  Done."
    echo -n "Updating /usr/$1/gtk-${GTKMV}/gtk.immodules..."
    gtk-query-immodules-${GTKMV} > /usr/$1/gtk-${GTKMV}/gtk.immodules || return 1
    echo "  Done."
  fi
  return 0
}

case $SYSTYPE in
  MULTILIB)
    export USE_ARCH=32
    query_crap $LIBSDIR32 || exit 1
    export USE_ARCH=64
    query_crap $LIBSDIR64 || exit 1
  ;;
  *)
    query_crap $LIBSDIR || exit 1
  ;;
esac

exit 0
EOF
  chmod 755 $TMPROOT/usr/sbin/setup-gtk || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  setup-gtk || return 1
}

post_upgrade(){
  post_install
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gtk+/%minor_version%/'
  VERSION_STRING='gtk+-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gtk+/%minor_version%/gtk+-%version%.tar.bz2'
  )
}
