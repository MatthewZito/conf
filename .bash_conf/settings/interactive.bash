# prevent duplicate lines; lines space-prepended in hist
HISTCONTROL=ignoreboth

# append to hist; don't overwrite
shopt -s histappend

# set hist len
HISTSIZE=1000
HISTFILESIZE=2000

# eval window size after ea cmd and recalibrate if needed
shopt -s checkwinsize

shopt -s globstar

# prettify less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# bash completion on
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
