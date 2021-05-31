#!/usr/bin/env bash

Nl=$'\n'
IFS=$Nl

# install cmds

install_npm () {
  npm i
}

# util

toggle_glob () {
  case $1 in
    on)
      set +o noglob
      ;;
    off)
      set -o noglob
      ;;
  esac
}

check_conf () {
  local env=$1

  [[ -d $TEMPL_DIR/$env ]] && echo 0 || echo 1
}

# setup helpers

init_git () {
  git init &>/dev/null
}

copy_conf () {
  local env=$1

  toggle_glob on
  cp -r $TEMPL_DIR/$env/. .
  toggle_glob off
}

install_deps () {
  local env=$1

  case $env in 
    npm )
      install_npm
      ;;

    *)
      echo -e "[!] No install command found; skipping step...\n"
  esac
}

main () {
  local dir_name=$(basename $(pwd))
  local env=$1
  
  if (( $(check_conf $env) == 1 )); then
    echo -e "[!] Unable to find config for environment '$env'\n"
    exit 0
  fi
  
  echo -e "[+] Initializing a new $env environment in $dir_name...\n"

  init_git 
  copy_conf $env
  install_deps $env

  echo -e "[+] Project setup complete\n"
}

TEMPL_DIR="$HOME/.templates"

# stop here if being sourced
return 2>/dev/null

# stop on errors and unset variable refs
set -o errexit
set -o nounset

# no globbing - we don't need it here
toggle_glob off

main $*
