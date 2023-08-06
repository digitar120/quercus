. ../configuraciones/variables.sh

cat $DIRECTORIO_BRILLO | awk '{print $1+15}' > $DIRECTORIO_BRILLO
