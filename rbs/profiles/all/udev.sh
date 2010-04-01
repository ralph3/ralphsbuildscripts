#!/bin/bash

DISABLE_MULTILIB=1

VERSION="151"

DIR="udev-${VERSION}"
TARBALL="udev-${VERSION}.tar.bz2"

DEPENDS=(
  libxslt
)

SRC1=(
http://www.kernel.org/pub/linux/utils/kernel/hotplug/${TARBALL}
)

MD5SUMS=(
aeae0e6273dcbec246c3c1b9868ebed1
)

MyBuild(){
  local MYDEST
  
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  MYDEST=$1
  
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --exec-prefix= \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR --libexecdir=/$LIBSDIR/udev \
    --docdir=/usr/share/udev-${VERSION} \
    --disable-extras --disable-introspection || return 1
  make || return 1
  make install DESTDIR=$MYDEST || return 1
  
  install -dv $MYDEST/etc/udev/devices/{pts,shm} || return 1
  mknod -m0666 $MYDEST/etc/udev/devices/null c 1 3
  ln -sfnv /proc/self/fd $MYDEST/etc/udev/devices/fd || return 1
  ln -sfnv /proc/self/fd/0 $MYDEST/etc/udev/devices/stdin || return 1
  ln -sfnv /proc/self/fd/1 $MYDEST/etc/udev/devices/stdout || return 1
  ln -sfnv /proc/self/fd/2 $MYDEST/etc/udev/devices/stderr || return 1
  ln -sfnv /proc/kcore $MYDEST/etc/udev/devices/core || return 1
  
  mkdir -p $MYDEST/etc/udev/rules.d || return 1
  
  install -v -m644 rules/packages/64-*.rules \
    rules/packages/40-pilot-links.rules \
    rules/packages/40-isdn.rules \
    $MYDEST/etc/udev/rules.d/ || return 1
  
  mkdir -p $MYDEST/etc/rc.d
cat << "EOF" > $MYDEST/etc/rc.d/rc.udev || return 1
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

do_udev_crap(){
  local ret
  ret=0
  mount -n -t tmpfs tmpfs /dev -o mode=755 || ret=1
  echo > /proc/sys/kernel/hotplug || ret=1
  echo "" > /sys/kernel/uevent_helper || ret=1
  cp -a /etc/udev/devices/* /dev || ret=1
  /sbin/udevd --daemon || ret=1
  mkdir -p /dev/.udev/queue || ret=1
  /sbin/udevadm trigger || ret=1
  /sbin/udevadm settle || ret=1
  return $ret
}

case $1 in
  start)
    print_msg "Firing Up Udev"
    do_udev_crap || {
      print_msg_failed
      exit 1
    }
    print_msg_done
    exit 0
  ;;
  stop) ;;
  restart)
    print_msg "Stopping udevd"
    killproc udevd
    sleep 1
    print_msg "Restarting udevd"
    /sbin/udevd --daemon
    /sbin/udevadm trigger
    /sbin/udevadm settle
    evaluate_retval
  ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  chmod 744 $MYDEST/etc/rc.d/rc.udev || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

RBS_Tools_Build(){
  MyBuild $ROOT || return 1
}

build(){
  MyBuild $TMPROOT || return 1
}

version_check_info(){
  ADDRESS='http://www.kernel.org/pub/linux/utils/kernel/hotplug/'
  VERSION_STRING='udev-%version%.tar.bz2'
  MIRRORS=(
    'http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev-%version%.tar.bz2'
  )
}
