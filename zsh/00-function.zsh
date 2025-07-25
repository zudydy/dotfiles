autoload -U add-zsh-hook

load-nvmrc() {
  if [ ! -f ".nvmrc" ]; then
    return 0
  fi

  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ssh add
function add_ssh_keys {
  ALM_DIR="/Users/julyy/Documents/GitHub_AlmSmartDoctor"
  CASHDOC_DIR="/Users/julyy/Documents/GitHub_Cashdoc"
  JULYY_DIR="/Users/julyy/Documents/GitHub"

  if [[ "$(pwd)" == "$ALM_DIR"* ]]; then
    ssh-add --apple-use-keychain ~/.ssh/id_rsa_julyy
  elif [[ "$(pwd)" == "$CASHDOC_DIR"* ]]; then
    ssh-add --apple-use-keychain ~/.ssh/id_rsa_cashdoc
  elif [[ "$(pwd)" == "$JULYY_DIR"* ]]; then
    ssh-add --apple-use-keychain ~/.ssh/id_rsa_julyy
  fi
}

function chpwd {
  add_ssh_keys
}

add_ssh_keys