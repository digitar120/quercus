date "+%H:%M, %A %d de %B"


# Intercambiar BATDIR por DIRECTORIO_BATERIA, e importar la variable desde el archivo de configuración
. ../configuraciones/variables.sh

cat $DIRECTORIO_BATERIA/charge_now $DIRECTORIO_BATERIA/charge_full $DIRECTORIO_BATERIA/status | tr '\n' ' ' | awk '
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
