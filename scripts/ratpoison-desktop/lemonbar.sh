#!/bin/bash

source $HOME/Scripts/funciones-linux/scripts/ratpoison-desktop/variables.sh

#Colores para la barra
BLANCO='-vblanco=FFFFFF'
GRIS='-vgris=BEBEBE'
AMARILLO='-vamarillo=DCDC66'
AZUL='-vazul=0080FF'
ROJO='-vrojo=FF0000'

AWK_TEMP='-vtemp='$($FUNCIONES temp get)

Reloj(){
$FUNCIONES time short | \
	awk $BLANCO '{
		print "%{A:xterm -e bash funciones.sh cal:}%{F#"  blanco  "}"  $1  "%{A}"
	}'
}

Memoria (){
free -m | \
	awk $AMARILLO $BLANCO 'NR==2{
		mempc= int(($3/$2)*100)
		if (mempc >= 60)
			print "%{F#"  amarillo  "}MEM%{F}"  
	}
	NR==3{
		swappc= int(($3/$2)*100)
		if (swappc >= 25)
			print "%{F#"  amarillo  "}SWAP%{F}"
	}
	' | tr '\n' ' '
}

Procesador (){
	top -bn1 | \
		awk $AMARILLO 'NR==3{
			if ($2 > 75)
				print "%{F#"  amarillo  "}PROC%{F}"
		}'
}

Bateria (){
	cat $DIRECTORIO_BATERIA/charge_now $DIRECTORIO_BATERIA/charge_full $DIRECTORIO_BATERIA/status | tr '\n' ' ' | \
	awk $GRIS $BLANCO $AZUL '{
		cargapc=int(($1/$2)*100)
		print "%{F#"  gris  "}BAT%{F#"  blanco  "}" cargapc "%{F}%{F}"
		if ($3 == "Charging")
			print "%{F#"  azul  "}CARGANDO%{F}"
	}' | tr '\n' ' '
}

DireccionesIP (){
	ip a | \
	awk $BLANCO $GRIS '/inet/ && $2 !~ /127.0.0.1/ && $1 !~ /inet6/ {
		print "%{F#"  gris  "}" $NF " %{F#"  blanco  "}" substr($2,1,match($2,"/")-1 "%{F}%{F}")
	}' | tr '\n' ' '
}

Clima () {
	awk $AWK_TEMP $GRIS 'BEGIN {print "%{A:xterm -e w3m tn.com.ar/clima:}%{F#"  gris  "}" temp "%{A}%{F}" }'
}
	
while true;
	do
	echo " " $(Reloj) $(Bateria) $(Clima) $(Procesador) $(Memoria)
	# $(Clima) $(Volumen)
	sleep 1;
done
