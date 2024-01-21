set -e  # Exit immediately if a command exits with a non-zero status.

set -a
. ./domain.env
set +a

echo "MESSAGE: Environment variables are..."
echo "Unique Namespace is $ORGANISATION" 
echo "Organisation is $ORGANISATION" 
echo "Region is $ARM_REGION" 
echo "Environment is $ENVIRONMENT" 
echo "Team is $TEAM" 
echo "Domain is $DOMAIN" 