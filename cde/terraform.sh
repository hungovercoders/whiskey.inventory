apply=${1:-False}
echo "Apply: $apply"
set -a
. ./domain.env
set +a
TF_BACKEND_RESOURCE_GROUP="state-rg-$UNIQUE_NAMESPACE"
TF_BACKEND_STORAGE_ACCOUNT="statesa$UNIQUE_NAMESPACE"
TF_BACKEND_CONTAINER=$ENVIRONMENT
export TF_VAR_environment=$ENVIRONMENT
export TF_VAR_unique_namespace=$UNIQUE_NAMESPACE
export TF_VAR_organisation=$ORGANISATION
export TF_VAR_region=$ARM_REGION
export TF_VAR_team=$TEAM
export TF_VAR_domain=$DOMAIN

cd  terraform
terraform init -backend-config="resource_group_name=$TF_BACKEND_RESOURCE_GROUP" -backend-config="storage_account_name=$TF_BACKEND_STORAGE_ACCOUNT" -backend-config="container_name=$TF_BACKEND_CONTAINER"
terraform fmt
terraform validate
terraform plan
if [ $apply = True ]; then
    echo "Applying..."
    terraform apply -auto-approve
fi
