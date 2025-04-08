#!/bin/bash
#アカウント内のディストリビューションのOAIを確認し、jsonファイルに出力する
export AWS_PROFILE=""

aws cloudfront list-distributions \
--query "DistributionList.Items[*].{CF_ID:Id,OAI_ID:Origins.Items[*].S3OriginConfig.OriginAccessIdentity}" \
| jq -r '.[] | [.CF_ID, (.OAI_ID[] // "-")] | @csv' \
> ./CloudFront-OAI.csv