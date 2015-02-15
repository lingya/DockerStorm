#!/bin/bash


master=${master}

if [ $master == "true" ]
then
	mv /etc/supervisor/conf.d/storm-master.tmp /etc/supervisor/conf.d/storm-master.conf
else
	mv /etc/supervisor/conf.d/storm-worker.tmp /etc/supervisor/conf.d/storm-worker.conf
fi

/usr/bin/supervisord >> /dev/null
