## ssm.sh
ローカル環境からEC2を経由してRDSに接続する。
ユースケースとしては、プライベートに置いたDBに対して、ローカルからアクセスする場合などがある
### 参考
https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/session-manager-working-with-port-forwarding.html

### 使い方
以下の変数を修正してください。
target_instance_id: 踏み台用のインスタンスID
localPortNumber: ローカルで使用するポート番号、最終的にはこのポート番号でアクセスする
portNumber: ポートフォワーディング先のポート番号、今回だとDBのポート番号
host: ポートフォワーディング先のホスト、今回だとDBのホスト名


