target="elb.sand-hoya.for-pm.lab-tateru.co."
hostedzoneid="Z097384232S8K1LP7XFYN"
described_json="./${target}_archive.json"
aws route53 list-resource-record-sets --hosted-zone-id $hostedzoneid --query "ResourceRecordSets[?Name == '$target' && Type == 'A']" --profile sand-hoya > ${described_json}
record_info=`cat ${described_json} | jq -r '.[]'`
echo $record_info > "./tmp.txt"
name=`cat "./tmp.txt" | jq '.Name'`
record_type=`cat "./tmp.txt" | jq '.Type'`
echo """{
        \"Changes\": [{
            \"Action\": \"DELETE\",
            \"ResourceRecordSet\": $record_info
        }]
    }""" > "./${target}_delete.json"
# aws route53 change-resource-record-sets --hosted-zone-id "$hostedzoneid" --change-batch file://"./${target}_delete.json" --profile sand-hoya
