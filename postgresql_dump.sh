bash <<'EOF'
#!/bin/bash

# 変数設定
RDS_HOST="tateru-dev-post-02.cfhbatrcqnw3.ap-northeast-1.rds.amazonaws.com" # RDSホスト名
RDS_USER="postgres"                                                                                                 # RDSユーザー名
RDS_NAME="tateru-dev-post-02"                                                                                 #RDSインスタンス名
version="PostgreSQL12.19"                                                                                          #エンジンバージョン
BACKUP_DIR="./dev-rds/tateru-dev-post-02"                                                               # バックアップを保存するディレクトリ
DATE=$(date +%Y%m%d)                                                                                            # 日付（YYYYMMDD形式

# パスワードを入力せずにpg_dumpするための環境変数
export PGPASSWORD=""

# データベースのリストを取得
databases=$(psql -h $RDS_HOST -U $RDS_USER -d postgres -t -c "SELECT datname FROM pg_database;")

# 各データベースに対してバックアップを取得
for db in $databases; do
        BACKUP_FILE="${BACKUP_DIR}/${RDS_NAME}_${version}_${db}_dump_${DATE}.sql"

        # pg_dumpでバックアップを取得
        pg_dump -h $RDS_HOST -U $RDS_USER -d $db -f "$BACKUP_FILE"
        if [[ $? -eq 0 ]]; then
                echo "Backup of database '$db' completed successfully."
        else
                echo "Backup of database '$db' failed!"
        fi
done
EOF
