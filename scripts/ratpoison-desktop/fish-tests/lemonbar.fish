#!/bin/fish
set BLANCO "-vblanco=FFFFFF"
echo $BLANCO
set GRIS "-v gris='BEBEBE'"

function Reloj
	date | \
		awk $BLANCO '{
			print "%{A:xterm -e bash funciones.sh cal:}%{F#" blanco  "}"  $1  "%{A}"
		}' 
end

switch $argv
	case 'reloj'
		Reloj
	case '*'
		echo "Opción incorrecta"
end
