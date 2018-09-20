#!/bin/bash

create_session_profile() {
    MFA_PROFILE="${1}-mfa"
    USER_ID=$(aws sts get-caller-identity | jq -r '.UserId')
    SESSION_ACCESS_KEY=$(grep -h "${USER_ID}" ~/.aws/cli/cache/* | jq -r '.Credentials.AccessKeyId')
    SESSION_SECRET_KEY=$(grep -h "${USER_ID}" ~/.aws/cli/cache/* | jq -r '.Credentials.SecretAccessKey')
    SESSION_TOKEN=$(grep -h "${USER_ID}" ~/.aws/cli/cache/* | jq -r '.Credentials.SessionToken')

    aws configure set aws_access_key_id "$SESSION_ACCESS_KEY" --profile "$MFA_PROFILE"
    aws configure set aws_secret_access_key "$SESSION_SECRET_KEY" --profile "$MFA_PROFILE"
    aws configure set aws_session_token "$SESSION_TOKEN" --profile "$MFA_PROFILE"
}

switch_profile() {
    echo "Switching profile from $AWS_PROFILE to $1"
    export AWS_PROFILE=$1
    export RPROMPT="<aws:$AWS_PROFILE>"
}

if [ ! -z "$1" ]; then
    echo "Setting AWS_PROFILE to $1"
    export AWS_PROFILE=$1
fi

if [ -z "$AWS_PROFILE" ]; then
    echo 'No profile set'
else
    create_session_profile "$AWS_PROFILE" $2
    switch_profile "${AWS_PROFILE}-mfa"
fi
