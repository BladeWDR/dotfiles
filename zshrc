# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Custom Variables
EDITOR=nvim

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Custom ZSH Binds
bindkey -e #set emac keymap
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^H' backward-kill-word
bindkey '^A' beginning-of-line 
bindkey '^E' end-of-line
bindkey '^ ' autosuggest-accept
bindkey '^[[3~' delete-char

# Load aliases and shortcuts if existent.
[ -f "$HOME/aliasrc" ] && source "$HOME/aliasrc"


#change ZSH autosuggest highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=006'
#Set the Tab key to accept autocomplete suggestions.
#bindkey '^I' autosuggest-accept
# export TERM=xterm-256color


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add flatpak to PATH
PATH=$PATH:/var/lib/flatpak/exports/bin:~/.local/share/flatpak/exports/bin:/home/scott/.local/bin:/home/scott/.local/scripts
# Start hook for direnv
eval "$(direnv hook zsh)"

#export TERM=alacritty

if ! nvim --version &> /dev/null; then
  export EDITOR=/usr/bin/vim
else
  export EDITOR=/usr/bin/nvim
fi

# Prevent ranger from loading it's default config.
export RANGER_LOAD_DEFAULT_RC=FALSE

bindkey -s ^f "tmux-sessionizer\n"

# Check to see if there are updates to the dotfiles or nvim repositories.
BRANCH=master

if [ -d "$HOME/dotfiles" ]; then
    pushd "$HOME/dotfiles" > /dev/null
    git fetch &> /dev/null
    local_commit_dotfiles=$(git show --no-notes --format=format:"%H" $BRANCH | head -n 1)
    remote_commit_dotfiles=$(git show --no-notes --format=format:"%H" origin/$BRANCH | head -n 1)
    if [ $local_commit_dotfiles != $remote_commit_dotfiles ]; then
        echo 'dotfiles repository is out of date! Git pull to update.'
    fi
    popd > /dev/null
fi

if [ -d "$HOME/dotfiles/nvim" ]; then
    BRANCH=main
    pushd "$HOME/dotfiles/nvim" > /dev/null
    git fetch &> /dev/null
    local_commit_nvim=$(git show --no-notes --format=format:"%H" $BRANCH | head -n 1)
    remote_commit_nvim=$(git show --no-notes --format=format:"%H" origin/$BRANCH | head -n 1)
    if [ $local_commit_nvim != $remote_commit_nvim ]; then
        echo 'neovim repository is out of date! Git pull to update.'
    fi
    popd > /dev/null
fi

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

if which starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
