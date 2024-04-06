set -e  # Exit immediately if a command exits with a non-zero status.

set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"

echo "MESSAGE: Environment variables are..."
echo "Unique Namespace is $ORGANISATION" 
echo "Organisation is $ORGANISATION" 
echo "Region is $ARM_REGION" 
echo "Environment is $ENVIRONMENT" 
echo "Team is $TEAM" 
echo "Domain is $DOMAIN" 
echo "Service is $SERVICE" 
echo "App is $APP" 
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Git branch is $BRANCH"