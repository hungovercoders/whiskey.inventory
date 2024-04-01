echo "Starting script: $0..."
echo "Removing all stopped containers..."
docker container prune --force
echo "All stopped containers removed."
echo "Completed script: $0."