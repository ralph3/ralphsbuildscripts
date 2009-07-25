#!/bin/bash

DISABLE_MULTILIB=1
DISABLE_STRIP=1

VERSION="3.0.2-49928"
SYS_VERSION="3.0.2-49928-1"

TARBALL="VirtualBox-${VERSION}-Linux_amd64.run"
DIR="VirtualBox-${VERSION}"

DEPENDS=(
  sdl
  xorg-server
)

SRC1=(
http://download.virtualbox.org/virtualbox/$(echo ${VERSION} | cut -f1 -d'-')/$TARBALL
)

MD5SUMS=(
caf90bd1dc0e0ea4185e54badce2bede
)

build(){
  check_my_arch(){
    case $($CC -dumpmachine | cut -f1 -d'-') in
      x86_64)
        return 0
      ;;
    esac
    echo "I can only be installed on x86_64!"
    return 1
  }
  check_my_arch || return 1
  local INST
  mkdir -p $SRCDIR/$DIR || return 1
  
  sh $DOWNLOADDIR/$TARBALL --noexec --target $SRCDIR/$DIR || return 1
  
  INST=$TMPROOT/usr/$LIBSDIR/$DIR/
  mkdir -vp $TMPROOT/usr/{bin,share/{applications,pixmaps},src} \
    $INST || return 1
  
  tar xvfj $SRCDIR/$DIR/VirtualBox.tar.bz2 -C $INST || return 1
  
  chown -R root:root $INST || return 1
  
  cd $INST/components || return 1
  
  for x in ../*.so*; do
    ln -vsfn $x . || return 1
  done
  
  chmod u+s $INST/VirtualBox || return 1
  
  mv -v $INST/src $TMPROOT/usr/src/$DIR || return 1
  
  sed -i "s%/lib/modules%/${LIBSDIR}/modules%g" $(grep -rl "/lib/modules" $TMPROOT/usr/src/$DIR) || return 1
  
  mv -v $INST/VirtualBox.desktop $TMPROOT/usr/share/applications/ || return 1
  sed -i -e 's%Sun VirtualBox%Virtual Machine Manager%' -e '/\.pdf$/d' \
    $TMPROOT/usr/share/applications/VirtualBox.desktop || return 1
  
  mv -v $INST/VBox.png $TMPROOT/usr/share/pixmaps/ || return 1
  
  for x in VirtualBox VBoxManage VBoxSDL VBoxHeadless vboxwebsrv; do
    ln -sfnv ../$LIBSDIR/$DIR/$x $TMPROOT/usr/bin/$x || return 1
    ln -sfnv ../$LIBSDIR/$DIR/$x $TMPROOT/usr/bin/$(echo $x | tr [A-Z] [a-z]) || return 1
  done
  
  mkdir -vp $TMPROOT/etc/udev/rules.d || return 1
cat << "EOF" > $TMPROOT/etc/udev/rules.d/10-vboxdrv.rules || return 1
KERNEL=="vboxdrv", NAME="vboxdrv", OWNER="root", GROUP="vboxusers", MODE="0660"
SUBSYSTEM=="usb_device", GROUP="vboxusers", MODE="0664"
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", GROUP="vboxusers", MODE="0664"
EOF
  groupadd vboxusers
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}
