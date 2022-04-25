# Ctrl + arrows to go back/forward word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
# Ctrl + backspace/del to remove word
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
# Shift + Tab goes back in menu
bindkey "^[[Z" reverse-menu-complete
