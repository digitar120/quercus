HORA=$(date +%Y-%m-%d-%H-%M-%S)
HOSTNAME=$(uname -n)

bash $HOME/Scripts/package-list-backup.sh

tar --verbose --create --file scripts-$HOSTNAME-$HORA.tar $HOME/Scripts/* $HOME/.config/mpv/input.conf $HOME/.config/mpv/mpv.conf

cp scripts-$HOSTNAME-$HORA.tar $HOME/googledrive/Scripts/
