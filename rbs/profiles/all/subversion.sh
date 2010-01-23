#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.6.9"

DIR="subversion-${VERSION}"
TARBALL="subversion-${VERSION}.tar.bz2"

DEPENDS=(
  db
  httpd
  neon
  openssl
)

SRC1=(
http://subversion.tigris.org/downloads/${TARBALL}
)

SRC2=(
http://subversion.tigris.org/downloads/subversion-deps-${VERSION}.tar.bz2
)

MD5SUMS=(
9c30a47b1d48664e7afef68bb4834c53
c480173d939a5a6d0c71c717ab71e392
)

build(){
  unpack_tarball $TARBALL || return 1
  unpack_tarball subversion-deps-${VERSION}.tar.bz2 || return 1
  cd $SRCDIR/$DIR || return 1
  groupadd svn
  useradd -c "SVN Owner" -d /home/svn -m -g svn -s /bin/false svn
  CC="$CC $BUILD" CXX="$CXX $BUILD" \
    ./configure --prefix=/usr --libdir=/usr/$LIBSDIR --with-apr=/usr \
      --with-apr-util=/usr --with-neon=/usr \
      --with-apxs=/usr/sbin/apxs || return 1
  sed -i "s%-lexpat%/usr/${LIBSDIR}/libexpat.so%g" \
    $(grep -rl "\-lexpat" *) || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  
  install -v -d -m755 $TMPROOT/usr/share/doc/subversion-${VERSION} || return 1
  cp -v -R doc/* $TMPROOT/usr/share/doc/subversion-${VERSION} || return 1
  install -d -m0755 $TMPROOT/srv || return 1
  install -d -m0755 -o svn -g svn $TMPROOT/srv/svn/repositories || return 1
  mkdir -p $TMPROOT/etc/rc.d
cat << "EOF" > $TMPROOT/etc/rc.d/rc.subversion
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Starting Subversion"
    loadproc /usr/bin/svnserve -d -r /srv/svn/repositories
  ;;
  stop)
    print_msg "Stopping Subversion"
    killproc svnserve
  ;;
  restart)
    $0 stop
    sleep 1
    $0 start
  ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
  ;;
esac
EOF
  chmod 744 $TMPROOT/etc/rc.d/rc.subversion || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://subversion.tigris.org/servlets/ProjectDocumentList?folderID=260&expandFolder=74'
  VERSION_STRING='subversion-%version%.tar.bz2'
  MIRRORS=(
    'http://subversion.tigris.org/downloads/subversion-%version%.tar.bz2'
  )
}
