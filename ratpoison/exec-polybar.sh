#!/bin/bash
# Es necesario adquirir el nombre que generará Polybar para dárselo a Ratpoison, ya que
# Polybar elabora el nombre de la manera: polybar-<nombre del perfil>_<nombre del display dado por Xorg>
# Este nombre, entonces, cambia según el perfil y el tipo de conexión y el índice del monitor
POLYBAR_WINDOW_NAME=$(polybar --quiet --print-wmname | tail -n1)
ratpoison -c "unmanage $POLYBAR_WINDOW_NAME"
ratpoison -c "exec polybar --reload --quiet"