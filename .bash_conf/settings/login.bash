 _update_ps1 () {
  local _SETTINGS_DIR="$HOME/.bash_conf/apps/powerline"

  PS1="$($HOME/go/bin/powerline-go -theme $_SETTINGS_DIR/theme.json -hostname-only-if-ssh -error $? -jobs $(jobs -p | wc -l))"  
}

# auto-launch shell as tmux session 
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# remap caps -> super
setxkbmap -option caps:super 2>/dev/null

# LSCOLORS config
if [[ -e ~/.dir_colors/dircolors ]]; then
  eval `dircolors "$HOME/.dir_colors/goldmund.dircolors"`
fi

# # base16 shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
# [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
# eval "$("$BASE16_SHELL/profile_helper.sh")"

# GCC color config
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# powerline-go init
if [ "$TERM" != "linux" ] && [ -f "$HOME/go/bin/powerline-go" ]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# prompts
export PS2="\[$(tput setaf 3)\]continue-->\[\e[m\] "
