#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.0.4"

DEPENDS=(
  bash
  inetutils
  iproute
  kbd
  net-tools
  sysklogd
  sysvinit
  udev
  util-linux
)

MyBuild(){
  MYDEST=$1
  
  mkdir -p $MYDEST/etc/rc.d || return 1
  
cat << "EOF" > $MYDEST/etc/inittab
id:3:initdefault:

si::sysinit:/etc/rc.d/rc sys

l0:0:wait:/etc/rc.d/rc 0
l1:S1:wait:/etc/rc.d/rc 1
l2:2:wait:/etc/rc.d/rc 2
l3:3:wait:/etc/rc.d/rc 3
l4:4:wait:/etc/rc.d/rc 4
l5:5:wait:/etc/rc.d/rc 5
l6:6:wait:/etc/rc.d/rc 6

ca::ctrlaltdel:/sbin/shutdown -t1 -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty -I '\033(K' tty1 9600
2:2345:respawn:/sbin/agetty -I '\033(K' tty2 9600
3:2345:respawn:/sbin/agetty -I '\033(K' tty3 9600
4:2345:respawn:/sbin/agetty -I '\033(K' tty4 9600
5:2345:respawn:/sbin/agetty -I '\033(K' tty5 9600
6:2345:respawn:/sbin/agetty -I '\033(K' tty6 9600
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc
#!/bin/bash

. /etc/rc.d/rc.functions
. /etc/rc.d/rc.conf

services(){
  local S SS
  if [ "$SYSTEMBOOT" = "1" ]; then
    if [ -z "$SYSTEM_INIT" ]; then
      S=( mountkernfs udev swap checkfs mountfs cleanfs modules clock loadkeys localnet sysklogd )
    else
      S=( ${SYSTEM_INIT[@]} )
    fi
  else
    S=( ${SERVICES[@]} )
  fi
  [ ! -z "$S" ] && {
    case $1 in
      start)
        for svc in ${S[@]}; do
          if [ -f "/etc/rc.d/rc.${svc}" ]; then
            chmod 744 /etc/rc.d/rc.${svc} >&/dev/null
            /etc/rc.d/rc.${svc} $1
          else
            print_msg "ERROR: \"$svc\" doesn't exist!"
            print_msg_failed
          fi
        done
      ;;
      stop)
        local x S
        x=0
        for svc in ${S[@]}; do x=$(($x+1)); done
        x=$(($x-1))
        while [ "$(($x+1))" != "0" ]; do
          SS="/etc/rc.d/rc.${S[x]}"
          if [ -f "$SS" ]; then
            chmod 744 $SS >&/dev/null
            $SS $1
          else
            print_msg "ERROR: \"${S[x]}\" doesn't exist!"
            print_msg_failed
          fi
          x=$(($x-1))
        done
      ;;
    esac
  }
}

case $1 in
  sys)
    SYSTEMBOOT=1
    services start
    [ -f "/etc/random-seed" ] && {
      print_msg "Initializing random number generator"
      cat /etc/random-seed >/dev/urandom
      evaluate_retval
      rm -f /etc/random-seed
    }
  ;;
  2|3|4|5)
    SYSTEMBOOT=0
    services start
  ;;
  1)
    print_msg "Unmounting remote filesystems"
    loadproc umount -a -tnfs
    
    network_devices down

    print_msg "Sending all processes the TERM signal"
    loadproc killall5 -15
    sleep 1

    print_msg "Sending all processes the KILL signal"
    loadproc killall5 -9
  ;;
  0|6)
    SYSTEMBOOT=0
    services stop
    SYSTEMBOOT=1
    services stop
    case $1 in
      0)
        /etc/rc.d/rc.halt halt
      ;;
      6)
        /etc/rc.d/rc.halt reboot
      ;;
    esac
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.functions
#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/tools/bin:/tools/sbin

COLS=$(stty size | cut -f2 -d' ')
C_TEXT="\033[1;37m"
C_TB="\033[1;33m"
C_B="\033[1;37m"
C_CLEAR="\033[1;0m"
C_BUSY="\033[0;36m"
C_FAIL="\033[1;31m"
C_DONE="\033[1;32m"
C_NR="\033[1;33m"

