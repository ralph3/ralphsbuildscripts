#!/bin/bash

VERSION="2.5.35"
SYS_VERSION="2.5.35-1"

DIR="flex-${VERSION}"
TARBALL="flex-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/flex/${TARBALL}
)

MD5SUMS=(
10714e50cea54dc7a227e3eddcd44d57
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  touch doc/flex.1 || return 1
  CFLAGS="$CFLAGS -O2"
  CXXFLAGS="$CFLAGS"
  export CFLAGS CXXFLAGS
  sed -i "s/-I@includedir@//g" Makefile.in || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  ln -sfn libfl.a $TMPROOT/usr/$LIBSDIR/libl.a || return 1
  mkdir -p $TMPROOT/usr/bin
cat > $TMPROOT/usr/bin/lex << "EOF"
#!/bin/bash
exec /usr/bin/flex -l "$@"
EOF
  chmod 755 $TMPROOT/usr/bin/lex || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=97492&package_id=104304'
  VERSION_STRING='flex-%version%.tar.bz2'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/flex/flex-%version%.tar.bz2'
  )
}
