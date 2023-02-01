# ls
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lhA'

# misc
alias q='exit'
alias rr='source $ZDOTDIR/rc.zsh'
alias pd='popd'
alias aocm='~/Documents/projects/advent-of-code-manager/main.py'

function mkcd() {
    mkdir $1 && cd $1
}

# prolog is weird
alias sp='/usr/local/sicstus4.7.1/bin/sicstus'
