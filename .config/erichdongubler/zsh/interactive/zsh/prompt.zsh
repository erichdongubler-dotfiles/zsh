autoload -U colors && colors
export __ps1_path="%{%B%F{blue}%}%(4~|%-1~/…/%2~|%3~)"
export __ps1_dollar="%{%(?.%F{green}.%F{yellow})%}$"
__ps1_git() {
	local git_prompt=""
    local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    if [[ $git_branch ]]; then
        git_prompt=" %{%F{red}%}$git_branch";
        if [[ $VCSH_REPO_NAME ]]; then
        	git_prompt="$git_prompt (vcsh: $VCSH_REPO_NAME)"
        fi
    fi

	echo "$git_prompt"
}
export __ps1_reset_color="%{%B$reset_color%}"
export PS1=$'\n'"$__ps1_path"'$(__ps1_git)'"$__ps1_dollar$__ps1_reset_color "
