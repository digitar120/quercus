#!/bin/bash

. ../configuraciones/variables.sh
BR_DIR=$DIRECTORIO_BRILLO/brightness
BR=$(cat $DIRECTORIO_BRILLO/brightness)
BRM=$(cat $DIRECTORIO_BRILLO/max_brightness)
	
	
if [ $1 == "get" ]; then
	if [ $2 == "current" ]; then
		awk -v br=$BR -v brm=$BRM 'BEGIN {print int((br/brm)*100)}'
	fi
	
elif [ $1 == "set" ]; then
	awk -v set=$2 -v brm=$BRM 'BEGIN {print int(set*(brm/100))-1}' > $BR_DIR
elif [ $1 == "add" ]; then
	echo $BR | awk -v val=$2 '{print $1 + val}' > $BR_DIR
fi


