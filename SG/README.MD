## 概要
ENIにアタッチされていないSecurityGroupを洗い出します。

## 使用方法
1.以下のファイルの各行に、各リージョン内のSecurityGroupIDを記載してください
- ap1_sg_list.txt
- us1_sg_list.txt
マネコンからコピーして貼り付けると便利です。

2.スクリプト内の変数に`export AWS_PROFILE`の値を修正してください

3.`bash sg_describe.sh`コマンドを実行

4.各Security GroupがENIにアタッチされているか判断してくれます