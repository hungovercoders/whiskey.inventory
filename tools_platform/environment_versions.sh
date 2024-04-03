set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"

echo 'Getting git version...'
git --version
echo 'Getting terraform version...'
terraform --version
echo 'Getting az cli version...'
az --version
echo 'Upgrade az cli version...'
az upgrade
echo 'Getting az cli version...'
az --version
echo 'Getting aztfexport version...'
aztfexport --version

echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"