print_msg(){
  echo -ne " ${C_TB}::${C_CLEAR} ${C_TEXT}$@${C_CLEAR} ${C_TB}::${C_CLEAR}"
  echo -ne " \033[$(($COLS-9))G${C_B}[${C_CLEAR} ${C_BUSY}WAIT${C_CLEAR} ${C_B}]${C_CLEAR}  "
}

print_msg_failed(){
  echo -e "\033[$(($COLS-10))G${C_B}[${C_CLEAR} ${C_FAIL}FAILED${C_CLEAR} ${C_B}]${C_CLEAR} "
}

print_msg_not_running(){
  echo -e "\033[$(($COLS-16))G ${C_B}[${C_CLEAR} ${C_NR}NOT RUNNING${C_CLEAR} ${C_B}]${C_CLEAR} "
}

print_msg_done(){
  echo -e "\033[$(($COLS-9))G${C_B}[${C_CLEAR} ${C_DONE}DONE${C_CLEAR} ${C_B}]${C_CLEAR}  "
}

evaluate_retval(){
  local retval=$?
  [ ! -z "$1" ] && retval=$1
  case $retval in
    0)
      print_msg_done
    ;;
    *)
      print_msg_failed
    ;;
  esac
}

killproc(){
  local PID="$(pidof $1 2>/dev/null)"
  local failed=0
  [ -z "$PID" ] && {
    print_msg_not_running
    return
  }
  for pid in $PID; do
    [ "$pid" -ne "$$" ] && {
      kill -KILL $pid >&/dev/null || failed=1
    }
  done
  evaluate_retval $failed
}

loadproc(){
  OUTPUT=$("$@" 2>&1)
  evaluate_retval
  [ ! -z "$OUTPUT" ] && {
    echo
    echo $OUTPUT
    echo
  }
}
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.conf.tmpnew
HOSTNAME=LINUX-BOX
MODULES=()
SERVICES=()

SYSTEM_INIT=(
  mountkernfs
  udev
  swap
  checkfs
  mountfs
  cleanfs
  modules
  clock
  loadkeys
  localnet
  sysklogd
)
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.checkfs
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Mounting Root FS in readonly mode"
    mount -n -o remount,ro /
    [ "$?" != "0" ] && {
      print_msg_failed
      echo
      echo  "FATAL! I CAN'T MOUNT ROOT FILESYSTEM IN READ ONLY MODE!"
      echo  
      echo  "Press any key to halt..."
      echo
      read
      halt -f
    }
    print_msg_done
    print_msg "Checking Filesystems"
    fsck -a -A -T >&/dev/null
    RET=$?
    case $RET in
      0|1)
        print_msg_done
      ;;
      2|3)
        print_msg_done
        echo
        echo "I fixed some filesystem errors and need to reboot."
        echo
        echo " Rebooting in 5 seconds..."
        echo
        sleep 5
        reboot -f
      ;;
      *)
        if [ "$RET" -lt "16" ]; then
          print_msg_failed
          echo
          echo "There are fatal errors with your filesystem that I can't fix!"
          echo
          echo " Press any key to halt..."
          echo
          read
          halt -f
        else
          print_msg_failed
        fi
      ;;
    esac
  ;;
  stop) ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.cleanfs
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Cleaning Temp Directories"
    failed=0
    HERE=$PWD
    cd /tmp && find -exec rm -rf {} >&/dev/null \;
    cd $HERE
    mkdir -p /tmp/.ICE-unix
    chmod -R 1777 /tmp
    cd /var/lock &&
    find . -type f ! -newer /proc -exec rm -f {} \; || failed=1
    cd /var/run &&
    find . ! -type d ! -name utmp ! -newer /proc \
      -exec rm -f {} \; || failed=1
    > /var/run/utmp
    if grep -q '^utmp:' /etc/group ; then
      chmod 664 /var/run/utmp
      chgrp utmp /var/run/utmp
    fi
    evaluate_retval $failed
  ;;
  stop) ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.clock
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Reading Hardware Clock"
    loadproc hwclock --hctosys
  ;;
  stop)
    print_msg "Setting Hardware Clock"
    loadproc hwclock --systohc
  ;;
  *)
    echo "Usage: {start|stop}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.halt
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

