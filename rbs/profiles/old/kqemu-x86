#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.0pre11"

DIR="kqemu-${VERSION}"
TARBALL="kqemu-${VERSION}.tar.gz"

DEPENDS=(
  qemu
)

SRC1=(
  http://bellard.org/qemu/$TARBALL
)

MD5SUMS=(
970521874ef8b1ba4598925ace5936c3
)

build(){
  unpack_tarball $TARBALL || return 1
  $RBSDIR/setup-source linux || return 1
  cd $SRCDIR/$DIR || return 1
  mv kqemu-linux.c tmpfile || return 1
  echo "#include <linux/sched.h>" > kqemu-linux.c || return 1
  cat tmpfile >> kqemu-linux.c || return 1
  rm tmpfile || return 1
  ./configure || return 1
  make || return 1
  mkdir -vp $TMPROOT/lib/modules/$(uname -r)/kernel/misc || return 1
  cp -v kqemu.ko $TMPROOT/lib/modules/$(uname -r)/kernel/misc/ || return 1
  mkdir -vp $TMPROOT/etc/udev/rules.d || return 1
cat > $TMPROOT/etc/udev/rules.d/99-kqemu.rules << "EOF" || return 1
KERNEL=="kqemu",   MODE="0666"
EOF
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  depmod -a || return 1
}

post_upgrade(){
  depmod -a || return 1
}
