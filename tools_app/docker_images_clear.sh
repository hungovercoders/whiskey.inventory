echo "Starting script: $0..."
echo "Removing all unused images..."
docker image prune --force
echo "All unused images removed."
echo "Completed script: $0."