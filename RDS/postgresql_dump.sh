#!/bin/bash

# 変数設定
date=$(date +%Y%m%d)
rds_name=""
root_user=""
endpoint=""
enegine_version=""
parameter_group=""
databases_list=""
backup_path=""
export PGPASSWORD=''

# #dumpファイルを取得
while read -r db;do
    pg_dump -h $endpoint -U $root_user -d $db -f ${backup_path}/${rds_name}_${enegine_version}_${db}_dump_${date}.sql
done < ${databases_list}

#userと、そのuserに付与された権限を作成するコマンドを取得
# pg_dumpall -h $endpoint -U $root_user --roles-only --clean --if-exists -w -f ${backup_path}/${rds_name}_create_user_${date}.sql

psql -h $endpoint -U $root_user -c "SELECT * FROM pg_roles;" > ${backup_path}/${rds_name}_users_${date}.sql

unset PGPASSWORD

#パラメータグループの情報をCSVで取得
aws rds describe-db-parameters --db-parameter-group-name ${parameter_group} --region ap-northeast-1 > ${backup_path}/${rds_name}_${parameter_group}_${enegine_version}_${date}.csv