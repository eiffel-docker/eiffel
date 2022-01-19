#!/bin/bash

if [[ "$1" == "" ]]; then
	docker build -f Dockerfile -t local/eiffel .
else
	docker build -f Dockerfile -t $1 .
fi
