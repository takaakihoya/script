
export AWS_PROFILE=""
#停止状態のインスタンスのIDを取得する
stoplist=$(aws ec2 describe-instances --filter "Name=instance-state-name,Values=stopped" --query 'Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key==`Name`].Value|[0]}' --output text)


echo $stoplist

停止状態のインスタンスのAMIを作成する
for  in $stoplist
do
  echo "create image from $i"
  instance_name=$(aws ec2 describe-instances --instance-ids $i --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" --output text)
  aws ec2 create-image --instance-id $i --name "${instance_name}-$(date +%Y%m%d%H%M%S)" --no-reboot
done