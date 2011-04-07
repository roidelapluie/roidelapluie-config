# Don't run anything here unless we have an interactive shell.
if [[ $- != *i* ]] ; then
    return
fi

# Set maximum history limit
export HISTSIZE=10000

# Set up the prompt

last_command_result_color()
{
if [ $? -eq 0 ];
    then echo 32;
    else echo 31;
fi
}

export PROMPT_COMMAND="PROMPT_COLOR=`last_command_result_color`"

if [ $UID -eq 0 ]; then
	PROMPT_COLOR2=41
else
PROMPT_COLOR2=44
fi

PS1="\[\e[1;${PROMPT_COLOR2}m\] \h \[\e[0m\]"
PS1="$PS1 \w\n\[\e[0;\${PROMPT_COLOR}m\]>\[\e[0m\] "

# Aliases
alias srv01='ssh -i ~/.vm/id_rsa root@srv01'
