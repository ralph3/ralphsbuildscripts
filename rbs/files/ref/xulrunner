#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.9.0.6"

DIR="xulrunner-${VERSION}"
TARBALL="xulrunner-${VERSION}-source.tar.bz2"

DEPENDS=(
  libidl
)

SRC1=(
http://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/$VERSION/source/${TARBALL}
)

MD5SUMS=(
1b6063d29fe9785b929a36f249866360
)

build(){
  local OSTEST
  unset CFLAGS CXXFLAGS
  OSTEST=$(gcc -dumpmachine | cut -f1 -d'-')
  unpack_tarball $TARBALL || return 1
  mkdir -p $SRCDIR/$DIR
  mv -f $SRCDIR/mozilla $SRCDIR/$DIR/ || return 1
  cd $SRCDIR/$DIR/mozilla || return 1

cat > .mozconfig << "EOF"
. $topsrcdir/xulrunner/config/mozconfig
mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-@CONFIG_GUESS@

ac_cv_visibility_pragma=no

ac_add_options --prefix=/usr

ac_add_options --with-system-nss
ac_add_options --with-system-nspr

ac_add_options --with-system-zlib
ac_add_options --with-system-jpeg
ac_add_options --enable-system-cairo

ac_add_options --enable-canvas
ac_add_options --enable-svg

ac_add_options --enable-strip
ac_add_options --disable-tests 
ac_add_options --disable-accessibility
ac_add_options --disable-installer
ac_add_options --enable-xinerama

ac_add_options --enable-single-profile
ac_add_options --disable-profilesharing

ac_add_options --disable-gnomevfs
ac_add_options --disable-gnomeui

ac_add_options --disable-javaxpcom
EOF

cat >> .mozconfig << EOF
ac_add_options --with-default-mozilla-five-home=/usr/${LIBSDIR}/xulrunner
export CC="gcc ${BUILD}"
export CXX="g++ ${BUILD}"
ac_add_options --libdir=/usr/${LIBSDIR}
EOF

  if [ "$SYSTYPE" == "MULTILIB" ] && [ "$BUILD" == "$BUILD32" ]; then
cat >> .mozconfig << EOF
ac_add_options --host=$BUILDTARGET
ac_add_options --build=$BUILDTARGET
mk_add_options CONFIG_GUESS=$BUILDTARGET
EOF
    OSTEST=$(echo $BUILDTARGET | cut -f1 -d'-')
  fi
  
  sed -i "s:@MOZ_GTK2_LIBS@:& -L/usr/${LIBSDIR} -lX11 -lXrender:g" \
    config/autoconf.mk.in || return 1
  make -f client.mk OS_TEST=$OSTEST build || return 1
  make -f client.mk OS_TEST=$OSTEST install DESTDIR=$TMPROOT || return 1
  
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/%version%/source/'
  VERSION_STRING='xulrunner-%version%-source.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'ftp://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/%version%/source/xulrunner-%version%-source.tar.bz2'
    'http://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/%version%/source/xulrunner-%version%-source.tar.bz2'
  )
}
