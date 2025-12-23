autoload -U add-zsh-hook

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