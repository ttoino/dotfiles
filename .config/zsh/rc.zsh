export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Function to source files if they exist
function zsh_add_file() {
    if [[ $1 =~ ^/ ]]; then
        FILE_NAME="$1"
    else
        FILE_NAME="$ZDOTDIR/$1"
    fi
    set --
    [ -f $FILE_NAME ] && source "$FILE_NAME"
}

function zsh_add_plugin() {
    PLUGIN_NAME=${2:-$(echo $1 | cut -d "/" -f 2)}
    if [ ! -e "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi

    # For plugins
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" ||
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
}

function zsh_update_plugins() {
    for i in "$ZDOTDIR"/plugins/*; do
        PLUGIN_NAME="${i#$ZDOTDIR/plugins/}"
        echo "$PLUGIN_NAME"
        if [[ -d $i ]]; then
            git -C "$i" pull

            zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" ||
                zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
        fi
    done

    reload_prompt
}

# Start ssh agent
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent >|"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Other files
# Custom prompt
zsh_add_file "prompt.zsh"
# Usefull aliases
zsh_add_file "aliases.zsh"
# Usefull keybindings
zsh_add_file "keybinds.zsh"
# Usefull exports
zsh_add_file "exports.zsh"
# ZSH options
zsh_add_file "options.zsh"
# ZSH completion
zsh_add_file "completion.zsh"

# Plugins
# Usefull git aliases
zsh_add_plugin "davidde/git"
# Add color to man pages
zsh_add_plugin "ael-code/zsh-colored-man-pages" "colored-man-pages"
# Add syntax highlighting
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
# asdf
zsh_add_file "/opt/asdf-vm/asdf.sh"
# fnm
eval "$(fnm env --use-on-cd)"
