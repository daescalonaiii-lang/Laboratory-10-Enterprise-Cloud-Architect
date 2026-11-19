#!/bin/bash
# automation-script.sh
# Backs up MySQL database and cleans old backups

BACKUP_DIR="/home/student/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
CONTAINER="wordpress_db"
DB_NAME="wordpress"
DB_USER="wpuser"
DB_PASS="StrongWPPass123!"
RETENTION_DAYS=7

mkdir -p "$BACKUP_DIR"

echo "[$(date)] Starting backup..."
docker exec "$CONTAINER" mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/db_$DATE.sql"

if [ $? -eq 0 ]; then
    echo "[$(date)] Backup successful: db_$DATE.sql"
else
    echo "[$(date)] ERROR: Backup failed!" >&2
    exit 1
fi

# Delete backups older than 7 days
find "$BACKUP_DIR" -name "db_*.sql" -mtime +$RETENTION_DAYS -delete
echo "[$(date)] Old backups cleaned."
