#!/bin/bash

top -bn1 | \
	awk 'NR==3 {
		if ($2 > 75)
			print "P"
		else
			print "-"
	}
' | tr '\n' ' '
