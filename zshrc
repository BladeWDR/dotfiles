neofetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Dependencies You Need for this Config
# zsh-syntax-highlighting - syntax highlighting for ZSH in standard repos
# autojump - jump to directories with j or jc for child or jo to open in file manager
# zsh-autosuggestions - Suggestions based on your history

# Initial Setup
# touch "$HOME/.cache/zshhistory
# Setup Alias in $HOME/zsh/aliasrc
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

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

bindkey -s ^f "tmux-sessionizer\n"

# Load ; should be last.
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/powerlevel10k/powerlevel10k.zsh-theme
