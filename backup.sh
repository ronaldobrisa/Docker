#!/usr/bin/env bash 

# Define the backup directory
backup_dir="/home/ronaldobrisa/Docker"

# Define the backup file name
backup_file="backup-$(date +%Y-%m-%d).tar.gz"

# Create the backup
date_formatted=$(date +"%Y-%m-%d %H:%M:%S")
tar -czf $backup_dir/$backup_file-$date_formatted /var/lib/docker/volumes

# Remove backups older than 30 days
find $backup_dir -name "backup-*.tar.gz" -type f -mtime +30 -exec rm {} \;

# Log the backup
log_file="/var/log/Docker/daily-backup.log"

# Upload to github
cd /home/ronaldobrisa/Docker
git add .
git commit -m "Backup"
git push origin main

# End of script
