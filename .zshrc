. "$XDG_CONFIG_HOME/sh/common.sh"

nonomatch() {
    setopt localoptions
    unsetopt nomatch
    "$@"
}

if [[ $- == *l* ]]; then
    .login
    nonomatch .reload_login_extensions sh zsh
fi

[[ $- != *i* ]] && return

ZPLUG_HOME="$XDG_CACHE_HOME/zplug"

ZPLUG_BIN="$ZPLUG_HOME/bin"
ZPLUG_CACHE_DIR="$ZPLUG_HOME/cache_dir"
ZPLUG_REPOS="$ZPLUG_HOME/repos"

if [[ ! -d "$ZPLUG_HOME" ]]; then
    git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
    . "$ZPLUG_HOME"/init.zsh && zplug update
else
    . "$ZPLUG_HOME"/init.zsh
fi
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

setopt PROMPT_SUBST # XXX: Any way to move this into .prompt.zsh?

nonomatch .reload_interactive_extensions sh zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
