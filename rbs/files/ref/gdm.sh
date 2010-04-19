#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.1"

DIR="gdm-${VERSION}"
TARBALL="gdm-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-panel
  intltool
  librsvg
)

SRC1=(
  $(gnome_mirrors gdm)
)

MD5SUMS=(
31139d7a79096463b127b4790058b056
)

build(){
  unpack_tarball $TARBALL
  cd $SRCDIR/$DIR || return 1
  groupadd gdm
  useradd -c "GDM Daemon Owner" -d /dev/null -g gdm -s /bin/bash gdm
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gdm \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib \
    --with-pam-prefix=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  install -v -m755 -d $TMPROOT/var/log/gdm || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper \
    $TMPROOT/etc/gnome/pam.d || return 1
  mv $TMPROOT/etc/gnome/gdm/custom.conf \
    $TMPROOT/etc/gnome/gdm/custom.conf.tmpnew || return 1
  sed -i -e 's%^Exec=%&dbus-launch --exit-with-session %' \
    -e 's%^TryExec=gnome-session$%TryExec=/usr/bin/dbus-launch%' \
    $TMPROOT/usr/share/xsessions/gnome.desktop
  mkdir -p $TMPROOT/etc/pam.d || return 1
cat << "EOF" > $TMPROOT/etc/pam.d/gdm.tmpnew || return 1
auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok
EOF

cat << "EOF" > $TMPROOT/etc/pam.d/gdm-autologin.tmpnew || return 1
auth           requisite   pam_nologin.so
auth           required    pam_env.so
auth           required    pam_permit.so
account        required    pam_unix.so
session        required    pam_limits.so
session        required    pam_unix.so
password       required    pam_unix.so     nullok
EOF

  mkdir -p $TMPROOT/etc/rc.d || return 1
cat << "EOF" >$TMPROOT/etc/rc.d/rc.gdm
#!/bin/bash

. /etc/rc.d/rc.functions
. /etc/rc.d/rc.conf

case "$1" in
  start)
    print_msg "Starting Gnome Display Manager"
    loadproc gdm
  ;;
  stop)
  ;;
  restart)
    $0 stop
    sleep 1
    $0 start
  ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    return 1
  ;;
esac
EOF
  chmod 744 $TMPROOT/etc/rc.d/rc.gdm || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gdm install || return 1
}

pre_remove(){
  userdel gdm
  gnome_script gdm remove || return 1
}

pre_upgrade(){
  gnome_script gdm remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gdm/%minor_version%/'
  VERSION_STRING='gdm-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gdm/%minor_version%/gdm-%version%.tar.bz2'
  )
}
