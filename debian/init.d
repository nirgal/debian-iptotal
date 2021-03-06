#! /bin/sh
### BEGIN INIT INFO
# Provides:          iptotal
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/sbin/iptotald
NAME=iptotal
DESC=iptotal

test -x $DAEMON || exit 0

# Include iptotal defaults if available
if [ -f /etc/default/iptotal ] ; then
	. /etc/default/iptotal
fi

set -e

case "$1" in
  start)
	echo -n "Starting $DESC: "
	start-stop-daemon -b --start --quiet --pidfile /var/run/$NAME.pid \
		--exec $DAEMON -- $DAEMON_OPTS
	echo "$NAME."
	;;
  stop)
	echo -n "Stopping $DESC: "
	start-stop-daemon --oknodo --stop --quiet --pidfile /var/run/$NAME.pid 
	echo "$NAME."
	;;
  restart|force-reload)
	echo -n "Restarting $DESC: "
	start-stop-daemon --stop --quiet --pidfile \
		/var/run/$NAME.pid 
	sleep 1
	start-stop-daemon -b --start --quiet --pidfile \
		/var/run/$NAME.pid --exec $DAEMON -- $DAEMON_OPTS
	echo "$NAME."
	;;
  *)
	N=/etc/init.d/$NAME
	echo "Usage: $N {start|stop|restart|force-reload}" >&2
	exit 1
	;;
esac
