[[ $- != *i* ]] && return # If not running interactively, don't do anything

.reload_interactive_config() {
	. "$HOME/.zshrc"
}

# Ensure zplug is installed
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

.reload_interactive_extensions sh
.reload_interactive_extensions zsh

# Completions menu and some command validation while typing
zstyle ':completion:*' menu select
zplug "zdharma/fast-syntax-highlighting"
setopt correct
__git_files () {
    _wanted files expl 'local files' _files
}

# Nicer file management
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

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
