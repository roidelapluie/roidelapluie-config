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

# Prompt
export PROMPT_COMMAND="
if [ \$? -eq 0 ];
    then PROMPT_COLOR=32; 
    else PROMPT_COLOR=31; 
fi
"

if [ $UID -eq 0 ]; then
	PROMPT_COLOR2=41
else
	PROMPT_COLOR2=44
fi

PS1="\[\e[1;${PROMPT_COLOR2}m\] \h \[\e[0m\]"
PS1="$PS1 \[\$(pwd_real)\]\w\[\e[0m\]\n\[\e[0;\${PROMPT_COLOR}m\]>\[\e[0m\] "

# Aliases
alias srv01='ssh -i ~/.vm/id_rsa root@srv01'

# vars
export HISTSIZE=10000
export CAVE_RESOLVE_OPTIONS="--recommendations display"


# Options
shopt -s no_empty_cmd_completion
