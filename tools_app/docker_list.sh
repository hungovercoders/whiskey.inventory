echo "Starting script: $0..."
echo "Listing all images..."
docker images
echo "Listed all images."
echo ""
echo "Listing all containers..."
docker ps --all
echo "Listed all containers."
echo "Completed script: $0."