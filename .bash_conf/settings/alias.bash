# colorize
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# "alert" alias for long running commands. Usage:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# navigation
alias repos='cd ~/repositories'
alias docs='cd ~/Documents'
alias desktop='cd ~/Desktop'
alias open='xdg-open'

# purge bash hist
alias purgehist='cat /dev/null > ~/.bash_history'

# apps
alias vpn='expressvpn'

# git
alias gpull='git pull'
alias gpush='git push'
alias gaddall='git add .'
alias gswitch='git add . && git switch -c'
alias gstats='git status'
alias gsign='git commit -S'
alias gmaster='git checkout master'
alias gunstage='git reset'
alias gstash='git stash'

alias upgrade='sudo apt update && sudo apt upgrade'

# tracks dotfiles with bare git repository
alias dotfiles='/usr/bin/git --git-dir=/home/goldmund/.cfg/ --work-tree=/home/goldmund'

# generated
alias exercises='cd snap/exercism/5/exercism/'
