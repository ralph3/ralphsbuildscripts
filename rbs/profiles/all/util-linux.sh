#!/bin/bash

#2.17.x may have conflict with glibc2.10x, does fine with glibc 2.11
#downgrading glibc attempting to pinpoint addr resolution issues.

VERSION="2.16.2"

DIR="util-linux-ng-${VERSION}"
TARBALL="util-linux-ng-${VERSION}.tar.bz2"

DEPENDS=(
  ncurses
)

SRC1=(
http://www.kernel.org/pub/linux/utils/util-linux-ng/v$(echo $VERSION | cut -f-2 -d'.')/${TARBALL}
)

MD5SUMS=(
edd1f7a82fd388cc0e1e3d2d1e7ea55a
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --libdir=/RBS-Tools/$LIBSDIR --includedir=/RBS-Tools/include \
    --enable-arch --enable-login-utils --disable-makeinstall-chown || return 1
  make || return 1
  make install DESTDIR=$ROOT || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --libdir=/$LIBSDIR \
    --enable-arch --enable-login-utils --disable-makeinstall-chown || return 1
  make || return 1
  make install DESTDIR=$ROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
    hwclock/hwclock.c || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --libdir=/$LIBSDIR \
    --enable-partx --disable-wall --enable-write --enable-arch || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  find $TMPROOT -name '*.la' -exec rm {} \; || return 1
  mv $TMPROOT/usr/bin/logger $TMPROOT/bin || return 1
  mkdir -p $TMPROOT/{etc,var/lib/hwclock}
cat << "EOF" > $TMPROOT/etc/fstab.tmpnew
/dev/hdz1  swap          swap      sw                         0 0
/dev/hdz2  /boot         ext3      defaults                   0 0
/dev/hdz3  /somemount1   ext3      defaults                   1 1
/dev/hdz4  /somemount2   reiserfs  defaults                   0 0
proc       /proc         proc      defaults                   0 0
sysfs      /sys          sysfs     defaults                   0 0
devpts     /dev/pts      devpts    gid=4,mode=620             0 0
shm        /dev/shm      tmpfs     defaults                   0 0
usbfs      /proc/bus/usb usbfs     devgid=15,devmode=0666     0 0
EOF
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.kernel.org/pub/linux/utils/util-linux-ng/v%minor_version%/'
  VERSION_STRING='util-linux-ng-%version%.tar.bz2'
  VERSION_FILTERS="rc"
  MIRRORS=(
    'http://www.kernel.org/pub/linux/utils/util-linux-ng/v%minor_version%/util-linux-ng-%version%.tar.bz2'
  )
}
