#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.0-20061001"

DIR="XaraLX-${VERSION}"
TARBALL="XaraLX-${VERSION}.tar.bz2"

DEPENDS=(
  wxwidgets
)

my_src1(){
  svn co -r {$(echo $VERSION | cut -f2- -d'-' | sed 's%....%&-%;s%..$%-&%')} \
    svn://svn.xara.com/Trunk/XaraLX $DIR || return 1
}

build(){
  echo "I'm a buggy pile of crap."
  return 1
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ./autogen.sh || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  return 1
  mkdir -vp $TMPROOT/usr/bin || return 1
  install -vm 755 XaraLX $TMPROOT/usr/bin/ || return 1
  mkdir -vp $TMPROOT/usr/share/{applications,pixmaps} || return 1
  install -m 644 -o root -g root $FILESDIR/XaraLX.png \
    $TMPROOT/usr/share/pixmaps/ || return 1
cat << EOF > $TMPROOT/usr/share/applications/XaraLX.desktop
[Desktop Entry]
Name=XaraLX
Comment=Xara Xtreme
Exec=XaraLX
StartupNotify=true
Icon=/usr/share/pixmaps/XaraLX.png
Terminal=0
Type=Application
Categories=Application;Graphics;
EOF
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  update-desktop-database -q || return 1
}

post_upgrade(){
  post_install || return 1
}

post_remove(){
  post_install || return 1
}
