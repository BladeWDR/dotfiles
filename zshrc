# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
HISTORY_IGNORE='(pwd|exit|fg|bg|top|clear|history|ls|uptime|df)'

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Prevent ranger from loading it's default config.
export RANGER_LOAD_DEFAULT_RC=FALSE


# configure PATH
setopt extended_glob null_glob

path=(
    $path
    /var/lib/flatpak/exports/bin
    $HOME/.local/share/flatpak/exports/bin
    $HOME/.local/bin
    $HOME/.local/scripts
)

# remove duplicate entries from PATH.
typeset -U path
# exclude any directories that don't exist.
path=($^path(N-/))

# finally, set the PATH. Remember that there is a special relationship in zsh
# between $PATH and $path, which allows you to do to this.
export PATH

# Set env variable for GPG
GPG_TTY=$(tty)
export GPG_TTY

# enable vi mode
bindkey -v
export KEYTIMEOUT=1

# Source browser settings if file exists
[ -f ~/.browser ] && source ~/.browser

export TERM=tmux-256color

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Load aliases and shortcuts if existent.
[ -f "$HOME/aliasrc" ] && source "$HOME/aliasrc"


#change ZSH autosuggest highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=006'
# Set ctrl+space to accept suggestion.
bindkey '^ ' autosuggest-accept

# Start hook for direnv
eval "$(direnv hook zsh)"

bindkey -s '^f' "tmux-sessionizer\n"

# pacman and apt put these in 2 different locations 
# so I need to figure out which one to load depending on what OS I'm currently using.

# Arch / Pacman
if [[ -d /usr/share/zsh/plugins ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Ubuntu / APT
elif [[ -d /usr/share/zsh-autosuggestions ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fi

if which starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

if [ -d /home/linuxbrew/ ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Set EDITOR.
# Do this AFTER loading brew vars, since it's installed via homebrew now on a lot of my systems.
if command -v nvim >/dev/null; then
    export EDITOR=$(which nvim)
else
    export EDITOR=/usr/bin/vim
fi

# Set up fzf key bindings and fuzzy completion
if [ -f /home/linuxbrew/.linuxbrew/bin/fzf ] || [ -f /usr/bin/fzf ]; then
    source <(fzf --zsh)
fi

# Use zoxide and eza if available.
if [ -f /home/linuxbrew/.linuxbrew/bin/zoxide ] || [ -f /usr/bin/zoxide ]; then
    eval "$(zoxide init zsh --cmd cd)"
fi

if [ -f /home/linuxbrew/.linuxbrew/bin/eza ] || [ -f /usr/local/bin/eza ]; then
    alias ls='eza -l'
fi
