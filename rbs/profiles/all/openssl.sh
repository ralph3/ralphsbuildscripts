#!/bin/bash

VERSION="1.0.0"

DIR="openssl-${VERSION}"
TARBALL="openssl-${VERSION}.tar.gz"

DEPENDS=(
  perl
  pkg-config
)

SRC1=(
ftp://ftp.openssl.org/source/${TARBALL}
)

MD5SUMS=(
89eaa86e25b2845f920ec00ae4c864ed
)

build(){
  local CONF
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed 's%\"linux-generic32\"\,\"gcc\:%&-m32 %' Configure || return 1
  CONF=
  case $($CC -dumpmachine | cut -f1 -d'-') in
    i386|i486|i586|i686)
      CONF="linux-generic32"
    ;;
    x86_64)
      case $SYSTYPE in
        64BIT)
          CONF="linux-x86_64"
        ;;
        MULTILIB)
          case $BUILD in
            $BUILD32)
              CONF="linux-generic32"
            ;;
            *)
              CONF="linux-x86_64"
            ;;
          esac
        ;;
      esac
    ;;
  esac
  ./Configure $CONF --openssldir=/etc/ssl --prefix=/usr shared || return 1
  make CC="$CC $BUILD" PERL=/usr/bin/perl LIBDIR=$LIBSDIR || return 1
  make PERL=/usr/bin/perl MANDIR=/usr/share/man LIBDIR=$LIBSDIR \
    INSTALL_PREFIX=$TMPROOT install || return 1
  cp -r certs $TMPROOT/etc/ssl || return 1
  rm -rf $TMPROOT/usr/share/man || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.openssl.org/source/'
  VERSION_STRING='openssl-%version%.tar.gz'
  VERSION_FILTERS='engine BOGUS beta fips'
  MIRRORS=(
    'ftp://ftp.openssl.org/source/openssl-%version%.tar.gz'
  )
}
