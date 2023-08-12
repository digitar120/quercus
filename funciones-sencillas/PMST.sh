#. ./procesador.sh
#. ./memoria.sh
#. ./temperatura.sh

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

if [[ $1 == "proc" && $2 == "warn" ]]; then
	ProcWarn;

elif [[ $1 == "proc" && $2 == "use" ]]; then
	ProcUse;
else
return 1;
fi

