plugins=(
	fzf
	fzf-tab
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-hangul
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh