#imageをpullして、tagをつけなおしてpushする
export AWS_PROFILE="default"

region="ap-northeast-1"
account_id="251469776981"
image_tag="v1"
repo_name="myapp"


aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${region}.amazonaws.com
# docker pull ${account_id}.dkr.ecr.${region}.amazonaws.com/${repo_name}:${image_tag}
# docker tag hello-world:latest ${account_id}.dkr.ecr.${region}.amazonaws.com/${repo_name}:latest
docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${repo_name}:latest


# aws ecr describe-images --repository-name myapp
# {
#     "imageDetails": [
#         {
#             "imageSizeInBytes": 133346056, 
#             "imageDigest": "sha256:8401bb0035eedc2f101d96eabdf9ed37269f76f14daed080fe924d54d9772037", 
#             "imageTags": [
#                 "latest"
#             ], 
#             "registryId": "xxxxxxxxxxxx", 
#             "repositoryName": "sample-app", 
#             "imagePushedAt": xxxxxxxxxxxx.0
#         }
#     ]
# }

# ファイルから読み込む
# どっかーログイン
# ぷる
# タグ付け替える
# プッシュ