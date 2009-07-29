#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.1"
SYS_VERSION="1.3.1-3"

DIR="synergy-${VERSION}"
TARBALL="synergy-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/synergy2/${TARBALL}
)

MD5SUMS=(
a6e09d6b71cb217f23069980060abf27
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch synergy-1.3.1-gcc43.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  
cat << "EOF" > $TMPROOT/usr/bin/synergy-server || return 1
#!/bin/bash

synergys --config /etc/synergy.conf --daemon --restart
EOF
  chmod 755 $TMPROOT/usr/bin/synergy-server || return 1
  
  mkdir -p $TMPROOT/etc || return 1
cat << "EOF" > $TMPROOT/etc/synergy.conf.new || return 1
section: screens
SERVERHOSTNAME:
CLIENTHOSTNAME:
end

section: links
SERVERHOSTNAME:
right = CLIENTHOSTNAME
CLIENTHOSTNAME:
left = SERVERHOSTNAME
end

section: options
screenSaverSync = false
keystroke(f12) = lockCursorToScreen(toggle)
end
EOF
  
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=59275&package_id=58007'
  VERSION_STRING='synergy-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/synergy2/synergy-%version%.tar.gz"
  )
}
