set -e  # Exit immediately if a command exits with a non-zero status.

set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"
echo "MESSAGE: Docker variables are..."
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Git branch is $BRANCH"
echo "Organisation is $ORGANISATION" 
echo "Environment is $ENVIRONMENT" 
echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"