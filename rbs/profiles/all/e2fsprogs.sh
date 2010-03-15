#!/bin/bash

VERSION="1.41.11"

DIR="e2fsprogs-${VERSION}"
TARBALL="e2fsprogs-${VERSION}.tar.gz"

DEPENDS=(
  util-linux
)

SRC1=(
http://prdownloads.sourceforge.net/e2fsprogs/${TARBALL}
)

MD5SUMS=(
fb507a40c2706bc38306f150d069e345
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e "/libdir=.*\/lib/s@/lib@/${LIBSDIR}@g" configure || return 1
  cd $SRCDIR || return 1
  rm -rf e2fsprogs-build || return 1
  mkdir -p $SRCDIR/e2fsprogs-{build,tmproot} || return 1
  cd $SRCDIR/e2fsprogs-build || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CFLAGS="$CFLAGS -fPIC" ../$DIR/configure \
    --build=$BUILDHOST --host=$BUILDTARGET --prefix=/usr --with-root-prefix="" \
    --enable-elf-shlibs || return 1
  make || return 1
  make install DESTDIR=$SRCDIR/e2fsprogs-tmproot || return 1
  make install-libs DESTDIR=$SRCDIR/e2fsprogs-tmproot || return 1
  
  find $SRCDIR/e2fsprogs-tmproot -name '*blkid*' -exec rm -rf {} \;
  find $SRCDIR/e2fsprogs-tmproot -name '*uuid*' -exec rm -rf {} \;
  
  cp -a $SRCDIR/e2fsprogs-tmproot/* $ROOT || return 1
  
  cd ../ || return 1
  rm -rf $DIR e2fsprogs-{build,tmproot} || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "/libdir=.*\/lib/s@/lib@/${LIBSDIR}@g" configure || return 1
  mkdir -p $SRCDIR/e2fsprogs-build || return 1
  cd $SRCDIR/e2fsprogs-build || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CFLAGS="$CFLAGS -fPIC" ../$DIR/configure \
    --build=$BUILDHOST --host=$BUILDTARGET --prefix=/usr --with-root-prefix="" \
    --enable-elf-shlibs --disable-libuuid --disable-libblkid || return 1
  make || return 1
  make LN='ln -s' install DESTDIR=$TMPROOT || return 1
  make install-libs DESTDIR=$TMPROOT || return 1
  
  mkdir -p $TMPROOT/$LIBSDIR || return 1
  mv $TMPROOT/usr/$LIBSDIR/*.so* $TMPROOT/$LIBSDIR || return 1
  find $TMPROOT/$LIBSDIR -type l -name '*.so*' | while read l; do
    ln -vsfn $(basename $(readlink $l)) $l || return 1
  done
  find $TMPROOT/$LIBSDIR -type l -name '*.so*' | while read l; do
    B=$(basename $l)
    ln -vsfn ../../$LIBSDIR/$(basename $(readlink $l)) \
      $TMPROOT/usr/$LIBSDIR/$B || return 1
  done
  find $TMPROOT/$LIBSDIR -type f -name '*.so*' | while read l; do
    B=$(basename $l)
    ln -vsfn ../../$LIBSDIR/$B $TMPROOT/usr/$LIBSDIR/$B || return 1
  done
  
  find $TMPROOT -type l | while read l; do
    ln -sfn $(readlink $l | sed "s%${TMPROOT}%/%") $l || return 1
  done
  
  cd ../ || return 1
  rm -rf $DIR e2fsprogs-build || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=2406&package_id=2374'
  VERSION_STRING='e2fsprogs-%version%.tar.gz'
  VERSION_FILTERS='[A-Z] [a-z]'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-%version%.tar.gz'
  )
}
