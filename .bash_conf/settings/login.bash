 _update_ps1 () {
  local _SETTINGS_DIR="$HOME/.bash_conf/apps/powerline"
  PS1="$($HOME/go/bin/powerline-go -theme $_SETTINGS_DIR/theme.json -hostname-only-if-ssh -error $? -jobs $(jobs -p | wc -l))"
  
  # Uncomment the following line to automatically clear errors after showing
  # them once. This not only clears the error for powerline-go, but also for
  # everything else you run in that shell. Don't enable this if you're not
  # sure this is what you want.
  #set "?"
}


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
