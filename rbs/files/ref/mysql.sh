#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.1.22"

DIR="mysql-${VERSION}"
TARBALL="mysql-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://mirror.mcs.anl.gov/pub/mysql/Downloads/MySQL-4.1/${TARBALL}
)

MD5SUMS=(
37b4479951fa0cf052269d27c41ca200
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CPPFLAGS="-D_GNU_SOURCE" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --sysconfdir=/etc \
    --libexecdir=/usr/sbin --localstatedir=/srv/mysql \
    --enable-thread-safe-client --enable-assembler \
    --enable-local-infile --with-named-thread-libs=-lpthread \
    --with-unix-socket-path=/var/run/mysql/mysql.sock \
    --without-debug --without-bench --without-readline --with-libwrap \
    --with-openssl || return 1
  make testdir=/usr/lib/mysql/mysql-test || return 1
  make testdir=/usr/lib/mysql/mysql-test install DESTDIR=$TMPROOT || return 1
  HERE=$PWD
  cd $TMPROOT/usr/lib || return 1
  ln -v -sf mysql/libmysqlclient{,_r}.so* . || return 1
  cd "$HERE" || return 1
  mkdir -p $TMPROOT/{etc,var/run/mysql,srv/mysql} || return 1
  cp $TMPROOT/usr/share/mysql/my-medium.cnf $TMPROOT/etc/my.cnf.new || return 1
  
  mkdir -p $TMPROOT/etc/rc.d
cat << "EOF" > $TMPROOT/etc/rc.d/rc.mysql
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case "$1" in
  start)
    print_msg "Starting MySQL Server"
    mysqld --user=mysql >&/dev/null&
    print_msg_done
  ;;
  stop)
    print_msg "Stopping MySQL Server"
    killproc mysqld
  ;;
  restart)
    $0 stop
    sleep 1
    $0 start
  ;;
  *)
    echo "Usage: {start|stop|restart}"
    exit 1
  ;;
esac
EOF
  cd ../ || return 1
  rm -rf $DIR || return 1
}

pre_install(){
  groupadd mysql
  useradd -c mysql -d /dev/null -g mysql -s /bin/false mysql
}

post_install(){
  chown -R mysql:mysql /srv/mysql /var/run/mysql
}

post_upgrade(){
  mysql_post_install
}

post_remove(){
  userdel mysql
}

version_check_info(){
  ADDRESS='ftp://mirror.mcs.anl.gov/pub/mysql/Downloads/MySQL-%minor_version%/'
  VERSION_STRING='mysql-%version%.tar.gz'
  VERSION_FILTERS='win'
  MINOR_VERSION='4.1'
  MIRRORS=(
    'ftp://mirror.mcs.anl.gov/pub/mysql/Downloads/MySQL-%minor_version%/mysql-%version%.tar.gz'
  )
}
