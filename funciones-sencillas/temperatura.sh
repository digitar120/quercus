sensors | awk 'NR==12 {
	if ( substr($2,1,length($2)-2) > 80 )
		print "T"
	else
		print "-"
	
}' | tr '\n' ' '
