# Adquirir directorio en el que residen los controles de brillo
. ../configuraciones/variables.sh
	# Importar DIRECTORIO_BRILLO

awk '{print $1-15}' $DIRECTORIO_BRILLO/brightness > $DIRECTORIO_BRILLO/brightness
