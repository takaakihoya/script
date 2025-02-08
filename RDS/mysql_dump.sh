#!bin/bash
date=$(date +%Y%m%d)
rds_name=""
password=""
root_user=""
endpoint=""
enegine_version=""
parameter_group=""
databases_list=""
user_list=""
backup_path=""

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
aws rds describe-db-parameters --db-parameter-group-name ${parameter_group} --region ap-northeast-1 > ${backup_path}/${rds_name}_${parameter_group}_${enegine_version}_${date}.csv