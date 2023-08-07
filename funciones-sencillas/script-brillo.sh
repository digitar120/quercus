#!/bin/bash

. ../configuraciones/variables.sh
ARCHIVO=$DIRECTORIO_BRILLO/brightness

if [ $1 == "get" ]; then
	if [ $2 == "current" ]; then
		cat $ARCHIVO
	elif [ $2 == "max" ]; then
		cat $DIRECTORIO_BRILLO/max_brightness
	fi
elif [ $1 == "set" ]; then
	echo $2 > $ARCHIVO
elif [ $1 == "add" ]; then
	awk -v val=$2 '{print $1 + val}' $ARCHIVO > $ARCHIVO
fi
