#!/bin/bash

PROFILE=""
RULES=$(aws events list-rules --profile $PROFILE --query "Rules[].Name" --output text)

for RULE in $RULES; do
    echo "Rule: $RULE" >> target_list.json
    aws events list-targets-by-rule --rule "$RULE" --profile $PROFILE --query "Targets[].{Id:Id,Arn:Arn}" >> target_list.json
done
