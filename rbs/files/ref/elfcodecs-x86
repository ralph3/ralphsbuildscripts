#!/bin/bash

DISABLE_MULTILIB=1

VERSION="20040703"
SYS_VERSION="20040703-1"

ONLY32=1

DIR="elfcodecs_x86-${VERSION}"

DEPENDS=(
  glibc
)

SRC1=(
http://www1.mplayerhq.hu/MPlayer/releases/codecs/rp8codecs-20040626.tar.bz2
http://mirror.etf.bg.ac.yu/MPlayer/releases/codecs/rp8codecs-20040626.tar.bz2
http://ftp.iasi.rdsnet.ro/mirrors/ftp.mplayerhq.hu/Releases/codecs/rp8codecs-20040626.tar.bz2
http://ftp.lug.udel.edu/MPlayer/releases/codecs/rp8codecs-20040626.tar.bz2
http://www2.mplayerhq.hu/MPlayer/releases/codecs/rp8codecs-20040626.tar.bz2
)

SRC2=(
http://www1.mplayerhq.hu/MPlayer/releases/codecs/rp9codecs-20050115.tar.bz2
http://mirror.etf.bg.ac.yu/MPlayer/releases/codecs/rp9codecs-20050115.tar.bz2
http://ftp.iasi.rdsnet.ro/mirrors/ftp.mplayerhq.hu/Releases/codecs/rp9codecs-20050115.tar.bz2
http://ftp.lug.udel.edu/MPlayer/releases/codecs/rp9codecs-20050115.tar.bz2
http://www2.mplayerhq.hu/MPlayer/releases/codecs/rp9codecs-20050115.tar.bz2
)

MD5SUMS=(
c9ae3969ba1e73a8cbeef38f5803fd2e
a32f4fa1f77593536a57e4b662fde7aa
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
  mkdir -p $SRCDIR/$DIR || return 1
  cd $SRCDIR/$DIR || return 1
  tar xfj $DOWNLOADDIR/rp8codecs-20040626.tar.bz2 || return 1
  tar xfj $DOWNLOADDIR/rp9codecs-20050115.tar.bz2 || return 1
  mkdir -vp $TMPROOT/usr/$LIBSDIR/codecs
  for file in */*so*; do
    cp -va $file $TMPROOT/usr/$LIBSDIR/codecs/ || return 1
  done
  cd ../ || return 1
  rm -rf $DIR || return 1
}
