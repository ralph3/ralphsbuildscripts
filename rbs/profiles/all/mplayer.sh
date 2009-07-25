#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0-20090712"
SYS_VERSION="1.0-20090712-1"

DIR="MPlayer-${VERSION}"
TARBALL="MPlayer-${VERSION}.tar.xz"

DEPENDS=(
  faac
  fribidi
  gtk+
  libmad
  subversion
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    svn://svn.mplayerhq.hu/mplayer/trunk/ $DIR || return 1
}

SRC1=( http://www.mplayerhq.hu/MPlayer/skins/Industrial-1.0.tar.bz2 )

MD5SUMS=( 5c42a64817d46f9ea7abd07f34ccb498 )

build(){
  unset CFLAGS CXXFLAGS
  unpack_tarball "$TARBALL" || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --target=$BUILDTARGET \
    --prefix=/usr --libdir=/usr/$LIBSDIR --confdir=/etc/mplayer \
    --enable-largefiles --enable-gui --enable-tv-v4l1 \
    --enable-tv-v4l2 || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  install -v -m755 -d $TMPROOT/usr/share/doc/mplayer-${VERSION} || return 1
  cp -v -R DOCS/* $TMPROOT/usr/share/doc/mplayer-${VERSION} || return 1
  install -m644 etc/*.conf $TMPROOT/etc/mplayer || return 1
  for x in $TMPROOT/etc/mplayer/*.conf; do
    mv $x ${x}.new
  done
  
  if [ -e "$TMPROOT/usr/bin/gmplayer" ]; then
    tar xfj $DOWNLOADDIR/Industrial-1.0.tar.bz2 -C $TMPROOT/usr/share/mplayer/skins/ || return 1
    ln -sfn Industrial $TMPROOT/usr/share/mplayer/skins/default || return 1
  fi
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

