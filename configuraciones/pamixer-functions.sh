#!/bin/bash
. variables.sh
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

