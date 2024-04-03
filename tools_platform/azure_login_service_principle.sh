set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"
az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
az account set --subscription "$ARM_SUBSCRIPTION_NAME"
az account show
echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"