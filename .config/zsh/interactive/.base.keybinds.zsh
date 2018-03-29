# Better vi mode
export KEYTIMEOUT=1
#   Change cursor shape depending on the mode
function zle-keymap-select zle-line-init
{
    case $KEYMAP in
        vicmd)
        echo -ne "\e[1 q" # Blinking I-beam
        ;;
    viins|main)
        echo -ne "\e[5 q" # Blinking block
        ;;
    esac

    zle reset-prompt
    zle -R
}
function zle-line-finish
{
    echo -ne "\e[2 q" # Steady block
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
#   Better searching in command mode
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[F" end-of-line
bindkey "^[[H" beginning-of-line
bindkey -M vicmd "^[[1;5C" forward-word
bindkey -M vicmd "^[[1;5D" backward-word
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[[F" end-of-line
bindkey -M vicmd "^[[H" beginning-of-line
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M vicmd '?' history-incremental-search-backward
# Make Ctrl-W better
backward-kill-dir () {
    local WORDCHARS="${WORDCHARS:s#/#}"
    local WORDCHARS="${WORDCHARS:s#\.#}"
    local WORDCHARS="${WORDCHARS:-}"
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^W' backward-kill-dir
#   Add more text objects
autoload -U select-bracketed select-quoted
zle -N select-bracketed
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done
