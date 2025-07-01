export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

ZSH_CONFIG_DIR="$HOME/dotfiles/zsh"

for file in "$ZSH_CONFIG_DIR"/*.zsh; do
  [[ "$file" != "$ZSH_CONFIG_DIR/.zshrc" && -f "$file" ]] && source "$file"
done

eval "$(starship init zsh)"