#アカウント内のIAM USERの情報を取得し、ユーザーごとに所属しているGroupを取得する
export AWS_PROFILE=""

users_list=$(aws iam list-users --query "Users[].UserName" --output text)
{
for user in $users_list
do
    echo "${user} to group"
    echo "___________________________________"
    aws iam list-groups-for-user --user-name $user --query "Groups[].GroupName"
    echo "___________________________________"
    echo ""
done
} > output.txt