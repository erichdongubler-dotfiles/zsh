# FIXME: These could maybe use zkbd or terminfo? Is it slow, maybe?
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1~" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[[F" end-of-line
bindkey "^[[H" beginning-of-line
#   Make Alt-Backspace delete words, as opposed to Ctrl-W's Words (think Vim)
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
