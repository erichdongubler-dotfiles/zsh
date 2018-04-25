export HISTFILE="$XDG_CACHE_HOME/zsh/histfile"

alias ll='ls -l --color=auto --time-style='"'+%d-%m-%Y %H:%M:%S'"

zplug "${0:a:h}/zsh", use:"keybinds-vi.zsh", from:local
zplug "hlissner/zsh-autopair", use:"autopair.zsh", defer:2

zplug "${0:a:h}/zsh", use:"prompt.zsh", from:local
zstyle ':completion:*' menu select
zplug "zdharma/fast-syntax-highlighting", defer:2
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
setopt correct
__git_files () {
    _wanted files expl 'local files' _files
}

export _FASD_DATA="$XDG_CACHE_HOME/fasd"
zplug "clvv/fasd", as:command, depth:1, use:fasd, hook-load:'eval \"\$(fasd --init auto)\" > /dev/null'
. "${0:a:h}/zsh/git.zsh"
