SETTINGS_DIR="$HOME/.bash_conf/settings"

# source env
source "$SETTINGS_DIR/env.bash"

# source configs
source "$SETTINGS_DIR/cmd.bash"
# source aliases
source "$SETTINGS_DIR/alias.bash"

if [[ $- == *i* ]]; then
  source "$SETTINGS_DIR/interactive.bash"
  source "$SETTINGS_DIR/login.bash"
fi

unset -v SETTINGS_DIR
