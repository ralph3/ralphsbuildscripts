#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.7-20090601"
SYS_VERSION="0.1.7-20090601-2"

DIR="epdfview-${VERSION}"
TARBALL="epdfview-${VERSION}.tar.xz"

DEPENDS=(
  desktop-file-utils
  gtk+
  poppler
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    svn://svn.emma-soft.com/epdfview/trunk $DIR || return 1
}

#SRC1=(
#  http://trac.emma-soft.com/epdfview/chrome/site/releases/${TARBALL}
#)
#
#MD5SUMS=(
#cce9edb41b4a8308e0ef0eea24b5a1ab
#)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ./autogen.sh || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  sed -i -e 's%ePDFViewer%PDF Viewer%' \
    -e 's%Viewer\;Office\;GTK%Application\;Utility%' \
    -e 's%icon_epdfview-48%epdfview%' \
    $TMPROOT/usr/share/applications/epdfview.desktop || return 1
  mkdir -p $TMPROOT/usr/share/pixmaps || return 1
  cp $TMPROOT/usr/share/epdfview/pixmaps/icon_epdfview-48.png \
    $TMPROOT/usr/share/pixmaps/epdfview.png || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script epdfview install || return 1
}

pre_remove(){
  gnome_script epdfview remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://trac.emma-soft.com/epdfview/wiki/Download'
  VERSION_STRING='epdfview-%version%.tar.bz2'
  MIRRORS=(
    'http://trac.emma-soft.com/epdfview/chrome/site/releases/epdfview-%version%.tar.bz2'
  )
}
