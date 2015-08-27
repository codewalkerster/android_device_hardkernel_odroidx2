#!/bin/sh
SYSFS_GPIO_DIR="/sys/class/gpio"

retval=""

gpio_export()
{
	[ -e "$SYSFS_GPIO_DIR/gpio$1" ] && return 0
	echo $1 > "$SYSFS_GPIO_DIR/export"
	echo $1
}

gpio_getvalue()
{
	echo in > "$SYSFS_GPIO_DIR/gpio$1/direction"
	val=`cat "$SYSFS_GPIO_DIR/gpio$1/value"`
	retval=$val
}

gpio_setvalue()
{
	echo out > "$SYSFS_GPIO_DIR/gpio$1/direction"
	echo $2 > "$SYSFS_GPIO_DIR/gpio$1/value"
}

AC_OK_GPIO=199
BAT_OK_GPIO=200
LATCH_GPIO=204

gpio_export $LATCH_GPIO
gpio_setvalue $LATCH_GPIO 1

check()
{
	gpio_export $AC_OK_GPIO
	gpio_export $BAT_OK_GPIO
	gpio_getvalue $AC_OK_GPIO

	if [ $retval -eq  1 ]
	then
		echo "DC Input Okay"
	else
		echo "Power is shutdown or AC Adaptor is disconnected"
		gpio_getvalue $BAT_OK_GPIO
		echo $retval
		if [ $retval -eq 0 ]
		then
				echo "battery is low than 3.7V"
				poweroff -d 5
		else
				echo "battery is good"
		fi
	fi
}

while true
do check
sleep 30
done
