set -a
. ./domain.env
set +a
echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"
set -a
. ./domain.env
set +a
python3 -m webbrowser http://localhost:$PORT/distilleries
echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"