#!/bin/bash
#ローカルからEC2経由でRDSにアクセスする
set -eu

AWS_PROFILE=""
EC2_NAME=""
RDS_NAME=""

instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${EC2_NAME}" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].InstanceId" --output text --profile ${AWS_PROFILE})
rds_host=$(aws rds describe-db-instances --db-instance-identifier ${RDS_NAME} --query 'DBInstances[*].Endpoint.Address' --output text --profile ${AWS_PROFILE}) 

echo "instance_id: ${instance_id}"
echo "rds_host: ${rds_host}"

aws ssm start-session \
  --profile ${AWS_PROFILE} \
  --target ${instance_id} \
  --region ap-northeast-1 \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["'"${rds_host}"'"],"portNumber":["3306"], "localPortNumber":["33061"]}'