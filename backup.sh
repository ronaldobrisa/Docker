#!/usr/bin/env bash 

# Define the backup directory
backup_dir="/home/ronaldobrisa/Docker"

# Define the backup file name
backup_file="backup-$(date +%Y-%m-%d).tar.gz"

# Create the backup
tar -czf $backup_dir/$backup_file /var/lib/docker/volumes

# Remove backups older than 30 days
find $backup_dir -name "backup-*.tar.gz" -type f -mtime +30 -exec rm {} \;

# Upload to github
cd /home/ronaldobrisa/Docker
git add .
git commit -m "Backup"
git push origin master

# End of script
