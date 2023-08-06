# Adquirir directorio en el que residen los controles de brillo
. ../configuraciones/variables.sh
	# Importar DIRECTORIO_BRILLO

# $1 representa el primer parámetro pasado al script.
echo $1 > $DIRECTORIO_BRILLO/brightness
