#!/bin/bash
#任意のインスタンスのAMIを作成するスクリプトです。以下の変数を設定して使用してください。
#create_listにインスタンスIDを追加
#AWS_PROFILEにプロファイル名を追加

#AWSのプロファイルを指定
export AWS_PROFILE=""

# インスタンスIDのリストを定義
# create_list=("i-xxxxxxxxxxxxxxxxx" "i-xxxxxxxxxxxxxxxxx")
create_list=()

# AMIの作成
for instance_id in "${create_list[@]}"
do
  # インスタンスの名前を取得
  instance_name=$(aws ec2 describe-instances --instance-ids $instance_id --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" --output text)
  
  # AMIの名前を定義
  ami_name="archived_AMI_backup-${instance_name}-$(date +'%Y%m%d')"

  # AMIを作成
  aws ec2 create-image --instance-id $instance_id --name "$ami_name" --no-reboot

  echo "AMI $ami_name を作成しました"
done
