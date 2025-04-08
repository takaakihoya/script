#!bin/bash
endpoint=""
root_user=""
port=""
date=""
rds_name=""
enegine_version=""
db_list=""
export PGPASSWORD=''
user_list=""
restore_list=""

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