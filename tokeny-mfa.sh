#!/bin/bash

CREDS=$(AWS_PROFILE=tokeny aws sts assume-role --role-arn \
  arn:aws:iam::727202443181:role/Sysless \
  --role-session-name my-sls-session --out json)
export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r '.Credentials.SessionToken')

$@
