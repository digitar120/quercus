OBJETIVO="/sys/class/backlight/radeon_bl0/brightness"

awk '{print $1-15}' $OBJETIVO > $OBJETIVO
