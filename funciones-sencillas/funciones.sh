. ../configuraciones/variables.sh

BR_DIR=$DIRECTORIO_BRILLO/brightness
BR=$(cat $DIRECTORIO_BRILLO/brightness)
BRM=$(cat $DIRECTORIO_BRILLO/max_brightness)
BRS=$(cat $DIRECTORIO_BRILLO/device/status)

# No se pueden usar los parámetros dados desde dentro de una función
OPT_1=$1
OPT_2=$2
OPT_3=$3


BrGet(){
	cat $BR_DIR
}

BrSet(){
	echo $OPT_3 > $BR_DIR
}

BrAdd(){
	awk -v br=$BR -v val=$OPT_3 'BEGIN {print br + val}' > $BR_DIR
}

BatStatus(){
echo $BR \
	$BRM \
	$BRS \
	| tr '\n' ' ' | awk '
		{
			chargepc= int(($1/$2)*100)
			if ($3=="connected")
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

ClimaAcqOnce(){
	CLIMA=$(w3m -dump -4 tn.com.ar/clima | awk 'NR==16 {print $1}');
}

ClimaAcq () {
	while :
		do
		ClimaAcqOnce;
		sleep 320;
	done
}

ClimaPrint(){
	echo $CLIMA
}

Calendar(){
	cal
	read -p "Presione cualquier tecla para cerrar."
}



case $1 in
	br)
		case $2 in
			get)
				BrGet
			;;
			"set")	
				BrSet
			;;
			add)
				BrAdd
			;;
			*)
				exit 1
			;;
		esac
	;;
	cal)
		Calendar
	;;
	proc)
	case $2 in
		warn)
			ProcWarn
		;;
		use)
			ProcUse
		;;
		*)
		exit 1
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
			exit 1
			;;
		esac
	;;
	time)
		case $2 in
		full)
			FullDateTime
		;;
		*)
			exit 1
		;;
		esac
	;;
	bat)
		BatStatus
	;;
	
	ips)
		IPs
	;;
	
	clima)
		case $2 in
		
		"exec")
			ClimaAcq
		;;
		
		"exec_once")
			ClimaAcqOnce
		;;
		
		get)
			ClimaPrint
		;;
		
		*)
			exit 1
		;;
		esac
	;;
	
	*)
	exit 1
	;;
esac
	

