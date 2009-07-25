#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.12"
SYS_VERSION="1.12-1"

DIR="kbd-${VERSION}"
TARBALL="kbd-${VERSION}.tar.gz"

DEPENDS=(
  flex
)

SRC1=(
ftp://ftp.win.tue.nl/pub/linux-local/utils/kbd/${TARBALL}
)

MD5SUMS=(
7892c7010512a9bc6697a295c921da25
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch kbd-1.12-gcc4_fixes-1.patch || return 1
  sed -i -e "s@&& ./conftest@@" configure || return 1
  sed -i -e 's%install -s%install%g' src/Makefile.in || return 1
  ./configure --datadir=/$LIBSDIR/kbd || return 1
  echo "#define   LC_ALL            0" > defines.h || return 1
  sed -i "/^ARCH/s/=.*/=$($CC -dumpmachine | cut -f1 -d'-')/" \
    make_include || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/bin || return 1
  mv -v $TMPROOT/usr/bin/{kbd_mode,openvt,setfont} $TMPROOT/bin || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.win.tue.nl/pub/linux-local/utils/kbd/'
  VERSION_STRING='kbd-%version%.tar.gz'
  MIRRORS=(
    'ftp://ftp.win.tue.nl/pub/linux-local/utils/kbd/kbd-%version%.tar.gz'
  )
}
