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

show_git_branch() {
	branch=$(git branch 2>/dev/null | grep '^*' | cut -d' ' -f 2-)
	if [ -n "$branch" ]; then
		echo -en ' \e[1;30;47m '$branch' \e[0m '
		[ "$(git status -s|wc -l)" -gt 0 ] && echo -e '\e[1;40;37m '$(git status -s| awk '{print $1}'|sort|uniq -c|xargs -I% echo %)' \e[0m '
	fi
}
show_real_pwd() {
	if [ "$(pwd)" != "$(pwd -P)" ]; then
		echo " ($(pwd -P))"
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
err=\$?
if [ \$err -eq 0 ];
    then
    	PROMPT_COLOR='0;32'; 
	ERR='';
    else
    	PROMPT_COLOR='0;31';
	ERR=\" \$(echo -e \"\e[1;41m \$err \e[0m\")\"
fi
"

if [ $UID -eq 0 ]; then
	PROMPT_COLOR2="1;41"
else
	PROMPT_COLOR2="1;44"
fi

PS1="\[\e[${PROMPT_COLOR2}m\] \h \[\e[0m\]"
PS1="$PS1 \[\$(pwd_real)\]\w\[\e[0m\]\$(show_real_pwd)\$(show_git_branch)\$ERR\n\[\e[\${PROMPT_COLOR}m\]\#>\[\e[0m\] "

# Aliases
alias gp='git push'
alias gpl='git pull --rebase'
alias tg='tig status'
alias speedtest="wget --quiet speedtest.edpnet.be/speedtest4.php -O - | grep -o 'Your BandWidth [0-9][^)]*)' | cat"

# vars
export HISTSIZE=10000
export CAVE_RESOLVE_OPTIONS="--recommendations display"
export INPUTRC="~/.inputrc.roidelapluie"

# Options
shopt -s no_empty_cmd_completion
