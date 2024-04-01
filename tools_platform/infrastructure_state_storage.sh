TF_BACKEND_RESOURCE_GROUP="state-rg-$UNIQUE_NAMESPACE"
TF_BACKEND_STORAGE_ACCOUNT="statesa$UNIQUE_NAMESPACE"
az group create -n $TF_BACKEND_RESOURCE_GROUP -l $ARM_REGION
az lock create --name Delete --lock-type CanNotDelete --resource-group $TF_BACKEND_RESOURCE_GROUP
az storage account create -n $TF_BACKEND_STORAGE_ACCOUNT -g $TF_BACKEND_RESOURCE_GROUP -l $ARM_REGION --sku Standard_LRS
az storage container create --name "development" --account-name $TF_BACKEND_STORAGE_ACCOUNT
az storage container create --name "uat" --account-name $TF_BACKEND_STORAGE_ACCOUNT
az storage container create --name "production" --account-name $TF_BACKEND_STORAGE_ACCOUNT
resourceId=$(az storage account show --name $TF_BACKEND_STORAGE_ACCOUNT --resource-group $TF_BACKEND_RESOURCE_GROUP --query id -o tsv)
az lock create --name Delete --lock-type CanNotDelete --resource $resourceId

