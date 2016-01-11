#!/bin/bash

if [[ "$OS" =~ ^Windows.* ]]; then
  tmp_docker_opts=" -e=DISPLAY "
else
  tmp_docker_opts=" -e=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix "
fi
tmp_docker_name=iron
if [[ "$1" == "" ]]; then
	docker run -d -h ${tmp_docker_name} --name my-${tmp_docker_name} -t -i $tmp_docker_opts -P local/${tmp_docker_name} 
	tmp_iron_url="http://$(docker-machine ip default):$(docker inspect my-${tmp_docker_name}  | awk -F'"' '/HostPort/ {print $4}')"
	echo OS=$OS
	if [[ "$OS" =~ ^Windows.* ]]; then
		echo "The Eiffel IRON service url is $tmp_iron_url "
		echo "Host machine is Windows"
		start $tmp_iron_url
	else
		echo "The Eiffel IRON service url is $tmp_iron_url "
	fi
else
	echo docker run --rm -h ${tmp_docker_name} --name my-${tmp_docker_name} -t -i $tmp_docker_opts -P local/${tmp_docker_name} $1
	docker run --rm -h ${tmp_docker_name} --name my-${tmp_docker_name} -t -i $tmp_docker_opts -P local/${tmp_docker_name} $1 &
fi
#echo Info $(docker ps --no-trunc | grep my-${tmp_docker_name})
