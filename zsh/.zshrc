# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

ZSH_CONFIG_DIR="$HOME/dotfiles/zsh"

for file in "$ZSH_CONFIG_DIR"/*.zsh; do
  [[ "$file" != "$ZSH_CONFIG_DIR/.zshrc" && -f "$file" ]] && source "$file"
done

eval "$(starship init zsh)"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
