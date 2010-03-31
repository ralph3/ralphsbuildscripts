#!/bin/bash

VERSION="1.1.1"
SYS_VERSION="1.1.1-1"

DIR="Linux-PAM-${VERSION}"
TARBALL="Linux-PAM-${VERSION}.tar.bz2"

DEPENDS=(
  bison
  flex
)

SRC1=(
http://www.kernel.org/pub/linux/libs/pam/library/${TARBALL}
)

SRC2=(
http://www.kernel.org/pub/linux/libs/pam/documentation/Linux-PAM-${VERSION}-docs.tar.bz2
)

MD5SUMS=(
9b3d952b173d5b9836cbc7e8de108bee
a8f77330be4a6bc73e0e584a599649b0
)

build(){
  local CONF
  CONF=
  unpack_tarball $TARBALL || return 1
  unpack_tarball Linux-PAM-${VERSION}-docs.tar.bz2 || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --libdir=/usr/$LIBSDIR \
    --sbindir=/$LIBSDIR/security --enable-securedir=/$LIBSDIR/security \
    --enable-docdir=/usr/share/doc/Linux-PAM-${VERSION} \
    --enable-read-both-confs || return 1
  cd doc/specs || return 1
  make CC=gcc CXX=g++ || return 1
  cd ../../ || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  chmod -v 4755 $TMPROOT/$LIBSDIR/security/unix_chkpwd || return 1
  mkdir -vp $TMPROOT/{etc/pam.d,sbin} || return 1
  mv -v $TMPROOT/$LIBSDIR/security/pam_tally $TMPROOT/sbin || return 1
  mv -v $TMPROOT/usr/$LIBSDIR/libpam*.so.0* $TMPROOT/$LIBSDIR || return 1
  
  for x in libpam libpamc libpam_misc; do
    ln -vsfn ../../$LIBSDIR/$(readlink $TMPROOT/$LIBSDIR/${x}.so.0) \
      $TMPROOT/usr/$LIBSDIR/${x}.so || return 1
  done
  
  find $TMPROOT/etc -type f -exec mv {} {}.tmpnew \; || return 1
  
cat << "EOF" > $TMPROOT/etc/pam.d/other.tmpnew || return 1
auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok
EOF
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.kernel.org/pub/linux/libs/pam/library/'
  VERSION_STRING='Linux-PAM-%version%.tar.bz2'
  MIRRORS=(
    'http://www.kernel.org/pub/linux/libs/pam/library/Linux-PAM-%version%.tar.bz2'
  )
}
