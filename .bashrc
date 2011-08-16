# Don't run anything here unless we have an interactive shell.
if [[ $- != *i* ]] ; then
    return
fi

# Prevent usage of su instead of su -
if [ "$(tr "\0" " " < /proc/$PPID/cmdline)" == "su " ]; then 
	export TMOUT=10
	echo -e "\e[1;41mPlease use \e[4msu -\e[0m"
fi

# Functions
repo() {
	cave resolve -x repository/$1
}

pwd_real() {
	if [ "$(pwd)" != "$(pwd -P)" ]; then
		echo -e "\e[4m"
	fi
}

show_real_pwd() {
	if [ "$(pwd)" != "$(pwd -P)" ]; then
		echo " ($(readlink $PWD))"
	fi
}

root() {
	ssh root@$1 -t bash --rcfile /home/roidelapluie/roidelapluie-config/.bashrc
}

update_bashrc() {
	cd /home/roidelapluie/roidelapluie-config/
	git pull
	cd -
}

# Prompt
export PROMPT_COMMAND="
if [ \$? -eq 0 ];
    then PROMPT_COLOR='0;32'; 
    else PROMPT_COLOR='0;31'; 
fi
"

if [ $UID -eq 0 ]; then
	PROMPT_COLOR2="1;41"
else
	PROMPT_COLOR2="1;44"
fi

PS1="\[\e[${PROMPT_COLOR2}m\] \h \[\e[0m\]"
PS1="$PS1 \[\$(pwd_real)\]\w\[\e[0m\]\$(show_real_pwd)\n\[\e[\${PROMPT_COLOR}m\]\#>\[\e[0m\] "

# Aliases
alias gp='git push'
alias gpl='git pull --rebase'
alias tg='tig status'

# vars
export HISTSIZE=10000
export CAVE_RESOLVE_OPTIONS="--recommendations display"
export INPUTRC="~/.inputrc.roidelapluie"

# Options
shopt -s no_empty_cmd_completion
