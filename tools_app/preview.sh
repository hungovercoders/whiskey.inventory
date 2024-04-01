echo "Starting script: $0..."
set -a
. ./domain.env
set +a
python3 -m webbrowser http://localhost:$PORT/weatherforecast
echo "Completed script: $0."