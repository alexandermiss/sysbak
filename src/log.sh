#!/bin/sh

_getLog(){
  local LEVEL=$1
  local MSG=$2
  gum log --time rfc822 --level $1 $2
}

logError(){
  local MSG=$1
  _getLog "error" "$1"
}

logInfo(){
  local MSG=$1
  _getLog "info" "$1"
}

