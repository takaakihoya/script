#!/bin/bash

#アーカイブ元アカウント情報
ACCOUNT_A_ID="396609837941"
REGION_A="us-east-1"
REPO_LIST_A_FILE="./dev_classic_rh_repo_image_list.txt"
SOURCE_PROFILE="robothome-dev"

#アーカイブ先アカウント情報
ACCOUNT_B_ID="879562317725"
REGION_B="ap-northeast-1"
REPO_LIST_B_FILE="./log_archive_repo_list.txt"
DEST_PROFILE="log-archive-ecr"

#アーカイブするイメージにつける日付
TODAY=$(date +%Y%m%d)

#アーカイブ元アカウントにログイン
login_to_ecr_a() {
  aws sso login --profile $SOURCE_PROFILE
  aws ecr get-login-password --profile $SOURCE_PROFILE --region $REGION_A | docker login --username AWS --password-stdin $ACCOUNT_A_ID.dkr.ecr.$REGION_A.amazonaws.com
}

#アーカイブ先アカウントにログイン
login_to_ecr_b() {
  aws sso login --profile $DEST_PROFILE
  aws ecr get-login-password --profile $DEST_PROFILE | docker login --username AWS --password-stdin $ACCOUNT_B_ID.dkr.ecr.$REGION_B.amazonaws.com
}

paste -d, "$REPO_LIST_A_FILE" "$REPO_LIST_B_FILE" | while IFS=, read -r repo_a image_id repo_b
do
  login_to_ecr_a
  #pullするイメージのURI
  SOURCE_IMAGE_URI="${ACCOUNT_A_ID}.dkr.ecr.${REGION_A}.amazonaws.com/${repo_a}:${image_id}"
  
  # イメージをプル
  docker pull $SOURCE_IMAGE_URI

#アーカイブ先アカウントにpushできるようにイメージにタグ付け
  DEST_IMAGE_URI="${ACCOUNT_B_ID}.dkr.ecr.${REGION_B}.amazonaws.com/${repo_b}:${TODAY}"
  docker tag $SOURCE_IMAGE_URI $DEST_IMAGE_URI

#アーカイブ先アカウントにイメージをプッシュ
  login_to_ecr_b
  docker push $DEST_IMAGE_URI
done
