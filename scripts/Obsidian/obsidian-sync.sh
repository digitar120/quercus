#!/bin/bash
LOCAL_VAULT=
REMOTE_VAULT=
PROVIDER=

case $1 in
	"exec")
		rclone bisync $PROVIDER:$REMOTE_VAULT $LOCAL_VAULT
	;;
	resync)
		rclone bisync --resync $PROVIDER:$REMOTE_VAULT $LOCAL_VAULT
	;;
	*)
		exit 1
	;;
esac
