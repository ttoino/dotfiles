[[ -n "$_ZSH_FUNCS_LOADED" ]] && return
_ZSH_FUNCS_LOADED=1

function mkcd() {
    mkdir "$1" && cd "$1"
}
