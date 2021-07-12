#!/usr/bin/env bash

Nl=$'\n'
IFS=$Nl

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

setup_files () {
  local env=$1

  toggle_glob on
  cp -r $TEMPL_DIR/$env/. .
  toggle_glob off
}

designate () {
  local proj=$1

  find . -type f -exec sed -i "s/<project>/"$proj"/g" {} \;
  sed -i "s/<year>/$(date +%Y)/" LICENSE
}

designate_for () {
  local env=$1 
  local proj=$2
  
  case $env in 
    npm )
      designate $proj
      ;;
    go )
      designate $proj
      ;;
    c )
      designate $proj
    clib )
      designate $proj
      ;;
    *)
      :
  esac
}

install_deps () {
  local env=$1
  local proj=$2

  case $env in 
    npm )
      yarn install
      ;;
    go )
      go mod init $proj
      ;;
    * )
      :
  esac
}

main () {
  local dir_name=$(basename $(pwd))
  local env=$1
  local proj=$2
  
  if (( $(check_conf $env) == 1 )); then
    echo -e "[!] Unable to find config for environment '$env'\n"
    exit 1
  fi
  
  echo -e "[+] Initializing a new $env environment for $proj in $dir_name...\n"

  init_git 
  setup_files $env
  designate_for $env $proj
  install_deps $env $proj

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
