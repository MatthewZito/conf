# generate base64
base64 () {
  while getopts ":d:e:" opt; do
    case $opt in
      d)
        echo $OPTARG | openssl enc -d -base64
        ;;
      e) 
        openssl base64<<<"$OPTARG"
        ;;
      \?)
        echo "[-] Invalid option: -$OPTARG" >&2
        ;;
      :)
        echo "[!] Option -$OPTARG requires an argument" >&2
        ;;
    esac
  done
  
  # reset because we're probably going to be in the same shell for a while
  OPTIND=1
}

# render a markdown file
rmd () {
  pandoc "$1" | lynx -stdin
}

# add a new alias to bash rc
# mk_alias name "cmd && cmd -flag && cmd"
mk_alias () {
  local alias_name="$1"

  shift

  local alias_body="$@"

  [[ -z "$alias_name" ]] && {
    echo "[-] Alias name not provided"
    return 1
  }

  [[ -z "$alias_body" ]] && {
    echo "[-] Alias body not provided"
    return 1
  }

  echo "alias $alias_name='$alias_body'" >> "$HOME/.bash_conf/settings/alias.bash"

  (( "$?" == 0 )) && echo "[+] Successfully added new alias"
}

# less running processes of target
psaux () {
  pgrep -f "$@" | xargs ps -fp 2>/dev/null
}

# mount encrypted dir
open_enc () {
  local mount="$1" proxy="$2"
  
  encfs ${mount:-~/.enc/} ${proxy:-~/enc/}
}

# unmount encrypted dir
close_enc () {
  local proxy="$1"

  fusermount -u ${proxy:-~/enc}
}

# make window transparent
make_transparent () {
  xprop -format _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY 0xEFFFFFFF
}

# connect bluetooth device
blue_conn () {
  local default='DC:D3:A2:C9:23:7C'

  sudo bluetoothctl connect "${1:-$default}"
}

# launch a dockerized dev environment of pwd
dockerize () {
  docker_dir="$HOME/.templates/docker"
  docker_tag='goldmund:dev'

  is_dev_extant="$(docker image ls -f reference=$docker_tag | awk '{ print $1":"$2 }' | grep $docker_tag)"

  if [[ "$is_dev_extant" != "$docker_tag" ]]; then
    echo -e "[!] Containerized dev environment not extant; creating image...\n"
    docker build -f "$docker_dir/Dockerfile.devenv" -t "$docker_tag" .

    if [[ $? -eq 0 ]]; then
      echo -e "[+] Image created\n"
    else 
      echo "[-] Failed; code $?"
    fi
  fi

  if [[ "$is_dev_extant" == "$docker_tag"  ]]; then
    echo -e "Building $docker_tag as an ephemeral dev env in $(pwd)...\n"
    docker run --rm -it -v "$(pwd):/ephemeral" "$docker_tag"
  fi
}

# initialize a new project of type $1
bootstrap () {
  local script_loc="$HOME/.bash_conf/scripts/bootstrap.bash"

  if (( $# == 0 )); then
    echo -e "[!] No arguments supplied\n"
  else
    bash $script_loc "$*"
  fi
}

# set current branch to track remote (default: 'origin')
gtrack () {
  local remote="$1"

  git branch -u "${remote:-origin}/$(git rev-parse --abbrev-ref HEAD)"
}
