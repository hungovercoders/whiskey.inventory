set -e  # Exit immediately if a command exits with a non-zero status.

set -a
. ./domain.env
set +a

echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"

sh ./test/smoke_test.sh
sh ./test/karate_test.sh

echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"




