# Freeze and unfreeze processes (for example: stop firefox)
stop() {
    if [ $# -ne 1 ]; then
        echo 1>&2 Usage: stop process
    else
        PROCESS=$1
        echo "Stopping processes with the word ${tGreen}$1${tReset}"
        ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -STOP
    fi
}

cont() {
    if [ $# -ne 1 ]; then
        echo 1>&2 Usage: cont process
    else
        PROCESS=$1
        echo "Continuing processes with the word ${tGreen}$1${tReset}"
        ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -CONT
    fi
}

source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/rc.zsh"
