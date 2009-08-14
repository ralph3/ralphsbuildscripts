#!/bin/bash

DISABLE_MULTILIB=1

VERSION="146"

DIR="udev-${VERSION}"
TARBALL="udev-${VERSION}.tar.bz2"

DEPENDS=(
  libxslt
)

SRC1=(
http://www.kernel.org/pub/linux/utils/kernel/hotplug/${TARBALL}
)

MD5SUMS=(
b2a8acefda4fa8a70d45642035abd718
)

MyBuild(){
  local MYDEST
  
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  MYDEST=$1
  
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --exec-prefix= \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR --libexecdir=/$LIBSDIR/udev \
    --disable-extras || return 1
  make || return 1
  make install DESTDIR=$MYDEST || return 1
  
  install -dv $MYDEST/etc/udev/devices/{pts,shm} || return 1
  mknod -m0666 $MYDEST/etc/udev/devices/null c 1 3
  ln -sfnv /proc/self/fd $MYDEST/etc/udev/devices/fd || return 1
  ln -sfnv /proc/self/fd/0 $MYDEST/etc/udev/devices/stdin || return 1
  ln -sfnv /proc/self/fd/1 $MYDEST/etc/udev/devices/stdout || return 1
  ln -sfnv /proc/self/fd/2 $MYDEST/etc/udev/devices/stderr || return 1
  ln -sfnv /proc/kcore $MYDEST/etc/udev/devices/core || return 1
  
  install -v -m644 -D docs/writing_udev_rules/index.html \
    $MYDEST/usr/share/doc/udev-${VERSION}/index.html || return 1
  
  rm -rf $MYDEST/etc/udev/rules.d || return 1
  mkdir -p $MYDEST/etc/udev/rules.d || return 1
cat > $MYDEST/etc/udev/rules.d/25-rbs.rules << "EOF" || return 1
# hotplug
ENV{MODALIAS}=="?*",  RUN+="/sbin/modprobe $env{MODALIAS}"

# scsi
SUBSYSTEM=="scsi_device",  ACTION=="add", ATTRS{type}=="0|7|14", RUN+="/sbin/modprobe sd_mod"
SUBSYSTEM=="scsi_device",  ACTION=="add", ATTRS{type}=="1", SYSFS{vendor}=="On[sS]tream", RUN+="/sbin/modprobe osst"
SUBSYSTEM=="scsi_device",  ACTION=="add", ATTRS{type}=="1", RUN+="/sbin/modprobe st"
SUBSYSTEM=="scsi_device",  ACTION=="add", ATTRS{type}=="[45]", RUN+="/sbin/modprobe sr_mod"
SUBSYSTEM=="scsi_device",  ACTION=="add", RUN+="/sbin/modprobe sg"

# Core kernel devices

KERNEL=="ptmx",     MODE="0666",    GROUP="tty"
KERNEL=="random",   MODE="0444"
KERNEL=="urandom",  MODE="0444"
KERNEL=="kmem",     MODE="0640",    GROUP="kmem"
KERNEL=="mem",      MODE="0640",    GROUP="kmem"
KERNEL=="port",     MODE="0640",    GROUP="kmem"
KERNEL=="null",     MODE="0666"
KERNEL=="zero",     MODE="0666"
KERNEL=="full",     MODE="0666"
KERNEL=="aio",      MODE="0444"
KERNEL=="kmsg",     MODE="0600"
KERNEL=="rtc",      MODE="0666"

# Comms devices

KERNEL=="ttyS[0-9]*",                   GROUP="dialout"
KERNEL=="ttyUSB[0-9]*",                 GROUP="dialout"
KERNEL=="rfcomm[0-9]*",                 GROUP="dialout"
KERNEL=="tty[BCDEFHILMPRSTUVWX][0-9]*", GROUP="dialout"
KERNEL=="ttyS[ACIR][0-9]*",             GROUP="dialout"
KERNEL=="ttyUSB[0-9]*",                 GROUP="dialout"
KERNEL=="ttyACM[0-9]*",                 GROUP="dialout"
KERNEL=="ippp[0-9]*",                   GROUP="dialout"
KERNEL=="isdn[0-9]*",                   GROUP="dialout"
KERNEL=="isdnctrl[0-9]*",               GROUP="dialout"
KERNEL=="capi",                         NAME="capi20",  SYMLINK+="isdn/capi20"
KERNEL=="capi?*",                       NAME="capi/%n", GROUP="dialout"
KERNEL=="dcbri[0-9]*",                  GROUP="dialout"
KERNEL=="ircomm[0-9]*",                 GROUP="dialout"

# TTY's

KERNEL=="tty",          MODE="0666",    GROUP="tty"
KERNEL=="tty[0-9]*",    MODE="0666",    GROUP="tty"
KERNEL=="vcs*",         MODE="0600"
KERNEL=="console",      MODE="0622",    GROUP="tty"

# Alsa devices
KERNEL=="controlC[0-9]*",  GROUP="audio",  NAME="snd/%k", MODE="0666"
KERNEL=="hw[CD0-9]*",      GROUP="audio",  NAME="snd/%k"
KERNEL=="pcm[CD0-9cp]*",   GROUP="audio",  NAME="snd/%k", MODE="0666"
KERNEL=="midiC[D0-9]*",    GROUP="audio",  NAME="snd/%k", MODE="0666"
KERNEL=="timer",           GROUP="audio",  NAME="snd/%k", MODE="0666"
KERNEL=="seq",             GROUP="audio",  NAME="snd/%k", MODE="0666"

# sound devices
KERNEL=="admmidi*",       GROUP="audio",                 MODE="0666"
KERNEL=="adsp*",          GROUP="audio",                 MODE="0666"
KERNEL=="aload*",         GROUP="audio",                 MODE="0666"
KERNEL=="amidi*",         GROUP="audio",                 MODE="0666"
KERNEL=="amixer*",        GROUP="audio",                 MODE="0666"
KERNEL=="audio*",         GROUP="audio",                 MODE="0666"
KERNEL=="dmfm*",          GROUP="audio",                 MODE="0666"
KERNEL=="dmmidi*",        GROUP="audio",                 MODE="0666"
KERNEL=="dsp*",           GROUP="audio",                 MODE="0666"
KERNEL=="midi*",          GROUP="audio",                 MODE="0666"
KERNEL=="mixer*",         GROUP="audio",                 MODE="0666"
KERNEL=="music",          GROUP="audio",                 MODE="0666"
KERNEL=="sequencer*",     GROUP="audio",                 MODE="0666"

# Printing devices

KERNEL=="lp[0-9]*",         GROUP="lp"
KERNEL=="parport[0-9]*",    GROUP="lp"
KERNEL=="irlpt[0-9]*",      GROUP="lp"

# Input devices go in their own subdirectory

KERNEL=="mice",     MODE="0644",    NAME="input/%k",  SYMLINK+="mouse"
KERNEL=="mouse*",   MODE="0644",    NAME="input/%k"
KERNEL=="event*",   MODE="0644",    NAME="input/%k"
KERNEL=="js*",      MODE="0644",    NAME="input/%k"
KERNEL=="ts*",      MODE="0644",    NAME="input/%k"

KERNEL=="psaux",    MODE="0644"
KERNEL=="js",       MODE="0644"
KERNEL=="djs",      MODE="0644"

# USB devices go in their own subdirectory

#SUBSYSTEM=="usb_device", PROGRAM="/bin/sh -c 'X=%k; X=$${X#usbdev}; B=$${X%%%%.*} D=$${X#*.}; echo bus/usb/$$B/$$D'", NAME="%c", MODE=0666

KERNEL=="hiddev*",          NAME="usb/%k", MODE=0666
KERNEL=="auer*",            NAME="usb/%k", MODE=0666
KERNEL=="legousbtower*",    NAME="usb/%k", MODE=0666
KERNEL=="dabusb*",          NAME="usb/%k", MODE=0666
SUBSYSTEMS=="usb", KERNEL=="lp[0-9]*", GROUP="lp", NAME="usb/%k", MODE=0666

# DRI devices are managed by the X server, so prevent udev from creating them

KERNEL=="card*",    OPTIONS+="ignore_device"

# Video devices

KERNEL=="fb[0-9]*",     MODE="0620",    GROUP="video"
KERNEL=="agpgart",      GROUP="video"
KERNEL=="video[0-9]*",  GROUP="video"
KERNEL=="radio[0-9]*",  GROUP="video"
KERNEL=="vbi[0-9]*",    GROUP="video"
KERNEL=="vtx[0-9]*",    GROUP="video"
KERNEL=="nvidia*",       GROUP="video", MODE="0666"

# Storage/memory devices

KERNEL=="fd[0-9]*",             GROUP="floppy"
KERNEL=="ram[0-9]*",            GROUP="disk"
KERNEL=="raw[0-9]*",            GROUP="disk",   NAME="raw/%k"
KERNEL=="hd*",                  GROUP="disk"
KERNEL=="sd[a-z]",              GROUP="disk"
KERNEL=="sd[a-z][0-9]*",        GROUP="disk"
KERNEL=="sd[a-i][a-z]",         GROUP="disk"
KERNEL=="sd[a-i][a-z][0-9]*",   GROUP="disk"
KERNEL=="dasd[0-9]*",           GROUP="disk"
KERNEL=="loop[0-9]*",           GROUP="disk"
KERNEL=="md[0-9]*",             GROUP="disk"

# dmsetup and lvm2 related programs create devicemapper devices so we prevent
# udev from creating them

KERNEL=="dm-*",             OPTIONS+="ignore_device"
KERNEL=="device-mapper",    OPTIONS+="ignore_device"

KERNEL=="ht[0-9]*",     GROUP="tape"
KERNEL=="nht[0-9]*",    GROUP="tape"
KERNEL=="pt[0-9]*",     GROUP="tape"
KERNEL=="npt[0-9]*",    GROUP="tape"
KERNEL=="st[0-9]*",     GROUP="tape"
KERNEL=="nst[0-9]*",    GROUP="tape"

# Network devices

KERNEL=="tun",  NAME="net/%k"
EOF

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
  cp -ar /etc/udev/devices/* /dev || ret=1
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
