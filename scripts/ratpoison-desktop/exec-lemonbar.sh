#!/bin/bash
# Script de abstracción de la ejecución de Lemonbar
SCRIPT_ROOT=$HOME/Scripts/funciones-linux/scripts/ratpoison-desktop

# Dimensiones de la pantalla, expresadas como variables en Awk para realizar aritmética.
# TODO: Eliminar redirecciones a null una vez que la detección de dispositivos funcione.
SCREEN_WIDTH="-vscreen_width=$($SCRIPT_ROOT/funciones.sh scrw 2>/dev/null)"
SCREEN_HEIGTH="-vscreen_heigth=$($SCRIPT_ROOT/funciones.sh scrh 2>/dev/null)"

# Proporción de la pantalla ocupada por Lemonbar. El espacio restante es ocupado por Stalonetray. Expresada como variable externa de Awk. Expresada en valores entre 0 y 1.
LEMONBAR_PROPORTION="-vlemonbar_proportion=0.8"

LEMONBAR_WIDTH=$(awk $SCREEN_WIDTH $LEMONBAR_PROPORTION 'BEGIN {
	lemonbar_width=screen_width*lemonbar_proportion
	
	# Verificar si la multiplicación produce un decimal
	# Si el ancho es, por ejemplo, 1366 píxeles, la multiplicación por 0.8 resulta en 1092.8.
	# Se tomará como entero y se sumará un píxel al ancho de Stalonetray.
	
	if (match(lemonbar_width, ".") != 0)
		lemonbar_width=int(lemonbar_width)
	
	print lemonbar_width
	}')
	
STALONETRAY_WIDTH=$(awk $SCREEN_WIDTH $LEMONBAR_PROPORTION 'BEGIN {
	stalonetray_width=screen_width*(1-lemonbar_proportion)
	
	if (match(stalonetray_width, ".")!=0)
		# En el caso de que el ancho resultante sea un decimal, en éste punto, esos decimales 
		# ya se le restaron al ancho de Lemonbar, por lo que se le suma un píxel al ancho de
		# Stalonetray.
		stalonetray_width=int(stalonetray_width)+1
	print stalonetray_width
}')

echo $LEMONBAR_WIDTH $STALONETRAY_WIDTH


# Ejecución
# TODO: Pruebas en Xephyr fallan porque la devolución es diferente. Agregar detección de palabras.
	# La diferencia es que al iniciar el servidor con Xephyr, no se asigna un monitor primario.
	# Matchear si la tercera o la cuarta columna incluyen 2 "*" y 2 "+" ignorando errores es
	# suficiente.
# bash $HOME/.lemonbar.sh | lemonbar -p -g "1400"x"18" -B "#1d1f21" -f Terminus:size=10 | $SHELL

