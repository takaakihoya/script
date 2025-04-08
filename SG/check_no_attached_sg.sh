export AWS_PROFILE=""
AP_REGION=""
AP_SG_LIST=""
US_REGION=""
US_SG_LIST=""

#ap-northeast-1のENIにアタッチされていないSGを出力
AP_OUTPUT_FILE="ap1_sg_results.txt"
> "$AP_OUTPUT_FILE"

# セキュリティグループIDを1行ずつ読み込む
while read -r sg; do
        # AWS CLIでENIに関連付けられているか確認
        result=$(aws ec2 describe-network-interfaces --region $AP_REGION \
            --filters Name=group-id,Values="$sg" \
            --query 'NetworkInterfaces[*].{ENI:NetworkInterfaceId}' \
            --output text)
        
        if [ -n "$result" ]; then
            echo "$sg is attached" >> "$AP_OUTPUT_FILE"
        else
            echo "$sg is not attached" >> "$AP_OUTPUT_FILE"
        fi
done < "$AP_SG_LIST"


#us-east-1のENIにアタッチされていないSGを出力
US_OUTPUT_FILE="us1_sg_results.txt"
> "$US_OUTPUT_FILE"

# セキュリティグループIDを1行ずつ読み込む
while read -r sg; do
        # AWS CLIでENIに関連付けられているか確認
        result=$(aws ec2 describe-network-interfaces --region $US_REGION \
            --filters Name=group-id,Values="$sg" \
            --query 'NetworkInterfaces[*].{ENI:NetworkInterfaceId}' \
            --output text)
        
        if [ -n "$result" ]; then
            echo "$sg is attached" >> "$US_OUTPUT_FILE"
        else
            echo "$sg is not attached" >> "$US_OUTPUT_FILE"
        fi
done < "$US_SG_LIST"