#!/bin/bash

PROFILE=""
INSTANCE_ID=""
HOST=""
DST_PORT=""
LOCAL_PORT=""

aws ssm start-session \
  --profile ${PROFILE} \
  --target ${INSTANCE_ID} \
  --region ap-northeast-1 \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["'"${HOST}"'"],"portNumber":["${DST_PORT}"], "localPortNumber":["${LOCAL_PORT}"]}'
