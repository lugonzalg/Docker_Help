#!/bin/bash

if [[ "$1" = "service-down" ]]; then
	sudo service docker stop
	sudo su
	echo DOCKER_OPTS=\"--iptables=false --ip-forward=false\" >> /etc/default/docker
	service docker restart
elif [[ "$1" = "nat" ]]; then
	iptables -t nat -D POSTROUTING 1
	echo 0 > /proc/sys/net/ipv4/ip_forward
	service docker restart
#REMOVE POSTROUTING
elif [[ "$1" = "postroute" ]]; then
	iptables -t nat -D POSTROUTING 1
	echo 0 > /proc/sys/net/ipv4/ip_forward
	service docker restart
elif [[ "$1" = "no-connect" ]]; then
	docker run -it --rm ubuntu:14.04 /bin/bash
fi
