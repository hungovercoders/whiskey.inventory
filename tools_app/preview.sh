set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"
url="http://localhost:$PORT_WEB"
echo -e "Opening $url in a web browser..."
set -a
. ./domain.env
set +a
python3 -m webbrowser $url
echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"