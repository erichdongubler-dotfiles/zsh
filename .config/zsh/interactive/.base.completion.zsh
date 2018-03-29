zstyle ':completion:*' menu select
zplug "zdharma/fast-syntax-highlighting"
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
setopt correct
__git_files () {
    _wanted files expl 'local files' _files
}
