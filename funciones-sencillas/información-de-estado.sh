date "+%H:%M, %A %d de %B"


# Intercambiar BATDIR por DIRECTORIO_BATERIA, e importar la variable desde el archivo de configuración
. ../configuraciones/variables.sh
CARGA_ACTUAL=$DIRECTORIO_BATERIA/charge_now
CARGA_COMPLETA=$DIRECTORIO_BATERIA/charge_full
ESTADO=$DIRECTORIO_BATERIA/status

cat $CARGA_ACTUAL \
	$CARGA_COMPLETA \
	$ESTADO \
	| tr '\n' ' ' | awk '
{
	chargepc= int(($1/$2)*100)
	if ($3=="Charging")
		print "BAT " chargepc ", CARGANDO"

	else
		print "BAT " chagepc
}' 


top -bn1 | awk '
NR==3 {
	print "PROC " $2	
}'


free -m | awk '
NR==2 {
	mempc=int(($3/$2)*100)
	print "MEM " mempc
}
NR==3 {
	swappc=int(($3/$2)*100)
	print "SWAP " swappc
}
'


ip a | awk '/inet/ && $2 !~ /127.0.0.1/ {
	print $NF " " substr($2,1,match($2,"/")-1)
}'
