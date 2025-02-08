## 概要
アカウント間でimageをECRにpushできるようにします。

## 用途
imageを他アカウントのECRに保管するのに使用します。
個人的にコマンドを使用して実施でもよかったのですが、手数が多かったのでスクリプトにしました。

## 使い方
`image_pull_and_push.sh` ファイルの変数を自身の環境に合わせて記載してください。

**SRC_REPO_IMAGE_LIST_FILE=""**

source_image_list.txt ファイルの中に、ソースとなるリポジトリURLとimage IDを各行に記載してください。

**DEST_REPO_LIST_FILE=""**

dest_repo_list.txt ファイルに、「imageを保管するリポジトリのURLを記載してください。

テキストファイルに記載するsourceとdestは必ず対になるように記載してください。