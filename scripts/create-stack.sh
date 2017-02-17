#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Weapon-X-CDN}
ELB=${2:-Weapo-Publi-7TOQBHZM97WZ-1865547110.us-west-2.elb.amazonaws.com}
PORT=${3:-80}
PROJECTNAME=${4:-Weapon-X}
ENVIRONMENT=${5:-development}
CREATOR=${6:-CloudFormation}
TEMPLATELOCATION=${7:-file://$(pwd)/cdn.yml}

VALIDATE="aws cloudformation validate-template --template-body $TEMPLATELOCATION"
echo $VALIDATE
$VALIDATE

CREATE="aws cloudformation create-stack --stack-name $STACKNAME \
                                        --template-body $TEMPLATELOCATION \
                                        --capabilities CAPABILITY_NAMED_IAM \
                                        --parameters ParameterKey=LoadBalancerDomainName,ParameterValue=$ELB \
                                                     ParameterKey=LoadBalancerPort,ParameterValue=$PORT \
                                        --tags Key=Project,Value=$PROJECTNAME \
                                               Key=Environment,Value=$ENVIRONMENT \
                                               Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE
