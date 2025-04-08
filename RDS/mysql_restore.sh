#!bin/bash
endpoint=""
password=""
root_user=""
port=""
date=""
rds_name=""
enegine_version=""
db_list=""
export MYSQL_PWD=""

#リストア
while read -r db;do
    mysql -h $endpoint -u $root_user -P $port < ${rds_name}/${rds_name}_${enegine_version}_${db}_dump_${date}.sql
done < $db_list