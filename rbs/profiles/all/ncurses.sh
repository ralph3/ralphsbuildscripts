#!/bin/bash

VERSION="5.7"
SYS_VERSION="5.7-2"

DIR="ncurses-${VERSION}"
TARBALL="ncurses-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/ncurses/${TARBALL}
)

MD5SUMS=(
cce05daf61a64501ef6cd8da1f727ec6
)

RBS_Cross_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ./configure --prefix=/RBS-Tools --without-shared --without-debug || return 1
  make -C include || return 1
  make -C progs tic || return 1
  install -m755 progs/tic /RBS-Cross-Tools/bin/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools --libdir=/RBS-Tools/$LIBSDIR \
    --with-shared --without-debug --without-ada --enable-overwrite \
    --with-build-cc=gcc || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  local v
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/$LIBSDIR --with-shared \
    --without-debug || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/usr/$LIBSDIR || return 1
  mv -v $TMPROOT/$LIBSDIR/lib{panel,menu,form,ncurses,ncurses++,curses}.a \
    $TMPROOT/usr/$LIBSDIR || return 1
  rm -v $TMPROOT/$LIBSDIR/lib{ncurses,menu,panel,form,curses}.so || return 1
  v=$(echo ${VERSION} | cut -b1)
  ln -svf ../../$LIBSDIR/libncurses.so.$v $TMPROOT/usr/$LIBSDIR/libcurses.so || return 1
  ln -svf ../../$LIBSDIR/libncurses.so.$v $TMPROOT/usr/$LIBSDIR/libncurses.so || return 1
  ln -svf ../../$LIBSDIR/libmenu.so.$v $TMPROOT/usr/$LIBSDIR/libmenu.so || return 1
  ln -svf ../../$LIBSDIR/libpanel.so.$v $TMPROOT/usr/$LIBSDIR/libpanel.so || return 1
  ln -svf ../../$LIBSDIR/libform.so.$v $TMPROOT/usr/$LIBSDIR/libform.so || return 1
  chmod 755 $TMPROOT/$LIBSDIR/lib{panel,menu,form,ncurses}.so.$VERSION
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/ncurses/'
  VERSION_STRING='ncurses-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/ncurses/ncurses-%version%.tar.gz'
  )
}
