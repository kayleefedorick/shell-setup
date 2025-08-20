# Show user/host name
export SHOW_USER=true
if [[ "$SHOW_USER" == "true" ]]; then
  RPROMPT="%F{cyan}(%F{green}%n%F{cyan}@%F{yellow}%m%F{cyan})"
fi

# Default user
export DEFAULT_USER="kaylee"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"

# oh-my-zsh-custom / mouse.zsh
# Mapped to Esc-1
. /$HOME/.shell/mouse.zsh
bindkey -M emacs '\e1' zle-toggle-mouse

# Plugins
plugins=(
	git
	command-not-found
	copyfile
	copypath
	history-substring-search
	web-search
	thefuck
	you-should-use
	zsh-bat
	extract
	sudo
)

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

source $ZSH/oh-my-zsh.sh

# Syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ls='eza --icons'
alias tree='eza -la --icons --tree --total-size --hyperlink'
alias du='dust -r'
eval $(thefuck --alias)
alias howdoi='~/howdoi.sh'
alias howdoi-windows='~/howdoi-windows.sh'

# erase command - remove the last x lines of output
erase(){
	local lines=${1:-10}    # default 10 lines
	tput cuu $lines; tput ed
}
