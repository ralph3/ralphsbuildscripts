#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.4.43-1"

DIR="attr-$(echo $VERSION | cut -f 1 -d '-')"
TARBALL="attr_${VERSION}.tar.gz"

DEPENDS=(
  libtool
)

SRC1=(
ftp://oss.sgi.com/projects/xfs/cmd_tars/${TARBALL}
)

MD5SUMS=(
91583a14bcbd637adaa9b07ea49c5d4b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i Makefile -e '/autoconf/d' \
    -e 's@default: $(CONFIGURE)@default:@' || return 1
  sed -i "/AC_OUTPUT/i\AC_PROG_LIBTOOL" configure.in || return 1
  cp -v install-sh{,.orig} || return 1
  libtoolize -f || return 1
  cp -vf install-sh{.orig,} || return 1
  aclocal -I m4 || return 1
  autoconf || return 1
  CC="gcc $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/ \
    --exec-prefix=/ --sbindir=/sbin --bindir=/usr/sbin --libdir=/lib \
    --libexecdir=/usr/lib --includedir=/usr/include \
    --mandir=/usr/share/man --datadir=/usr/share || return 1
  make DEBUG=-DNDEBUG LIBTOOL="$PWD/libtool" || return 1
  mkdir -vp $TMPROOT/usr/{bin,${LIBSDIR},include,share/{doc,man}} || return 1
  make PKG_BIN_DIR=$TMPROOT/usr/bin PKG_LIB_DIR=$TMPROOT/usr/$LIBSDIR \
    PKG_DOC_DIR=$TMPROOT/usr/share/doc PKG_MAN_DIR=$TMPROOT/usr/share/man \
    PKG_INC_DIR=$TMPROOT/usr/include \
    install install-dev install-lib || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://oss.sgi.com/projects/xfs/cmd_tars/'
  VERSION_STRING='attr_%version%.tar.gz'
  MIRRORS=(
    "ftp://oss.sgi.com/projects/xfs/cmd_tars/attr_%version%.tar.gz"
  )
}
