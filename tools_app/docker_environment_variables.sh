set -e  # Exit immediately if a command exits with a non-zero status.

echo "Starting script: $0..."
echo "MESSAGE: Docker variables are..."
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Git branch is $BRANCH"
echo "Organisation is $ORGANISATION" 
echo "Environment is $ENVIRONMENT" 
echo "Completed script: $0."