# ls
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

# misc
alias q='exit'
alias pd='popd'

function mkcd() {
    mkdir $1 && cd $1
}
