if [[ $TTY == '/dev/tty'* ]]; then
    local GIT='git'
else
    local GIT='󰘬'
fi

# Add gitstatus to right prompt (icons depend on TTY)
local GITSTATUS='GITSTATUS_PROMPT'
# Remove first color code
GITSTATUS='${'$GITSTATUS'#\%76F}'
# Replace hardcoded colors with zsh color codes
GITSTATUS='${'$GITSTATUS'//\%76F/%F{green\}}'
GITSTATUS='${'$GITSTATUS'//\%178F/%F{yellow\}}'
GITSTATUS='${'$GITSTATUS'//\%39F/%F{blue\}}'
GITSTATUS='${'$GITSTATUS'//\%196F/%F{red\}}'
RPROMPT+='${GITSTATUS_PROMPT:+ %F{magenta\}'$GIT'  '$GITSTATUS'}'

unset GIT GITSTATUS
