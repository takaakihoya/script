#SSMを使用して、EC2インスタンスにポートフォワーディングを行う
#ユースケースとしては、プライベートに置いたDBに対して、ローカルからアクセスする場合などがある
#参考: https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/session-manager-working-with-port-forwarding.html
#使い方
#target_instance_id: 踏み台用のインスタンスID
#localPortNumber: ローカルで使用するポート番号、最終的にはこのポート番号でアクセスする
#host: ポートフォワーディング先のホスト、今回だとDBのホスト名
#portNumber: ポートフォワーディング先のポート番号、今回だとDBのポート番号

aws ssm start-session \
  --profile ${AWS_PROFILE} \
  --target ${instance_id} \
  --region ap-northeast-1 \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["'"10.104.41.152"'"],"portNumber":["80"], "localPortNumber":["3011"]}'
