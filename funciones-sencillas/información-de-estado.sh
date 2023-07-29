date "+%H:%M, %A %d de %B"

BATDIR="/sys/class/power_supply/BAT1"
cat $BATDIR/charge_now $BATDIR/charge_full $BATDIR/status | tr '\n' ' ' | awk '
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
