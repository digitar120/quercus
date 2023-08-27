#!/bin/fish
set BRDIR '/sys/class/backlight/radeon_bl0/'
set BRCUR (cat $BRDIR/brightness)
set BRMAX (cat $BRDIR/max_brightness)
math --scale=0 "($BRCUR / $BRMAX) * 100"
math --scale=0 "($argv[2] / $BRMAX) * 100"
