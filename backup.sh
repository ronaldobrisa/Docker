#!/usr/bin/env bash 

# Define the backup directory origin
backup_dir="/home/ronaldobrisa/Docker"

# Define the backup file name
backup_file="backup_Docker-$(date +%d-%m-%Y-%H:%M:%S).tar.gz"

# Create the backup destiny directory
tar -czf $backup_dir/$backup_file /mnt/backups-docker

# Verificar se o comando tar foi bem sucedido
if [ $? -eq 0 ]; then
    echo "Backup concluído com sucesso: $backup_file" >> $log_file
else
    echo "Erro no backup: $(date)" >> $log_file
fi

# Definir o cron job: execução diária às 10:15 AM
CRON_SCHEDULE="15 10 * * * $BACKUP_SCRIPT >> /home/ronaldobrisa/daily-backup.log 2>&1"

# Adicionar o cron job no crontab
(crontab -l; echo "$CRON_SCHEDULE") | crontab -

# Confirmar se o cron job foi adicionado
echo "Cron job agendado para rodar todos os dias às 10:15 AM."

# Upload to github
cd /home/ronaldobrisa/Docker
git add .
git commit -m "Backup"
git push origin main

# Log the backup
log_file="/var/log/Docker/daily-backup.log"

# Remove backups older than 30 days
find $backup_dir -name "backup-*.tar.gz" -type f -mtime +30 -exec rm {} \;

# End of script
