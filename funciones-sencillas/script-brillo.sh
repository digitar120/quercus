#!/bin/bash

. ../configuraciones/variables.sh
BRILLO_ACTUAL=$DIRECTORIO_BRILLO/brightness
BRILLO_MAXIMO=$DIRECTORIO_BRILLO/max_brightness

if [ $1 == "get" ]; then
	if [ $2 == "current" ]; then
		cat $BRILLO_ACTUAL
	elif [ $2 == "max" ]; then
		cat $BRILLO_MAXIMO
	fi
elif [ $1 == "set" ]; then
	echo $2 > $BRILLO_ACTUAL
elif [ $1 == "add" ]; then
	awk -v val=$2 '{print $1 + val}' $BRILLO_ACTUAL > $BRILLO_ACTUAL
fi
