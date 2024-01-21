set -e  # Exit immediately if a command exits with a non-zero status.

apply=${1:-False}
echo "Apply: $apply"
set -a
. ./domain.env
set +a

# the following is used to generate a plan against production as part of pull request
# in a production-plan environment
echo "MESSAGE: removing -plan from environment name if present..."
ENVIRONMENT=$(echo $ENVIRONMENT | sed 's/-plan//')

echo "MESSAGE: Setting terraform state variables..."
export TF_VAR_environment=$ENVIRONMENT
export TF_VAR_unique_namespace=$UNIQUE_NAMESPACE
export TF_VAR_organisation=$ORGANISATION
export TF_VAR_region=$ARM_REGION
export TF_VAR_team=$TEAM
export TF_VAR_domain=$DOMAIN
export TF_BACKEND_CONTAINER=$ENVIRONMENT
TF_BACKEND_RESOURCE_GROUP="state-rg-$UNIQUE_NAMESPACE"
TF_BACKEND_STORAGE_ACCOUNT="statesa$UNIQUE_NAMESPACE"

echo "MESSAGE: Terraform state variables are..."
echo "Unique Namespace is $TF_VAR_unique_namespace" 
echo "Organisation is $TF_VAR_organisation" 
echo "Region is $TF_VAR_region" 
echo "Environment is $TF_VAR_environment" 
echo "Team is $TF_VAR_team" 
echo "Domain is $TF_VAR_domain" 
echo "State Storage Account Resource Group is $TF_BACKEND_RESOURCE_GROUP" 
echo "State Storage Account is $TF_BACKEND_STORAGE_ACCOUNT" 
echo "State Storage Account Container is $TF_BACKEND_CONTAINER"

echo "MESSAGE: Changing to terraform directory..."
cd  terraform

echo "MESSAGE: Initalising terraform..."
terraform init -backend-config="resource_group_name=$TF_BACKEND_RESOURCE_GROUP" -backend-config="storage_account_name=$TF_BACKEND_STORAGE_ACCOUNT" -backend-config="container_name=$TF_BACKEND_CONTAINER"

echo "MESSAGE: Formatting terraform..."
terraform fmt

echo "MESSAGE: Validating terraform..."
terraform validate

echo "MESSAGE: Planning terraform..."
terraform plan

if [ $apply = True ]; then
    echo "MESSAGE: Applying terraform..."
    terraform apply -auto-approve
fi
