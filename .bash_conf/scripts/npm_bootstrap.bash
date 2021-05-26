#!/bin/bash

# personal npm package project setup

Nl=$'\n'
IFS=$Nl

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

init_git () {
  git init &>/dev/null
}

create_readme () {
  local repo_name=$1
  touch $README_F
  echo "# $repo_name" > $README_F
}


create_gitignore () {
  touch $GITIGNORE_F

  for file in ${IGNORE_FILES[@]}; do
    echo $file >> $GITIGNORE_F
  done
}

create_lib () {
  mkdir $DEFAULT_LIB && touch $DEFAULT_LIB/$INDEX_F
}

copy_conf () {
  if [[ -d $CONFIGS_DIR ]]; then
    toggle_glob on
    cp -r $CONFIGS_DIR/. .
    toggle_glob off
  else
    echo "[!] Unable to find npm configs"
  fi
}

bootstrap_pkgjson () {
  touch $PKG_JSON

  cat > $PKG_JSON <<END
{
  "name": "$dir_name",
  "engines": {
    "node": ">= 10"
  },
  "files": [
    "dist/"
  ],
  "scripts": {
    "lint": "eslint 'lib/**/*.js' --no-fix",
    "lint:fix": "eslint 'lib/**/*.js' --fix"
  },
  "author": "Matthew Zito goldmund@freenode",
  "license": "MIT",
  "lint-staged": {
    "lib/**/*.js": [
      "npm run lint"
    ]
  },
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged",
      "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
    }
  },
  "commitlint": {
    "extends": [
      "@commitlint/config-conventional"
    ]
  },
  "config": {
    "commitizen": {
      "path": "./node_modules/cz-conventional-changelog"
    }
  }
}
END

  npm install
}

install_deps () {
  npm i -D ${DEPS[@]}
}

main () {
  local dir_name=$(basename $(pwd))

  echo -e "[+] Initializing a new NPM project in $dir_name...\n"

  init_git
  create_readme $dir_name
  create_gitignore
  create_lib
  copy_conf
  bootstrap_pkgjson
  install_deps
}

README_F='README.md'
TODO_F='TODO.md'
GITIGNORE_F='.gitignore'

EDITORCONF_F='.editorconfig'
ESLINT_F='.eslintrc'

DEFAULT_LIB='lib'
INDEX_F='index.js'
PKG_JSON='package.json'

IGNORE_FILES=(
  'node_modules'
  '.env'
  'repl.js'
  'coverage'
  'dist'
)

DEPS=(
  '@babel/core'
  '@commitlint/cli'
  '@commitlint/config-conventional'
  'babel-eslint'
  'cross-env'
  'cz-conventional-changelog'
  'eslint'
  'husky@4.3.8'
  'lint-staged'
)

CONFIGS_DIR="$HOME/.bash_conf/apps/node"

# stop here if being sourced
return 2>/dev/null

# stop on errors and unset variable refs
set -o errexit
set -o nounset
# no globbing - we don't need it here
toggle_glob off

main
