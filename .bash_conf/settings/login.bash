##################
##  launch fns  ##
##################

# auto-launch shell as tmux session 
__default_to_tmux () {
  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
  fi
}

# base16 shell
__use_base16_shell () {
  BASE16_SHELL="$HOME/.config/base16-shell/"
  [ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"
}

# get current branch in git repo
parse_git_branch () {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
parse_git_dirty () {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

##################
##  login init  ##
##################

# remap caps -> super
setxkbmap -option caps:super 2>/dev/null

# LSCOLORS config
if [[ -e ~/.dir_colors/dircolors ]]; then
  eval `dircolors "$HOME/.dir_colors/goldmund.dircolors"`
fi

# GCC color config
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# prompts
export PS1="\[\e[36m\]\u\[\e[m\]\[\e[35m\]:\[\e[m\]\[\e[35m\]:\[\e[m\]\[\e[32m\]\w\[\e[m\]\[\e[35m\]:\[\e[m\]\[\e[35m\]:\[\e[m\]\[\e[34m\]\`parse_git_branch\`\[\e[m\]\[\e[33m\]>\[\e[m\]\[\e[31m\]>\[\e[m\]\[\e[36m\]>\[\e[m\] "
export PS2="\[$(tput setaf 3)\]continue-->\[\e[m\] "
