echo "Starting script: $0..."

set -a
. ./domain.env
set +a

URL=${1:-http://localhost:$PORT/health}
echo "Url to be smoke tested is $URL..."

retries=5
wait=1
timeout=$(($wait*5))

echo "Test configured with time between retries of $wait second with a maximum of $retries retries resulting in a timeout of $timeout seconds."

counter=1
while [ $counter -le $retries ]; do
    echo "Attempt $counter..."
    echo "Requesting response..."
    response=$(curl -s -o /dev/null -w "%{http_code}" $URL)
    if [ "$response" -eq 200 ]; then
        echo "\e[32mSuccess: HTTP status code is 200\e[0m"
        exit 0
    elif [ "$response" -eq 000 ]; then
        echo "\e[33mPending: HTTP status code is 000\e[0m"
    else
        echo -e "\e[31mError: HTTP status code is $response\e[0m"
        exit 1
    fi

    sleep $wait
    echo "Waiting $wait second to ensure container is up before trying again..."
    counter=$(expr $counter + 1)
    done
echo "\e[31mTimed out after $retries retries over a period of $timeout seconds.\e[0m"
exit 1