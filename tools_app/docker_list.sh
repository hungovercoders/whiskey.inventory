set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"
echo "Listing all images..."
docker images
echo "Listed all images."
echo ""
echo "Listing all containers..."
docker ps --all
echo "Listed all containers."
echo "Completed script: $0."