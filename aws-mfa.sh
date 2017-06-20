#!/bin/bash
#
# Provide basic support for MFA-required temporary sessions with the AWS CLI.
# While not a hard dependency, this script plays nicely with zsh and the
# aws plugin for oh-my-zsh. jq is required.
#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/aws/aws.plugin.zsh
# https://stedolan.github.io/jq/manual/
#
# Usage:
#
# Activate an existing AWS profile defined in ~/.aws/credentials
# > asp <your-profile>
#
# # Prompt for an MFA code and use it to establish a temporary session
# > . aws-mfa
#
# The script will create or update a profile called "<your-profile>-mfa" with
# the temporary credentials and activate it.

create_session_profile() {
    MFA_SERIAL=$(aws sts get-caller-identity --output json | jq -r '.Arn' | sed -e 's/\:user\//:mfa\//')
    echo -n "Enter MFA Code: " && read -r TOKEN_CODE

    SESSION_CREDS=$(aws sts get-session-token \
			--serial-number "$MFA_SERIAL" \
			--token-code "$TOKEN_CODE" \
			--query "Credentials" \
			--output json | paste -s -d'\0' -)

    SESSION_ACCESS_KEY=$(jq -rn --argjson creds "$SESSION_CREDS" '$creds.AccessKeyId')
    SESSION_SECRET_KEY=$(jq -rn --argjson creds "$SESSION_CREDS" '$creds.SecretAccessKey')
    SESSION_TOKEN=$(jq -rn --argjson creds "$SESSION_CREDS" '$creds.SessionToken')

    aws configure set aws_access_key_id "$SESSION_ACCESS_KEY" --profile "$1"
    aws configure set aws_secret_access_key "$SESSION_SECRET_KEY" --profile "$1"
    aws configure set aws_session_token "$SESSION_TOKEN" --profile "$1"
}

switch_profile() {
    echo "Switching profile from $AWS_PROFILE to $1"
    local rprompt=${RPROMPT/<aws:$AWS_PROFILE>/}
    export AWS_DEFAULT_PROFILE=$1
    export AWS_PROFILE=$1
    export RPROMPT="<aws:$AWS_PROFILE>$rprompt"
}

if [ ! -z "$1" ]; then
    echo "Setting AWS_PROFILE to $1"
    export AWS_PROFILE=$1
fi

if [ -z "$AWS_PROFILE" ]; then
    echo 'No profile set'
else
    MFA_PROFILE="${AWS_PROFILE}-mfa"
    create_session_profile "$MFA_PROFILE"
    switch_profile "$MFA_PROFILE"
fi
