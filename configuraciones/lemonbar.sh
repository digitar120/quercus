#!/bin/bash

source $HOME/Scripts/funciones-linux/configuraciones/variables.sh

Reloj(){
$FUNCIONES time short | \
	awk '{
		print "%{A:xterm -e bash funciones.sh cal:}%{F#FFFFFF}" $1 "%{A}"
	}'
}
	
	
Volumen () {
(pamixer --get-volume --get-mute && pamixer --source 1 --get-mute) | tr '\n' ' '  | awk '{
		print "%{A:xterm -e pulsemixer &:}%{F#BEBEBE}VOL%{F#FFFFFF}" $2 "%{A}"; 
		if ($1=="true") print "%{A:bash pamixer --toggle-mute &:}%{F#DCDC66}PARL%{A}";
			# Si el parlante por defecto está silenciado, mostrar una alerta.
 		if ($3=="false") print "%{A:pamixer --source 1 --toggle-mute &:}%{F#DCDC66}MICR%{A}"
 			# Si el micrófono por defecto NO está silenciado, mostrar una alerta.
 		}' | tr '\n' ' '
}


Memoria (){
free -m | \
	awk 'NR==2{
		mempc= int(($3/$2)*100)
		if (mempc >= 60)
			print "%{F#DCDC66}MEM%{F}"
	}
	NR==3{
		swappc= int(($3/$2)*100)
		if (swappc >= 25)
			print "%{F#FF0000}SWAP%{F}"
	}
	' | tr '\n' ' '
}

Procesador (){
	top -bn1 | \
		awk 'NR==3{
			if ($2 > 75)
				print "%{F#DCDC66}PROC%{F}"
		}'
}

Bateria (){
	cat $DIRECTORIO_BATERIA/charge_now $DIRECTORIO_BATERIA/charge_full $DIRECTORIO_BATERIA/status | tr '\n' ' ' | \
	awk '{
		cargapc=int(($1/$2)*100)
		print "%{F#BEBEBE}BAT%{F#FFFFFF}" cargapc "%{F}%{F}"
		if ($3 == "Charging")
			print "%{F#0080FF}CARGANDO%{F}"
	}' | tr '\n' ' '
}

DireccionesIP (){
	ip a | \
	awk '/inet/ && $2 !~ /127.0.0.1/ && $1 !~ /inet6/ {
		print "%{F#BEBEBE}" $NF " %{F#FFFFFF}" substr($2,1,match($2,"/")-1 "%{F}%{F}")
	}' | tr '\n' ' '
}

Clima () {
	awk -v clima=$($FUNCIONES temp get) 'BEGIN {print "%{A:xterm -e w3m tn.com.ar/clima:}%{F#BEBEBE}" clima "%{A}%{F}" }'
}
	
while true;
	do
	echo " " $(Reloj) $(Bateria) $(Clima) $(Procesador) $(Memoria)
	# $(Clima) $(Volumen)
	sleep 1;
done
