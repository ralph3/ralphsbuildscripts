#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.97"

DIR="grub-${VERSION}"
TARBALL="grub-${VERSION}.tar.gz"

DEPENDS=(
  ncurses
)

SRC1=(
ftp://alpha.gnu.org/gnu/grub/${TARBALL}
)

MD5SUMS=(
cd3f3eb54446be6003156158d51f4884
)

build(){
  echo "Don't install grub!"
  return 1
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CFLAGS="$CFLAGS -O2"
  CXXFLAGS="$CFLAGS"
  export CFLAGS CXXFLAGS
  ./configure --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  
  mkdir -p $TMPROOT/boot/grub
cat > $TMPROOT/boot/grub/menu.lst.tmpnew << "EOF"
default 0
timeout 15
color green/black light-green/black

title Linux
root (hd0,x)
kernel --no-mem-option /boot/vmlinuz root=/dev/hdax

title Windows
rootnoverify (hd0,0)
chainloader +1
EOF

  for file in $TMPROOT/usr/lib/grub/*/*; do
    mv $file $TMPROOT/boot/grub/
    ln -sfn /boot/grub/$(basename $file) $file
  done
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://alpha.gnu.org/gnu/grub/'
  VERSION_STRING='grub-%version%.tar.gz'
  MINOR_VERSION=0
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    'ftp://alpha.gnu.org/gnu/grub/grub-%version%.tar.gz'
  )
}
