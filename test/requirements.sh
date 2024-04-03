set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"
sudo apt update
sudo apt-get update && sudo apt-get install -y curl
sudo apt install maven
echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"