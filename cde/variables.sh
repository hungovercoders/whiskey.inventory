set -a
. ./domain.env
set +a

export TF_VAR_environment=$ENVIRONMENT
export TF_VAR_unique_namespace=$UNIQUE_NAMESPACE
export TF_VAR_organisation=$ORGANISATION
export TF_VAR_region=$ARM_REGION
export TF_VAR_team=$TEAM
export TF_VAR_domain=$DOMAIN
export TF_BACKEND_CONTAINER=$ENVIRONMENT
TF_BACKEND_RESOURCE_GROUP="state-rg-$UNIQUE_NAMESPACE"
TF_BACKEND_STORAGE_ACCOUNT="statesa$UNIQUE_NAMESPACE"

echo "Unique Namespace is $TF_VAR_unique_namespace" 
echo "Organisation is $TF_VAR_organisation" 
echo "Region is $TF_VAR_region" 
echo "Environment is $ENVIRONMENT" 
echo "Team is $TF_VAR_team" 
echo "Domain is $TF_VAR_domain" 
echo "State Storage Account Resource Group is $TF_BACKEND_RESOURCE_GROUP" 
echo "State Storage Account is $TF_BACKEND_STORAGE_ACCOUNT" 
echo "State Storage Account Container is $TF_BACKEND_CONTAINER"
