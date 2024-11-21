#!bin/bash
endpoint="127.0.0.1"
password="root"
root_user="root"
port="13306"
date="20241119"
rds_name="tateru-dev-rds-57-cluster"
enegine_version="5.7.mysql_aurora.2.11.5"
db_list="db_list.txt"
export MYSQL_PWD="root"




#リストア
while read -r db;do
    mysql -h $endpoint -u $root_user -P $port < ${rds_name}/${rds_name}_${enegine_version}_${db}_dump_${date}.sql
done < $db_list

#確認用コマンド
# SELECT
#      TABLE_SCHEMA,
#      TABLE_NAME
#      FROM information_schema.tables
#      WHERE TABLE_SCHEMA NOT IN('information_schema' , 'mysql' , 'performance_schema' , 'sys' , 'tmp')
#      ORDER BY TABLE_SCHEMA ASC;