#!/bin/fish
set HORA (date +%Y-%m-%d-%H-%M-%S)
set HOSTNAME (uname -n)

pacman -Qet > pacman-instalados-explícitamente-$HOSTNAME-$HORA.txt
