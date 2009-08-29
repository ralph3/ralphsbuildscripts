#!/bin/bash

VERSION="5.10.1"

DIR="perl-${VERSION}"
TARBALL="perl-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.funet.fi/pub/CPAN/src/${TARBALL}
)

MD5SUMS=(
b9b2fdb957f50ada62d73f43ee75d044
)

RBS_Tools_Build(){
  local MYBUILD MYLIBSDIR
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch perl-5.10.0-libc-1.patch perl-5.10.0-Configure_multilib-1.patch || return 1
  MYBUILD=$BUILD
  MYLIBSDIR=$LIBSDIR
  if [ "$SYSTYPE" == "MULTILIB" ]; then
    MYBUILD=$BUILD32 
    MYLIBSDIR=$LIBSDIR32
  fi
  sed -i "/libc/s@/lib@/${MYLIBSDIR}@" hints/linux.sh || return 1
  echo 'installstyle="${MYLIBSDIR}/perl5"' >> hints/linux.sh || return 1
  CC="$CC $MYBUILD" CXX="$CXX $MYBUILD" ./configure.gnu --prefix=/RBS-Tools \
    -Dstatic_ext='Data/Dumper IO Fcntl POSIX' \
    -Dlibpth="/RBS-Tools/$MYLIBSDIR" \
    -Dcc="$CC $MYBUILD" || return 1
  make perl utilities || return 1
  cp -v perl pod/pod2man /RBS-Tools/bin || return 1
  install -dv /RBS-Tools/$MYLIBSDIR/site_perl/$VERSION || return 1
  cp -Rv lib/* /RBS-Tools/$MYLIBSDIR/site_perl/$VERSION || return 1
  ln -sfnv /RBS-Tools/bin/perl /usr/bin/ || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch perl-5.10.0-libc-1.patch perl-5.10.0-Configure_multilib-1.patch || return 1
  sed -i -e "s@pldlflags=''@pldlflags=\"\$cccdlflags\"@g" \
    -e "s@static_target='static'@static_target='static_pic'@g" \
     Makefile.SH || return 1
  sed -i "/libc/s@/lib@/${LIBSDIR}@" hints/linux.sh || return 1
  echo 'installstyle="${LIBSDIR}/perl5"' >> hints/linux.sh || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure.gnu --prefix=/usr \
    -Dvendorprefix=/usr \
    -Dman1dir=/usr/share/man/man1 \
    -Dman3dir=/usr/share/man/man3 \
    -Dpager="/bin/less -isR" \
    -Dlibpth="/usr/local/$LIBSDIR /$LIBSDIR /usr/$LIBSDIR" \
    -Dcc="$CC $BUILD" \
    -Dusethreads -Duseshrplib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/perl{,${VERSION}} || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.funet.fi/pub/CPAN/src/'
  VERSION_STRING='perl-%version%.tar.gz'
  VERSION_FILTERS="RC"
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.funet.fi/pub/CPAN/src/perl-%version%.tar.gz'
  )
}
