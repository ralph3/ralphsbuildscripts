#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.2"

DIR="screenlets"
TARBALL="screenlets-${VERSION}.tar.bz2"

DEPENDS=(
  pygtk
  dbus-python
  pyxdg
  gnome-python-desktop
)

SRC1=(
http://launchpad.net/screenlets/trunk/${VERSION}/+download/${TARBALL}
)

MD5SUMS=(
8bab8052ff5555481fdbe8a5a6310706
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  python setup.py build || return 1
  python setup.py install --root $TMPROOT || return 1
  if [ ! -e "$TMPROOT/usr/$LIBSDIR" ]; then
    mv $TMPROOT/usr/lib $TMPROOT/usr/$LIBSDIR || return 1
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

#version_check_info(){
#  ADDRESS="https://launchpad.net/screenlets"
#  VERSION_STRING="screenlets-%version%.tar.bz2"
#  MIRRORS=(
#    "http://launchpad.net/screenlets/trunk/%version%/+download/screenlets-%version%.tar.bz2"
#  )
#}
