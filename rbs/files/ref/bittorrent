#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.0.4"

DIR="BitTorrent-${VERSION}"
TARBALL="BitTorrent-${VERSION}.tar.gz"

DEPENDS=(
  python
)

SRC1=(
http://download.bittorrent.com/dl/${TARBALL}
)

MD5SUMS=(
7f03514dd4d684728a4e54c6ffce7d1f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" python setup.py install \
    --root $TMPROOT || return 1
  [ -e "/var/lib/packages/current/pygtk" ] && {
  mkdir -p $TMPROOT/usr/share/{applications,pixmaps}
  cp $FILESDIR/bittorrent.png $TMPROOT/usr/share/pixmaps || return 1
cat << "EOF" > $TMPROOT/usr/share/applications/bittorrent.desktop
[Desktop Entry]
Name=BitTorrent
Comment=BitTorrent
Exec=bittorrent
StartupNotify=true
Icon=/usr/share/pixmaps/bittorrent.png
Terminal=0
Type=Application
Categories=Application;Network;
EOF
cat << "EOF" > $TMPROOT/usr/share/applications/maketorrent.desktop
[Desktop Entry]
Name=BitTorrent Torrent File Creator
Comment=BitTorrent Torrent File Creator
Exec=maketorrent
StartupNotify=true
Icon=/usr/share/pixmaps/bittorrent.png
Terminal=0
Type=Application
Categories=Application;Network;
EOF
  }
  cd ../ || return 1
  rm -rf $DIR || return 1
}

if [ -e "/var/lib/packages/current/pygtk" ]; then
  post_install(){
    update-desktop-database -q || return 1
  }
  
  post_upgrade(){
    post_install || return 1
  }
fi

#version_check_info(){
#  ADDRESS='http://download.bittorrent.com/dl/'
#  VERSION_STRING='BitTorrent-%version%.tar.gz'
#  MIRRORS=(
#    'http://download.bittorrent.com/dl/BitTorrent-%version%.tar.gz'
#  )
#}

