#!bin/bash
endpoint="127.0.0.1"
root_user="root"
port="15432"
date="20241119"
rds_name="tateru-dev-post-02"
enegine_version="PostgreSQL_12.19"
db_list="db_list.txt"
export PGPASSWORD='root'
user_list="user_list.txt"
restore_list="restore_list.txt"

#データベースの作成
while read -r db;do
    psql -h $endpoint -U $root_user -p $port -c "CREATE DATABASE $db;"
done < ${db_list}

#ユーザー作成
while read -r user;do
    psql -h $endpoint -U $root_user -p $port -c "CREATE ROLE $user WITH LOGIN SUPERUSER PASSWORD 'root';"
done < ${user_list}

#リストア
while read -r db;do
    psql -h $endpoint -U $root_user -p $port -d $db -f ${rds_name}/${rds_name}_${enegine_version}_${db}_dump_${date}.sql
done < ${restore_list}