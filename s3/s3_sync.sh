#!/bin/bash
#s3 sync実行及び、送信元と先のオブジェクト数を確認する

SRC_BUCKET=""
DST_BUCKET=""
PROFILE=""

#s3 sync
aws s3 sync s3://${SRC_BUCKET} s3://${DST_BUCKET} --profile ${PROFILE}

#送信元と送信先バケットでオブジェクト数、サイズの確認
SRC_CHECK=$(aws s3 ls s3://${SRC_BUCKET} --recursive --human --sum --profile ${PROFILE})
DST_CHECK=$(aws s3 ls s3://${DST_BUCKET} --recursive --human --sum --profile ${PROFILE})

echo "送信元バケットの確認"
echo ${SRC_CHECK}
echo "-------------------------------------"
echo "送信先バケットの確認"
echo ${DST_CHECK}

#バケット数が合わない時の確認コマンド
#aws s3 ls s3://${SRC_BUCKET} --recursive --profile ${PROFILE} | grep "/$"

