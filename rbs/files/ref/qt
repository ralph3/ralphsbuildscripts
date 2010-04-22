#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.3.8"


DIR="qt-x11-free-${VERSION}"
TARBALL="qt-x11-free-${VERSION}.tar.bz2"

DEPENDS=(
  cups
  libjpeg
  libmng
)

SRC1=(
http://ftp.silug.org/mirrors/ftp.trolltech.com/qt/source/$TARBALL
)

MD5SUMS=(
cf3c43a7dfde5bfb76f8001102fe6e85
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "s@/usr/X11R6@/usr@g" $(grep -lr "X11R6" *) || return 1
  sed -i -e 's:$(QTDIR)/include:&/qt:' -e 's:$(QTDIR)/lib:&/qt:' \
    mkspecs/linux*/qmake.conf || return 1
  sed -i 's%read acceptance%acceptance=yes%' configure || return 1
  if [ "$LIBSDIR" == "lib64" ]; then
    sed -i "/^QMAKE_LIBDIR_QT/s:/lib:&64:" \
      mkspecs/linux-g++-64/qmake.conf || return 1
    export QMAKESPEC=linux-g++-64
  fi
  case $USE_ARCH in
    32)
      export QMAKESPEC=linux-g++-32
    ;;
    64)
      export QMAKESPEC=linux-g++-64
    ;;
  esac
  export PATH=$PWD/bin:$PATH
  export LD_LIBRARY_PATH=$PWD/lib:$LD_LIBRARY_PATH
  ./configure -prefix /usr \
    -libdir /usr/$LIBSDIR \
    -docdir /usr/share/doc/qt \
    -headerdir /usr/include/qt \
    -datadir /usr/share/qt \
    -plugindir /usr/$LIBSDIR/qt/plugin \
    -translationdir /usr/share/qt/translations \
    -sysconfdir /etc/qt \
    -qt-gif \
    -system-zlib \
    -system-libpng \
    -system-libjpeg \
    -system-libmng \
    -plugin-imgfmt-png \
    -plugin-imgfmt-jpeg \
    -plugin-imgfmt-mng \
    -no-exceptions \
    -thread \
    -tablet || return 1
  find -type f -name Makefile | xargs sed -i \
    "s@-Wl,-rpath,/usr/${LIBSDIR}@@g" || return 1
  make || return 1
  make install INSTALL_ROOT=$TMPROOT || return 1
  mkdir -vp $TMPROOT/usr/share/doc/qt || return 1
  cp -Rv doc/man $TMPROOT/usr/share || return 1
  cp -Rv examples $TMPROOT/usr/share/doc/qt || return 1
  ln -svf libqt-mt.so $TMPROOT/usr/$LIBSDIR/libqt.so
  set_multiarch $TMPROOT/usr/bin/qmake || return 1
  set_multiarch $TMPROOT/usr/bin/uic || return 1
  set_multiarch $TMPROOT/usr/bin/moc || return 1
  set_multiarch $TMPROOT/usr/bin/qtconfig || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.silug.org/mirrors/ftp.trolltech.com/qt/source/'
  VERSION_STRING='qt-x11-free-%version%.tar.bz2'
  MINOR_VERSION='3'
  MIRRORS=(
    'http://ftp.silug.org/mirrors/ftp.trolltech.com/qt/source/qt-x11-free-%version%.tar.bz2'
  )
}
