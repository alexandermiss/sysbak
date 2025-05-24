#!/bin/sh

. ./src/log.sh
. ./src/constants.sh

_getMenu(){
  local RET=$(gum choose "$@")
  echo $RET
}


menuActions(){
  local RET=$(_getMenu ${ACTIONS[@]})
  echo $RET
}

allDatabases(){
  local THE_DATABASES=$(cat config.json | jq -r ".databases[].db")
  echo $THE_DATABASES
}

getConfigDatabase(){
  local DB_NAME=$1
  local SELECTED_DATABASE=$(jq -c ".databases[] | select(.db == \"$DB_NAME\")" config.json)
  echo $SELECTED_DATABASE
}

getConfigByAttr(){
  local SELECTED_DATABASE=$1
  local ATTR=$2
  local RET=$(echo $SELECTED_DATABASE | jq -r ".$ATTR")

  echo $RET
}


menuDatabases(){
  local THE_DATABASES=$(allDatabases)
  local RET=$(_getMenu ${THE_DATABASES[@]})
  echo $RET
}
