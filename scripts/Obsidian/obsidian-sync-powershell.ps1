$LOCAL_VAULT=""
$REMOTE_VAULT=""
$PROVIDER=""

Switch ($args[0])
{
    exec 	{while ($true){rclone bisync ${PROVIDER}:${REMOTE_VAULT} $LOCAL_VAULT >> obsidian-sync-log.txt}}
    resync 	{rclone bisync --resync ${PROVIDER}:${REMOTE_VAULT} $LOCAL_VAULT}
    default {exit 1}
}