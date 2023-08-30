#!/bin/bash

[ -z "$1" ] && echo "Invalid Database" && exit

# Create directory if it does not exist
DIR_PATH=~/DB_BACKUPS
if [ ! -d "$DIR_PATH" ]; then
  mkdir -p "$DIR_PATH"
fi
cd $DIR_PATH

# Setup variables
DB_HOST="localhost"
DB_USERNAME="root"
DB_PASSWORD="new-password"
DB_DATABASE=$1
OUTPUT_SQL=$DB_DATABASE.$(date '+%Y%m%d%H%M').sql

echo
echo "Output Path:"
echo -e "/home/ubuntu/DB_BACKUPS/$OUTPUT_SQL.tar.gz"
echo

echo "Dumping DB"
echo "MYSQL_PWD=$DB_PASSWORD mysqldump -h $DB_HOST -u $DB_USERNAME $DB_DATABASE > $OUTPUT_SQL"
MYSQL_PWD=$DB_PASSWORD mysqldump -h $DB_HOST -u $DB_USERNAME $DB_DATABASE > $OUTPUT_SQL

echo 
echo "Compressing"
tar -czvf $OUTPUT_SQL.tar.gz $OUTPUT_SQL

rm $OUTPUT_SQL