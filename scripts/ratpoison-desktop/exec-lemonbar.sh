#!/bin/bash
# Script de abstracción de la ejecución de Lemonbar
SCRIPT_ROOT=$HOME/Scripts/funciones-linux/scripts/ratpoison-desktop

# Dimensiones de la pantalla, expresadas como variables en Awk para realizar aritmética.
SCREEN_WIDTH="-vscreen_width=$($SCRIPT_ROOT/funciones.sh scrw)"
SCREEN_HEIGTH="-vscreen_heigth=$($SCRIPT_ROOT/funciones.sh scrh)"

# Proporción de la pantalla ocupada por Lemonbar. El espacio restante es ocupado por Stalonetray. Expresada como variable externa de Awk. Expresada en valores entre 0 y 1.
LEMONBAR_PROPORTION="-vlemonbar_proportion=0.8"

LEMONBAR_WIDTH=$(awk $SCREEN_WIDTH $LEMONBAR_PROPORTION '{print screen_width*lemonbar_proportion }')


# Ejecución
# bash $HOME/.lemonbar.sh | lemonbar -p -g "$LEMONBAR_WIDTH"x"$LEMONBAR_HEIGTH" -B "#1d1f21" -f Terminus:size=10 | $SHELL
