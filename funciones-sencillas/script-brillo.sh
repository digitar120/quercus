#!/bin/bash

. ../configuraciones/variables.sh
BRA_DIR=$DIRECTORIO_BRILLO/brightness
BRILLO_ACTUAL=$(cat $DIRECTORIO_BRILLO/brightness)
BRILLO_MAXIMO=$(cat $DIRECTORIO_BRILLO/max_brightness)
	# Nunca es necesario acceder a este archivo
	
	
if [ $1 == "get" ]; then
	if [ $2 == "current" ]; then
		awk -v br=$BRILLO_ACTUAL -v brm=$BRILLO_MAXIMO 'BEGIN {print int((br/brm)*100)}'
	fi
	
elif [ $1 == "set" ]; then
	awk -v set=$2 -v brm=$BRILLO_MAXIMO 'BEGIN {print int(set*(brm/100))-1}' > $BRA_DIR
elif [ $1 == "add" ]; then
	awk -v val=$2 '{print $1 + val}' $BRILLO_ACTUAL > $BRILLO_ACTUAL
fi


