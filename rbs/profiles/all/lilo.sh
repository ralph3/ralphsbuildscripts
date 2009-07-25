#!/bin/bash

DISABLE_MULTILIB=1

VERSION="22.8"

DIR="lilo-${VERSION}"
TARBALL="lilo-${VERSION}.src.tar.gz"

DEPENDS=(
  bin86
)

SRC1=(
http://www.ibiblio.org/pub/Linux/system/boot/lilo/${TARBALL}
)

MD5SUMS=(
72765f2aafd20e23ecf07ebd22baeec7
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make install ROOT=$TMPROOT || return 1
  mkdir -p $TMPROOT/etc || return 1
cat << "EOF" > $TMPROOT/etc/lilo.conf.new || return 1
boot = /dev/hda
map = /boot/.map
lba32
install = menu		# syntax since version 22.3 (see the man pages)
menu-scheme=wm:rw:wm:Wm
menu-title=" RBS LINUX "
prompt
timeout=150
delay=30

read-only

image=/boot/vmlinuz
	label=LINUX
	root=/dev/hda5
	append=""

# windows example
#other=/dev/hda1
#	label=win_2k
#	table=/dev/hda
EOF
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.ibiblio.org/pub/Linux/system/boot/lilo/'
  VERSION_STRING='lilo-%version%.src.tar.gz'
  MIRRORS=(
    'http://www.ibiblio.org/pub/Linux/system/boot/lilo/lilo-%version%.src.tar.gz'
  )
}
