$LOCAL_VAULT=""
$REMOTE_VAULT=""
$PROVIDER=""

Switch ($args[0])
{
    exec 	{rclone bisync ${PROVIDER}:${REMOTE_VAULT} $LOCAL_VAULT}
    resync 	{rclone bisync --resync ${PROVIDER}:${REMOTE_VAULT} $LOCAL_VAULT}
    default {exit 1}
}