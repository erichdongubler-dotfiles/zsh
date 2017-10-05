[[ $- != *i* ]] && return # If not running interactively, don't do anything

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    . ~/.zplug/init.zsh && zplug update --self
else
    . ~/.zplug/init.zsh
fi

# Make zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# `compinit` should be one of the first things here
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

.reload_scripts zsh

.reload() {
	. ~/.zshrc
}

# Custom keybinds
#   History search
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# FIXME: These could maybe use zkbd or terminfo? Is it slow, maybe?
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1~" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[F" end-of-line
bindkey "^[[H" beginning-of-line
#   Make Alt-Backspace delete words, as opopsed to Ctrl-W's Words (think Vim)
backward-kill-dir () {
    local WORDCHARS="${WORDCHARS:s#/#}"
    local WORDCHARS="${WORDCHARS:s#\.#}"
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir
#   Enable the emacs mode editor shortcut
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
#   Do open/close delimiter completion
zplug "hlissner/zsh-autopair", defer:1

# Completions menu and some command validation while typing
zstyle ':completion:*' menu select
zplug "zdharma/fast-syntax-highlighting"

# Nicer file management
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zplug "supercrabtree/k"
alias ll="k"

autoload -U colors && colors
setopt PROMPT_SUBST
export __ps1_path="%{%B%F{blue}%}%(4~|%-1~/…/%2~|%3~)"
export __ps1_dollar="%{%(?.%F{green}.%F{yellow})%}$"
function __ps1_git() {
	local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	if [[ $git_branch ]]; then
		echo " %{%F{red}%}$git_branch";
	fi
}
export __ps1_reset_color="%{%B$reset_color%}"
export PS1=$'\n'"$__ps1_path"'$(__ps1_git)'"$__ps1_dollar$__ps1_reset_color "

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
