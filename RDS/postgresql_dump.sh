#!/bin/bash

# 変数設定
date=$(date +%Y%m%d)
rds_name="tateru-dev-post-02"
root_user="postgres"
endpoint="tateru-dev-post-02.cfhbatrcqnw3.ap-northeast-1.rds.amazonaws.com"
enegine_version="PostgreSQL_12.19"
parameter_group="default.postgres12-db-hg5ghroto5jpn2jwqiel4khuky-upgrade"
databases_list="script/db_list_${rds_name}.txt"
backup_path="dev-rds/${rds_name}"
export PGPASSWORD='C4p.wVz*'

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