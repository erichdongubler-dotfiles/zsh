. "$XDG_CONFIG_HOME/sh/common.sh"

if [[ $- == *l* ]]; then
    .login
    setopt local_options nomatch
    .reload_login_extensions sh zsh
fi

[[ $- != *i* ]] && return

if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    . ~/.zplug/init.zsh && zplug update --self
else
    . ~/.zplug/init.zsh
fi
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

setopt PROMPT_SUBST # XXX: Any way to move this into .prompt.zsh?

.reload_interactive_extensions sh zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
