#!/bin/bash

export AWS_PROFILE="default"

# CSVファイルのパス
CSV_FILE="s3buckets_no_bom.csv"

while IFS=',' read -r bucket_name _; do
    # バケット名の前後にある空白や改行を削除（トリム）
    bucket_name=$(echo "$bucket_name" | xargs)

    echo "Processing bucket: $bucket_name"

    # バケットごとのローカルディレクトリとZIPファイル名を設定
    LOCAL_DOWNLOAD_DIR="./s3_downloads/$bucket_name"
    ZIP_FILE="$bucket_name.zip"

    # ローカルのダウンロードディレクトリを作成
    mkdir -p $LOCAL_DOWNLOAD_DIR

    # S3バケットの内容をローカルに同期
    aws s3 sync s3://$bucket_name $LOCAL_DOWNLOAD_DIR

    # 同期した内容をZIP形式に圧縮
    zip -r $ZIP_FILE $LOCAL_DOWNLOAD_DIR

    # 圧縮が完了したら、必要に応じてダウンロードディレクトリを削除
    # rm -rf $LOCAL_DOWNLOAD_DIR

    echo "Bucket $bucket_name has been downloaded and compressed into $ZIP_FILE"

done < "$CSV_FILE"