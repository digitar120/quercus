# Depends on gnome-keyring

if ! ldconfig -p | grep libsecret > /dev/null
	echo "gnome-keyring is missing."
	exit 1
end

git config --global core.pager "less -r"
git config --global user.name "digitar120"
git config --global user.mail "digitar120@outlook.com"

# Setup gnome-keyring as a secret manager
dbus-send --session --print-reply --dest=org.freedesktop.DBus / \
    org.freedesktop.DBus.GetConnectionUnixProcessID \
    string:org.freedesktop.secrets

# Enable libsecret as a secret manager in Git
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

