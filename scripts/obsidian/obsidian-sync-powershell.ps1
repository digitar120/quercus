$LOCAL_VAULT=""
$REMOTE_VAULT=""
$PROVIDER=""

Switch ($args[0])
{
    exec 	{
	while ($true){
		Get-Date >> obsidian-sync-log.txt
		echo "EJECUTANDO" >> obsidian-sync-log.txt
		rclone bisync ${PROVIDER}:${REMOTE_VAULT} $LOCAL_VAULT >> obsidian-sync-log.txt
		
		Get-Date >> obsidian-sync-log.txt
		echo "ESPERANDO" >> obsidian-sync-log.txt
		Start-Sleep -Seconds 60 >> obsidian-sync-log.txt
	}}
    resync 	{rclone bisync --resync ${PROVIDER}:${REMOTE_VAULT} $LOCAL_VAULT}
    default {exit 1}
}