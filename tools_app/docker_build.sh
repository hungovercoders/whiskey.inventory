set -e  # Exit immediately if a command exits with a non-zero status.

RUN=${1:-False}
PUSH=${2:-False}

echo "Starting script: $0..."

set -a
. ./domain.env
set +a

if [ $RUN = True ]; then
    echo "You have chosen to run the image as a container once built."
fi
if [ $RUN = False ]; then
    echo "You have chosen not to run the image as a container once built."
fi

if [ $PUSH = True ]; then
    echo "You have chosen to push the image once built, run and tested."
fi
if [ $PUSH = False ]; then
    echo "You have chosen not to push the image once built, run and tested."
fi

echo "Organisation is $ORGANISATION."
echo "App name is $APP."
CONTAINERNAME=$APP
echo "Container name is $CONTAINERNAME."
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Branch is $BRANCH."
if [ -n "$(git status --porcelain)" ]; then
    echo "Uncommitted changes so image tag is..."
    IMAGE_TAG="$BRANCH-development"
else
    echo "All changes committed so image tag is..."
    COMMIT_ID=$(git log -1 --format="%h")
    IMAGE_TAG="$BRANCH-$COMMIT_ID"
fi
echo "$IMAGE_TAG."
IMAGENAME=$ORGANISATION/$APP:$IMAGE_TAG
echo "Image name is $IMAGENAME."

echo "Changing to application directory to interact with docker file..."
cd api
echo "Changed to application directory to interact with docker file."
echo "Building $IMAGENAME..."
docker build -t $IMAGENAME .
echo "Built $IMAGENAME."
echo "Changing to back to root directory..."
cd ..
echo "Changed to back to root directory."


if [ "$(docker inspect -f '{{.State.Running}}' "$CONTAINERNAME" 2>/dev/null)" = "true" ]; then
    echo "Stopping container: $CONTAINERNAME"
    docker stop $CONTAINERNAME
    echo "Container stopped successfully."
else
    echo "Container $CONTAINERNAME is not currently running."
fi

if [ "$RUN" = "True" ] || [ "$PUSH" = "True" ]; then
    sh ./tools_app/docker_containers_clear.sh
    echo "Run container $CONTAINERNAME from image $IMAGENAME..."
    docker run -d -p $PORT:$PORT --name $CONTAINERNAME $IMAGENAME
    echo "Running container $CONTAINERNAME from image $IMAGENAME."
    sh ./test/tests.sh
fi

sh ./tools_app/docker_list.sh

if [ $PUSH = True ]; then
    echo "Logging in to Docker..."
    docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD ##--password-stdin - how to use?
    echo "Logged in to Docker."
    echo "Pushing image $IMAGENAME..."
    docker push $IMAGENAME
    echo "Pushed image $IMAGENAME."
fi

echo "Completed script: $0."

