#!/bin/bash

if [ -z "$1" ]; then
	echo "Debe escribir un argumento."
	exit 1
fi

# Script meant to be executed in a terminal emulator
read -p "Presione Enter para alternar el estado de $1, o cierre la ventana para cancelar."
sudo systemctl is-active --quiet $1 && sudo systemctl stop $1 || sudo systemctl start $1
echo "Estado de $1 : $(sudo systemctl is-active $1)"
