
export AWS_PROFILE="sand-hoya"
#停止状態のインスタンスのIDを取得する
# stoplist=$(aws ec2 describe-instances --filter "Name=instance-state-name,Values=stopped" --query "Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key==`Name`]}" --output text)
stoplist=$(aws ec2 describe-instances --filter "Name=instance-state-name,Values=stopped" --query 'Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key==`Name`].Value|[0]}' --output text)

echo $stoplist

#停止状態のインスタンスのAMIを作成する
# for  in $stoplist
# do
#   echo "create image from $i"
#   aws ec2 create-image --instance-id $i --name "test-$(date +%Y%m%d%H%M%S)" --no-reboot
# done