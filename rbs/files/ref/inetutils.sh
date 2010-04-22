#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.7"

DIR="inetutils-${VERSION}"
TARBALL="inetutils-${VERSION}.tar.gz"

DEPENDS=(
  readline
)

SRC1=(
$(gnu_mirrors inetutils ${TARBALL})
)

MD5SUMS=(
a1d5a01b0ab8a7e596ac4cff0cce7129
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ####sed -i "1i\#include <stdlib.h>" libicmp/icmp_timestamp.c || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libexecdir=/usr/sbin \
    --sysconfdir=/etc --localstatedir=/var --disable-logger --disable-syslogd \
    --disable-whois --disable-servers || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/{s,}bin || return 1
  mv $TMPROOT/usr/bin/ping{,6} $TMPROOT/bin || return 1
  chmod 4755 $TMPROOT/bin/{ping,ping6} || return 1
  rm -rf $TMPROOT/usr/{bin/ifconfig,sbin,share/man/{man1/logger.1,man8/*d.8,man5}}
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/inetutils/'
  VERSION_STRING='inetutils-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/inetutils/inetutils-%version%.tar.gz'
  )
}