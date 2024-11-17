#!bin/bash
export AWS_PROFILE="robothome-dev"
date=$(date +%Y%m%d)
databases_list="db_list_ivtz-stg-rds-01-cluster.txt"
user_list="user_list_ivtz-stg-rds-01-cluster.txt"
password="Ht0506!?" 
root_user="admin"
endpoint="mysql.cxmqemkqukrn.ap-northeast-1.rds.amazonaws.com"
rds_name="ivtz-stg-rds-01-cluster"
enegine_version="MySQL_Community_5.7.44"
backup_path="stg-rds/ivtz-stg-rds-01-cluster"

#dumpファイルを取得
while read -r db;do
    mysqldump -h $endpoint -u $root_user -p$password --databases $db > ${backup_path}/${rds_name}_${enegine_version}_${db}_dump_${date}.sql
done < $databases_list

#userと、そのuserに付与された権限を作成するコマンドを取得
while read -r user_name host;do
    mysql -h $endpoint -u $root_user -p$password -e \
    "SELECT CONCAT('CREATE USER ''', user, '''@''', host, ''' IDENTIFIED BY ''', authentication_string, ''';')
    FROM mysql.user
    WHERE user = '${user_name}';" > ${backup_path}/${rds_name}_create_user_${user_name}_${date}.sql
    mysql -h $endpoint -u $root_user -p$password -e "SHOW GRANTS FOR '${user_name}'@'$host';" >> ${backup_path}/${rds_name}_create_user_${user_name}_${date}.sql
done < $user_list

#パラメータグループの情報をCSVで取得
aws rds describe-db-parameters --db-parameter-group-name default.aurora-mysql5.7 > ${backup_path}/${rds_name}_default.aurora-mysql5.7_5.7.mysql_aurora.2.11.5_${date}.csv