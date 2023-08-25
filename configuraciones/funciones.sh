. $HOME/Scripts/funciones-linux/configuraciones/variables.sh

BR_DIR=$DIRECTORIO_BRILLO/brightness

BR=$(cat $DIRECTORIO_BRILLO/brightness)
BRM=$(cat $DIRECTORIO_BRILLO/max_brightness)
BRS=$(cat $DIRECTORIO_BRILLO/device/status)

BAT=$(cat $DIRECTORIO_BATERIA/charge_now)
BATF=$(cat $DIRECTORIO_BATERIA/charge_full)
BATS=$(cat $DIRECTORIO_BATERIA/status)



# No se pueden usar los parámetros dados desde dentro de una función
OPT_1=$1
OPT_2=$2
OPT_3=$3

Help(){
echo "
Opciones posibles

br: Control de brillo (/sys/class/backlight)
-- get: Imprimir el valor actual
-- set: Definir un nuevo valor
-- add: Sumar al valor actual
-- auth: ejecutar chmod 777 sobre el archivo de interface

cal: Mostrar un calendario sencillo y esperar.

proc: Uso del procesador
-- use: Porcentaje de uso del procesador.
-- warn: Si el uso del procesador supera el 75%, imprimir "P".

mem: Uso de la memoria
-- use: Porcentaje de uso de la memoria y el intercambio.
-- barwarn: Advertencia de uso de memoria en letras.

time: Imprime hora u hora y fecha.
-- short: Imprime horas y minutos.
-- full: Imprime hora, día de la semana, mes y año.

bat: Imprime uso de la batería y actividad del cargador.

ips: Imprime IPs asociadas a interfaces.

temp: Opciones en cuanto a la temperatura.
-- exec_once: Adquirir la temperatura y guardarla en $CLIMA
-- exec: ejecutar exec_once cada 5 minutos.
-- get: imprimir \$CLIMA

help: Imprimir esta ayuda.	
"
}

BrGet(){
	awk -v br=$BR -v brm=$BRM 'BEGIN {print int((br/brm)*100) }'
}

BrGetPretty(){
	echo "BRI" $(BrGet)
}


BrSet(){
	awk -v br=$BR -v brm=$BRM -v val=$OPT_3 'BEGIN {
		ratio=100/brm
		setResult=int( val/ratio )
		if (setResult>brm)
			print brm	
		else if (setResult<1)
			print 1
		else
			print setResult
	}' \
	> $BR_DIR
}

BrAdd(){
	awk -v br=$BR -v brm=$BRM -v val=$OPT_3 'BEGIN {
		ratio=100/brm
		addResult=int((int(br*ratio) + val)/ratio)
		
		# Evitar dar valores fuera de márgen
		if (addResult>brm)
			print brm
			
		else if (addResult<1)
			print 1
		else
			print addResult
	}' 
	> $BR_DIR
}

BrAuth(){
	sudo su -c '. variables.sh && chmod 777 $DIRECTORIO_BRILLO/brightness'
}

BatStatus(){
	awk -v bat=$BAT -v batf=$BATF -v bats=$BATS 'BEGIN {
		chargepc=int((bat/batf)*100)
		if (bats =="Charging" || bats == "Full")
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

MemUse(){
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

ShortTime(){
	date "+%H:%M"
}

IPs(){
	ip a | awk '$1=="inet" && $2 !~ /127.0.0.1/ {
		print $NF " " substr($2,1,match($2,"/")-1)
	}'
}

ClimaAcqOnce(){
	w3m -dump -4 tn.com.ar/clima | awk 'NR==16 {print $1}' > /tmp/clima
}

ClimaAcq () {
	while :
		do
		ClimaAcqOnce;
		sleep 320;
	done
}

ClimaPrint(){
	cat /tmp/clima
}

Calendar(){
	cal
	read -p "Presione cualquier tecla para cerrar."
}

SysStatus(){
	FullDateTime
	BatStatus
	BrGetPretty
	ProcUse
	MemUse
	IPs
	ClimaPrint
}



case $1 in
	sysstatus)
		SysStatus
	;;
	br)
		case $2 in
			get)
				BrGet
			;;
			get_pretty)
				BrGetPretty
			;;
			"set")	
				BrSet
			;;
			add)
				BrAdd
			;;
			auth)
				BrAuth
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
			use)
				MemUse
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
		short)
			ShortTime
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
	
	temp)
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
	"help")
		Help
	;;
	
	*)
	exit 1
	;;
esac
	