halt_1(){
  print_msg "Sending all processes the TERM signal"
  loadproc killall5 -15
  print_msg "Sending all processes the KILL signal"
  loadproc killall5 -9
  print_msg "Deactivating swap partitions"
  loadproc swapoff -a
  print_msg "Saving random seed to a temporary file"
  dd if=/dev/urandom of=/etc/random-seed count=1 bs=512 2>/dev/null
  evaluate_retval
  print_msg "Unmounting remote filesystems"
  loadproc umount -a -f -tnfs
}

halt_2(){
  print_msg "Remounting root filesystem read-only"
  mount -n -o remount,ro / >&/dev/null
  evaluate_retval
  print_msg "Flushing filesystem buffers"
  loadproc sync
  print_msg "Unmounting local filesystems"
  umount -a -tnonfs >&/dev/null
  evaluate_retval
}

case $1 in
  halt)
    halt_1
    /sbin/halt -w
    halt_2
    print_msg "Shutting Down"
    halt -d -f -p
  ;;
  reboot)
    halt_1
    /sbin/reboot -w
    halt_2
    print_msg "Rebooting"
    reboot -d -f -i
  ;;
esac
EOF
    
cat << "EOF" > $MYDEST/etc/rc.d/rc.localnet
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Bringing up LoopBack Interface"
    loadproc ifconfig lo 127.0.0.1
    print_msg "Setting Hostname to $HOSTNAME"
    loadproc hostname $HOSTNAME
  ;;
  stop)
    print_msg "Bringing down LoopBack Interface"
    loadproc ifconfig lo down
  ;;
  *)
    echo "Usage: {start|stop}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.modules
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Running depmod -a"
    loadproc depmod -a
    for mod in ${MODULES[*]}; do
      print_msg "Probing Module \"$mod\""
      loadproc modprobe $mod
    done
  ;;
  stop) ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.mountfs
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Re-Mounting Root FS in read-write mode"
    loadproc mount -n -o remount,rw /
    print_msg "Recording existing mounts in /etc/mtab"
    failed=0
    > /etc/mtab
    mount -f / || failed=1
    mount -f /proc || failed=1
    if grep -q '[[:space:]]sysfs' /proc/mounts ; then
      mount -f /sys || failed=1
    fi
    evaluate_retval $failed
    print_msg "Mounting remaining file systems"
    mount -a -O no_netdev >&/dev/null
    evaluate_retval
  ;;
  stop) ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.mountkernfs
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Mounting kernel filesystems"
    ret=0
    [ ! -e /proc/mounts ] && {
      mount -n /proc || ret=1
    }
    echo "3 4 1 6" > /proc/sys/kernel/printk
    [ -d /sys ] && [ ! -d /sys/block ] && {
      mount -n /sys || ret=1
    }
    evaluate_retval $ret
  ;;
  stop) ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.swap
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    print_msg "Activating Swap"
    swapon -a >&/dev/null
    evaluate_retval
  ;;
  stop) ;;
  *)
    echo "Usage: {start}"
    exit 1
  ;;
esac
EOF
  
cat << "EOF" > $MYDEST/etc/rc.d/rc.etchosts
#!/bin/bash

. /etc/rc.d/rc.conf
. /etc/rc.d/rc.functions

case $1 in
  start)
    DEFAULT=`ip route | grep "^default " | rev | cut -f2 -d' ' | rev`
    if [ -z "$DEFAULT" ]; then
      IP="127.0.0.1"
    else
      IP=`ifconfig $DEFAULT | grep -o "inet addr:.*. " | cut -f2- -d':' | cut -f1 -d' ' | cut -f1 -d'/'`
    fi
    touch /etc/hosts
    HOSTS=$(cat /etc/hosts | sed "/${HOSTNAME}.localdomain $HOSTNAME/d" | sed '/127\.0\.0\.1 localhost/d')
    echo "$IP ${HOSTNAME}.localdomain $HOSTNAME" > /etc/hosts
    echo "127.0.0.1 localhost" >> /etc/hosts
    echo $HOSTS >> /etc/hosts
  ;;
esac
EOF
  
  for rc in $MYDEST/etc/rc.d/{rc,rc.*}; do
    chmod 744 $rc
  done
  chmod 644 $MYDEST/etc/rc.d/{rc.functions,rc.conf.tmpnew}
  
  return 0
}

Tools_Build(){
  MyBuild $ROOT || return 1
}

build(){
  MyBuild $TMPROOT || return 1
}
