# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%B%p%b'
zstyle :compinstall filename '/home/toino/.config/zsh/completion.zsh'

autoload -Uz compinit
compinit
# End of lines added by compinstall
