# Ctrl + arrows to go back/forward word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
# Ctrl + backspace/del to remove word
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
# Shift + Tab goes back in menu
bindkey "^[[Z" reverse-menu-complete
# Up and Down search through history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search   # Up
bindkey "^[[B" down-line-or-beginning-search # Down
