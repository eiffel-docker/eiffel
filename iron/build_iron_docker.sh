#!/bin/bash

if [[ "$1" == "" ]]; then
	docker build -f Dockerfile -t local/iron .
else
	docker build -f Dockerfile -t local/$1 .
fi
