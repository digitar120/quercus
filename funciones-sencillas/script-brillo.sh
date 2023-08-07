#!/bin/bash

. ../configuraciones/variables.sh
ARCHIVO=$DIRECTORIO_BRILLO/brightness

if [ $1 == "get" ]; then
	cat $ARCHIVO
elif [ $1 == "get_max" ]; then
	cat $DIRECTORIO_BRILLO/max_brightness
elif [ $1 == "set" ]; then
	echo $2 > $ARCHIVO
elif [ $1 == "add" ]; then
	awk -v val=$2 '{print $1 + val}' $ARCHIVO > $ARCHIVO
fi
