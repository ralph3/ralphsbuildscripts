#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.1"

DIR="bash-${VERSION}"
TARBALL="bash-${VERSION}.tar.gz"

DEPENDS=(
  bison
  readline
)

SRC1=(
http://ftp.gnu.org/gnu/bash/${TARBALL}
)

MD5SUMS=(
9800d8724815fd84994d9be65ab5e7b8
)

CaT_BaSH_ProfileStuff(){
  mkdir -p $1/etc/{profile.d,skel} || return 1
cat << "EOF" > $1/etc/profile || return 1
#!/bin/bash

export PATH=/bin:/usr/bin:/RBS-Tools/bin
[ "$(id -u)" = "0" ] && export PATH=/sbin:/usr/sbin:$PATH
HISTSIZE=1000
HISTIGNORE="&:[bf]g:exit"

if [ "$(id -gn)" = "$(id -un)" -a $(id -u) -gt 99 ] ; then
  umask 002
else
  umask 022
fi

case "$TERM" in
  "xterm")
    TERM=xterm-new
  ;;
  *)
    TERM=linux
  ;;
esac

ls /etc/profile.d/*.sh >&/dev/null && {
  for file in /etc/profile.d/*.sh; do
    [ -x "$file" ] && . $file
  done
}

ls /etc/skel >&/dev/null && {
  if [ ! -e "$HOME/.noskel" ]; then
    find /etc/skel -maxdepth 1 | grep -vhFx /etc/skel | while read x; do
      N=$(basename $x)
      if [ ! -e "$HOME/$N" ]; then
        cp -a $x $HOME/
      fi
    done
  fi
}

PS1='[ \u@\h:\w ]$ '
alias dir='ls --color=auto -F -b -T 0'
alias ls='ls --color=auto -F -b -T 0'
export PATH HISTSIZE HISTIGNORE TERM PS1
EOF

cat << "EOF" > $1/etc/skel/.bashrc || return 1
source /etc/profile
EOF
}


RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
cat << "EOF" > config.cache || return 1
ac_cv_func_mmap_fixed_mapped=yes
ac_cv_func_strcoll_works=yes
ac_cv_func_working_mktime=yes
bash_cv_func_ctype_nonascii=yes
bash_cv_func_sigsetjmp=present
bash_cv_getcwd_malloc=yes
bash_cv_job_control_missing=present
bash_cv_printf_a_format=yes
bash_cv_sys_named_pipes=present
bash_cv_ulimit_maxfds=yes
bash_cv_under_sys_siglist=yes
bash_cv_unusable_rtsigs=no
gt_cv_int_divbyzero_sigfpe=yes
EOF
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools --bindir=/RBS-Tools/bin \
    --without-bash-malloc --cache-file=config.cache || return 1
  make || return 1
  make install || return 1
  ln -sfn bash /RBS-Tools/bin/sh || return 1
  CaT_BaSH_ProfileStuff $ROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  for x in curses ncurses history readline; do
    sed -i "s%-l${x}%${ROOT}/usr/$LIBSDIR/lib${x}.a%g" configure || return 1
  done
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --bindir=/bin --without-bash-malloc --with-installed-readline \
    --cache-file=config.cache || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  ln -sfn bash $TMPROOT/bin/sh || return 1
  CaT_BaSH_ProfileStuff $TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/bash/'
  VERSION_STRING='bash-%version%.tar.gz'
  VERSION_FILTERS='rc doc'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/bash/bash-%version%.tar.gz'
  )
}
