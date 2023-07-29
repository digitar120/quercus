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
	
}

' | tr '\n' ' '
#{
#	if (mempc < 90 && swappc < 10)
#		print " "
#}
