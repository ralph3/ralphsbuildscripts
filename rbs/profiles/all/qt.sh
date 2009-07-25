#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.5.2"
SYS_VERSION="4.5.2-1"

DIR="qt-x11-opensource-src-${VERSION}"
TARBALL="qt-x11-opensource-src-${VERSION}.tar.bz2"

DEPENDS=(
  cups
  libjpeg
  libmng
)

SRC1=(
http://mirrors.cs.uri.edu/gentoo/distfiles/$TARBALL
ftp://ftp.trolltech.com/qt/source/$TARBALL
)

MD5SUMS=(
28a7e8ac9805a6f614d2a27ee1a6ac9d
)

build(){
  mkdir -p $HDSRCDIR || return 1
  echo -n "Unpacking ${TARBALL}..."
  tar xfj $DOWNLOADDIR/$TARBALL -C $HDSRCDIR || return 1
  echo "Done."
  cd $HDSRCDIR/$DIR || return 1
  sed -i "s@/usr/X11R6@/usr@g" $(grep -lr "X11R6" *) || return 1
  sed -i 's%COMMERCIAL_USER=ask%COMMERCIAL_USER=no%' configure || return 1
  sed -i 's%OPT_CONFIRM_LICENSE=no%OPT_CONFIRM_LICENSE=yes%' \
    configure || return 1
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
    -system-libtiff \
    -system-libpng \
    -system-libjpeg \
    -system-libmng \
    -openssl \
    -opengl \
    -glib \
    -stl \
    -reduce-relocations \
    -no-separate-debug-info \
    -release \
    -nomake demos \
    -nomake examples || return 1
  make || return 1
  make install INSTALL_ROOT=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build_OOOOOOOLD(){
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
  ADDRESS='ftp://ftp.trolltech.com/qt/source/'
  VERSION_STRING='qt-x11-opensource-src-%version%.tar.bz2'
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    'ftp://ftp.trolltech.com/qt/source/qt-x11-opensource-src-%version%.tar.bz2'
  )
}
