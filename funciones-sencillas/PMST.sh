. ../configuraciones/variables.sh

BatStatus(){
local CARGA_ACTUAL=$DIRECTORIO_BATERIA/charge_now
local CARGA_COMPLETA=$DIRECTORIO_BATERIA/charge_full
local ESTADO=$DIRECTORIO_BATERIA/status

cat $CARGA_ACTUAL \
	$CARGA_COMPLETA \
	$ESTADO \
	| tr '\n' ' ' | awk '
{
	chargepc= int(($1/$2)*100)
	if ($3=="Charging")
		print "BAT " chargepc ", CARGANDO"

	else
		print "BAT " chargepc
}' 
}

ProcUse(){
top -bn1 | awk '
NR==3 {
	print "PROC " $2	
}'
}

ProcWarn(){
top -bn1 | \
	awk 'NR==3 {
		if ($2 > 75)
			print "P"
		else
			print "-"
	}
' | tr '\n' ' '
}

BarMemWarn(){
free -m | awk '
NR==2 {
	mempc=int(($3/$2)*100)
	if (mempc >= 90)
		print "M" mempc
	else
		print "-"
}
NR==3 {
	swappc=int(($3/$2)*100)
	if (swappc >= 10)
		print "S" swappc
	else
		print "-"
	
}' | tr '\n' ' '
}

MemWarn(){
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
}

FullDateTime(){
date "+%H:%M, %A %d de %B"
}

IPs(){
ip a | awk '/inet/ && $2 !~ /127.0.0.1/ {
	print $NF " " substr($2,1,match($2,"/")-1)
}'
}

case $1 in
	proc)
	case $2 in
		warn)
			ProcWarn
		;;
		use)
			ProcUse
		;;
		*)
		return 1
		;;
	esac
	;;
	mem)
		case $2 in
			#use)
			#;;
			warn)
				MemWarn
			;;
			barwarn)
				BarMemWarn
			;;
			*)
			return 1
			;;
		esac
	;;
	time)
		case $2 in
		full)
			FullDateTime
		;;
		*)
			return 1
		;;
		esac
	;;
	bat)
		BatStatus
	;;
	ips)
		IPs
	;;
	*)
	return 1
	;;
esac
	

