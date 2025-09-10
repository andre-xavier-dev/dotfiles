#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt
PS1='\[\e[95;1m\]❯ \[\e[0m\]'

# bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# uv bash completion
. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion bash)"
