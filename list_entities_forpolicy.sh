export AWS_PROFILE=""

# ポリシー名とARNを取得
iam_policys_arn=$(aws iam list-policies --scope Local --query "Policies[].[PolicyName, Arn]" --output text)

# 各ポリシーについて処理
while read -r policy_name arn; do
    echo "$policy_name"
    echo "____________________________"
    
    # グループ名の一覧を取得して出力
    groups=$(aws iam list-entities-for-policy --policy-arn "$arn" --query "PolicyGroups[].GroupName" --output text)
    if [ -n "$groups" ]; then
        echo "PolicyGroups: $groups"
    else
        echo "PolicyGroups: None"
    fi

    # ユーザー名の一覧を取得して出力
    users=$(aws iam list-entities-for-policy --policy-arn "$arn" --query "PolicyUsers[].UserName" --output text)
    if [ -n "$users" ]; then
        echo "PolicyUsers: $users"
    else
        echo "PolicyUsers: None"
    fi

    # ロール名の一覧を取得して出力
    roles=$(aws iam list-entities-for-policy --policy-arn "$arn" --query "PolicyRoles[].RoleName" --output text)
    if [ -n "$roles" ]; then
        echo "PolicyRoles: $roles"
    else
        echo "PolicyRoles: None"
    fi

    echo "_______________________________________"
    echo ""
done <<< "$iam_policys_arn" > list_entities_for_policy.txt
