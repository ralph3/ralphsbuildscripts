#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.15.2"

DIR="kbd-${VERSION}"
TARBALL="kbd-${VERSION}.tar.gz"

DEPENDS=(
  flex
)

SRC1=(
http://ftp.altlinux.org/pub/people/legion/kbd/${TARBALL}
)

MD5SUMS=(
77d0b51454522bc6c170bbdc6e31202a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  autoreconf || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/{bin,etc/rc.d} || return 1
  mv -v $TMPROOT/usr/bin/{kbd_mode,dumpkeys,loadkeys,openvt,setfont} \
    $TMPROOT/bin || return 1
  gzip -c -d $TMPROOT/usr/share/keymaps/i386/qwerty/defkeymap.map.gz > \
    $TMPROOT/usr/share/keymaps/defkeymap.kmap || return 1
cat << "EOF" > $TMPROOT/etc/rc.d/rc.loadkeys || return 1
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Loading Default Keymap"
    loadkeys -d >&/dev/null
    evaluate_retval
  ;;
  stop) ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  chmod 755 $TMPROOT/etc/rc.d/rc.loadkeys || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.altlinux.org/pub/people/legion/kbd/'
  VERSION_STRING='kbd-%version%.tar.gz'
  VERSION_FILTERS='rc'
  MIRRORS=(
    'http://ftp.altlinux.org/pub/people/legion/kbd/kbd-%version%.tar.gz'
  )
}
