#!/bin/bash

VERSION="1.0.5"
SYS_VERSION="1.0.5-1"

DIR="bzip2-${VERSION}"
TARBALL="bzip2-${VERSION}.tar.gz"

DEPENDS=(
  mktemp
)

SRC1=(
http://www.bzip.org/${VERSION}/bzip2-${VERSION}.tar.gz
http://www.tug.org/ftp/dist/bzip2-${VERSION}.tar.gz
http://search.belnet.be/mirror/ftp.openbsd.org/distfiles/bzip2-${VERSION}.tar.gz
http://ipcop.ath.cx/bzip2-${VERSION}.tar.gz
)

MD5SUMS=(
3c15a0c8d1d3ee1c46a1634d00617b1a
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e "s@^CFLAGS=@& $CFLAGS @" -e 's@ln @ln -sfn @g' \
         -e "s@/lib\(/\| \|$\)@/${LIBSDIR}\1@g" \
         -e "/^all:/s/ test//" Makefile || return 1
  sed -i -e "s@^CFLAGS=@& $CFLAGS @" Makefile-libbz2_so || return 1
  make -f Makefile-libbz2_so CC="$CC $BUILD" CXX="$CXX $BUILD" AR="$AR" \
    RANLIB="$RANLIB" || return 1
  make clean || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" AR="${AR}" \
    RANLIB="${RANLIB}" || return 1
  make PREFIX=/RBS-Tools install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e "s@^CFLAGS=@& $CFLAGS @" -e 's@ln @ln -sfn @g' \
         -e "s@/lib\(/\| \|$\)@/${LIBSDIR}\1@g" \
         -e "/^all:/s/ test//" Makefile || return 1
  sed -i -e "s@^CFLAGS=@& $CFLAGS @" Makefile-libbz2_so || return 1
  make -f Makefile-libbz2_so CC="$CC $BUILD" CXX="$CXX $BUILD" AR="$AR" \
    RANLIB="$RANLIB" || return 1
  make clean || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" AR="${AR}" \
    RANLIB="${RANLIB}" || return 1
  make PREFIX=$TMPROOT/usr install || return 1
  mkdir -p $TMPROOT/{bin,${LIBSDIR},usr/${LIBSDIR}} || return 1
  cp bzip2-shared $TMPROOT/bin/bzip2 || return 1
  cp -a libbz2.so* $TMPROOT/${LIBSDIR} || return 1
  ln -sfn ../../${LIBSDIR}/libbz2.so.$(echo ${VERSION} | cut -f-2 -d'.') \
    $TMPROOT/usr/${LIBSDIR}/libbz2.so || return 1
  rm $TMPROOT/usr/bin/{bunzip2,bzcat,bzip2} || return 1
  ln -sfn bzip2 $TMPROOT/bin/bunzip2 || return 1
  ln -sfn bzip2 $TMPROOT/bin/bzcat || return 1
  mkdir -vp $TMPROOT/usr/share/doc/bzip2-${VERSION} || return 1
  install -v -m 644 manual.{html,pdf,ps} bzip2.txt \
    $TMPROOT/usr/share/doc/bzip2-${VERSION}/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.bzip.org/downloads.html'
  VERSION_STRING='bzip2-%version%.tar.gz'
  MIRRORS=(
    'http://www.bzip.org/%version%/bzip2-%version%.tar.gz'
  )
}
