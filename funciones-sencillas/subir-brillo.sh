OBJETIVO="/sys/class/backlight/radeon_bl0/brightness"

cat $OBJETIVO | awk '{print $1+15}' > $OBJETIVO
