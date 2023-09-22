#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DOCKER_COMPOSE_FILE=$SCRIPT_DIR/docker-compose.yml

usage() {
  echo "Usage: $0 <action>"
  echo "  all: run all setup scripts"
  echo "  clean: clean up all setup scripts"
  echo "  help: print this help message"
}

setup_docker_compose() {
  docker compose -f $DOCKER_COMPOSE_FILE up -d
}

teardown_docker_compose() {
  docker compose -f $DOCKER_COMPOSE_FILE down
}

main() {
  local action=$1

  if [[ -z $action ]]; then
    usage
    exit 1
  fi

  case $action in
  all)
    setup_docker_compose
    ;;
  clean)
    teardown_docker_compose
    ;;
  help)
    usage
    exit 0
    ;;
  *)
    usage
    exit 1
    ;;
  esac
}

main $@
