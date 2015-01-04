#!/bin/bash

DISABLE_MULTILIB=1

VERSION="20040703"
SYS_VERSION="20040703-1"


DEPENDS=(
  filesystem
)

DIR="win32codecs-${VERSION}"
TARBALL="win32codecs-${VERSION}.tar.bz2"

SRC1=(
http://www1.mplayerhq.hu/MPlayer/releases/codecs/${TARBALL}
http://mirror.etf.bg.ac.yu/MPlayer/releases/codecs/${TARBALL}
http://ftp.iasi.rdsnet.ro/mirrors/ftp.mplayerhq.hu/Releases/codecs/${TARBALL}
http://ftp.lug.udel.edu/MPlayer/releases/codecs/${TARBALL}
http://www2.mplayerhq.hu/MPlayer/releases/codecs/${TARBALL}
)

MD5SUMS=(
90ba6a76ded2f9fd9f865024bd8de3d3
)

build(){
  check_my_arch(){
    case $($CC -dumpmachine | cut -f1 -d'-') in
      i?86|x86_64)
        if [ "$SYSTYPE" != "64BIT" ]; then
          return 0
        fi
      ;;
    esac
    echo "I can only be installed on x86 or x86_64-32BIT!"
    return 1
  }
  check_my_arch || return 1
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  chmod 644 * || return 1
  mkdir -vp $TMPROOT/usr/$LIBSDIR/codecs
  cp -v * $TMPROOT/usr/$LIBSDIR/codecs/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}
