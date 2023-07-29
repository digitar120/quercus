#!/bin/bash
HORA=$(date +%Y-%m-%d-%H-%M-%S)
HOSTNAME=$(uname -n)

pacman -Qet > pacman-instalados-explícitamente-$HOSTNAME-$HORA.txt
