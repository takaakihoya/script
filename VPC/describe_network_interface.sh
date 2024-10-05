export AWS_PROFILE="sand-hoya"

subnet_ids=$(aws ec2 describe-subnets \
    --query "Subnets[*].SubnetId" \
    --output text)

SUBNETID=$subnet_ids

for subnet_id in $SUBNETID
do
    echo "subnet_id: $subnet_id"
    aws ec2 describe-network-interfaces \
        --filters Name=subnet-id,Values="$subnet_id" \
        --query 'NetworkInterfaces[].{
            PrivateIpAddress:PrivateIpAddress,
            PublicIp:Association.PublicIp,
            Name:TagSet[?Key==`Name`]|[0].Value,
            Description:Description,
            InstanceId:Attachment.InstanceId,
            NetworkInterfaceId:NetworkInterfaceId,
            Status:Status
        }' \
        --output json \
        | jq -r '
            ["プライベートIP","パブリックIP","説明","Name","インスタンスID","インタフェースID","ステータス"],
            (.[] | [.PrivateIpAddress, .PublicIp, .Description, .Name, .InstanceId, .NetworkInterfaceId, .Status]) | @csv' \
        | awk 'NR==1;NR>1{print $0 | "sort -V -t , -k 1"}'
done