#!/bin/bash

VERSION="0.10.2"

DIR="ppl-${VERSION}"
TARBALL="ppl-${VERSION}.tar.bz2"

DEPENDS=(
  mpfr
)

SRC1=(
http://www.cs.unipr.it/ppl/Download/ftp/releases/$VERSION/$TARBALL
)

MD5SUMS=(
5667111f53150618b0fa522ffc53fc3e
)

RBS_Cross_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  LDFLAGS="-Wl,-rpath,/RBS-Cross-Tools/$LIBSDIR" \
    ./configure --prefix=/RBS-Cross-Tools --enable-shared --with-libgmp-prefix=/RBS-Cross-Tools \
    --with-libgmpxx-prefix=/RBS-Cross-Tools --disable-doc || return 1
  make || return 1
  mkdir Watchdog/doc/pwl-user-0.7-html \
        doc/{ppl-user-${VERSION}-html,ppl-user-c-interface-${VERSION}-html} || return 1
  touch Watchdog/doc/pwl-user-0.7-html/index.html \
        doc/{ppl-user-${VERSION}-html,ppl-user-c-interface-${VERSION}-html}/index.html || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools --libdir=/RBS-Tools/$LIBSDIR \
    --enable-shared --with-libgmp-prefix=/RBS-Tools --with-libgmpxx-prefix=/RBS-Tools || return 1
  make || return 1
  mkdir Watchdog/doc/pwl-user-0.7-html \
        doc/{ppl-user-${VERSION}-html,ppl-user-c-interface-${VERSION}-html} || return 1
  touch Watchdog/doc/pwl-user-0.7-html/index.html \
        doc/{ppl-user-${VERSION}-html,ppl-user-c-interface-${VERSION}-html}/index.html || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC -isystem /usr/include $BUILD" \
  CXX="$CXX -isystem /usr/include $BUILD" LDFLAGS="-Wl,-rpath,/$LIBSDIR $BUILD" \
    ./configure --build=$BUILDHOST --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR \
    --enable-shared --with-libgmp=/usr/$LIBSDIR --with-libgmpxx=/usr/$LIBSDIR || return 1
  make || return 1
  mkdir Watchdog/doc/pwl-user-0.7-html \
        doc/{ppl-user-${VERSION}-html,ppl-user-c-interface-${VERSION}-html} || return 1
  touch Watchdog/doc/pwl-user-0.7-html/index.html \
        doc/{ppl-user-${VERSION}-html,ppl-user-c-interface-${VERSION}-html}/index.html || return 1
  make install DESTDIR=$TMPROOT || return 1
  if [ "$SYSTYPE" == "MULTILIB" ]; then
    set_multiarch $TMPROOT/usr/bin/ppl-config || return 1
    mv -v $TMPROOT/usr/include/ppl{,-${USE_ARCH}}.hh || return 1
cat > $TMPROOT/usr/include/ppl.hh << "EOF" || return 1
#ifndef __STUB__PPL_HH__
#define __STUB__PPL_HH__

#if defined(__x86_64__) || \
    defined(__sparc64__) || \
    defined(__arch64__) || \
    defined(__powerpc64__) || \
    defined (__s390x__)
# include "ppl-64.hh"
#else
# include "ppl-32.hh"
#endif

#endif
EOF
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.cs.unipr.it/ppl/Download/ftp/releases/%version%/'
  VERSION_STRING='ppl-%version%.tar.bz2'
  MIRRORS=(
    'http://www.cs.unipr.it/ppl/Download/ftp/releases/%version%/ppl-%version%.tar.bz2'
  )
}
