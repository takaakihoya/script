<<<<<<< HEAD

#imageをpullして、tagをつけなおしてpushする
export AWS_PROFILE="default"
=======
#!/bin/bash
#前提として .aws/config ファイルに各プロファイル情報を記載する必要がああります
>>>>>>> a8de672781a45d586b4bda41b6da7d476a3237cf

#アーカイブ元アカウント情報
SRC_ACCOUNT_ID="396609837941"
SRC_REGION="us-east-1"
SRC_REPO_IMAGE_LIST_FILE="./dev_classic_rh_repo_image_list.txt"
SOURCE_PROFILE="robothome-dev"

#アーカイブ先アカウント情報
DEST_ACCOUNT_ID="879562317725"
DEST_REGION="ap-northeast-1"
DEST_REPO_LIST_FILE="./log_archive_repo_list.txt"
DEST_PROFILE="log-archive-ecr"

#アーカイブするイメージタグにつける日付
TODAY=$(date +%Y%m%d)

#アーカイブ元アカウントにログイン
login_to_src_ecr() {
  aws sso login --profile $SOURCE_PROFILE
  aws ecr get-login-password --profile $SOURCE_PROFILE --region $SRC_REGION | docker login --username AWS --password-stdin $SRC_ACCOUNT_ID.dkr.ecr.$SRC_REGION.amazonaws.com
}

#アーカイブ先アカウントにログイン
login_to_dest_ecr() {
  aws sso login --profile $DEST_PROFILE
  aws ecr get-login-password --profile $DEST_PROFILE | docker login --username AWS --password-stdin $DEST_ACCOUNT_ID.dkr.ecr.$DEST_REGION.amazonaws.com
}

#アーカイブ元からはリポジトリと最新のimageID、アーカイブ先からはリポジトリを読み込んで変数に入れる
paste -d, "$SRC_REPO_IMAGE_LIST_FILE" "$DEST_REPO_LIST_FILE" | while IFS=, read -r src_repo src_image_id dest_repo
do
  login_to_src_ecr
  #pullするイメージのURI
  SOURCE_IMAGE_URI="${SRC_ACCOUNT_ID}.dkr.ecr.${SRC_REGION}.amazonaws.com/${src_repo}:${src_image_id}"
  
  # イメージをプル
  docker pull $SOURCE_IMAGE_URI

#アーカイブ先アカウントにpushできるようにイメージにタグ付け
  DEST_IMAGE_URI="${DEST_ACCOUNT_ID}.dkr.ecr.${DEST_REGION}.amazonaws.com/${dest_repo}:${src_repo}_${TODAY}"
  docker tag $SOURCE_IMAGE_URI $DEST_IMAGE_URI

#アーカイブ先アカウントにイメージをプッシュ
  login_to_dest_ecr
  docker push $DEST_IMAGE_URI
done
