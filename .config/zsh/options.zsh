# man zshoptions

# Changing Directories
setopt auto_cd       # cd automatically
setopt auto_pushd    # pushd automatically
setopt pushd_silent  # pushd and pop do not print directory
setopt pushd_to_home # pushd with no arguments pushes home

# Completion
setopt auto_param_slash  # Add a slash after directories
setopt auto_remove_slash # Remove slash from directories when not needed
setopt menu_complete     # Show completions in a menu

# Expansion and Globbing
setopt extended_glob # Use '#', '~', and '^'
setopt nomatch       # Print error when no match is found

# History
setopt append_history # Append history, don't replace

# Initialisation

# Input/Output
setopt clobber              # > and >> work
setopt correct              # try to correct spelling mistakes
setopt interactive_comments # Allow comments

# Job Control

# Prompting

# Scripts and Functions
setopt C_PRECEDENCES # Make arithmetic evaluation more sane

# Shell Emulation

# Shell State

# Zle
setopt COMBINING_CHARS # Modern terminals handle unicode right

# Others

stty stop undef              # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none') # Disable copy paste highlighting

# This causes pasted URLs to be automatically escaped, without needing to disable globbing.
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
