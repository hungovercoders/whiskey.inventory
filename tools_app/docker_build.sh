set -e  # Exit immediately if a command exits with a non-zero status.

echo -e "${MESSAGE_COLOUR}Starting script: $0...${MESSAGE_NO_COLOUR}"

RUN=${1:-False}
PUSH=${2:-False}

sh ./tools_app/docker_build_component.sh api $RUN $PUSH
sh ./tools_app/docker_build_component.sh web $RUN $PUSH
sh ./tools_app/docker_list.sh

echo -e "${MESSAGE_COLOUR}Completed script: $0.${MESSAGE_NO_COLOUR}"