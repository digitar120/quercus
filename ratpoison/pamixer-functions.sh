#!/bin/bash
# Script de ayuda de pamixer / Pamixer helper script
#
# Un script que abstrae algunas funciones de pamixer, un frontend CLI para pulseaudio (un servidor de sonido)
#
# A script that abstracts some pamixer functions. Pamixer is a CLI frontend for pulseaudio (a sound server)

. variables.sh

# Estas variables se definen manualmente
DEFAULT_SINK="53"
DEFAULT_MIC="54"


SinkStatus(){
	pamixer --sink $DEFAULT_SINK --get-mute --get-volume 
	# Responde false/true y un número
}

MicStatus(){
	pamixer --source $DEFAULT_MIC --get-mute --get-volume
}

MuteSink(){
	pamixer --sink $DEFAULT_SINK --toggle-mute
}

MuteMic(){
	pamixer --source $DEFAULT_MIC --toggle-mute
}

Configure(){
	echo "TODO"
}

