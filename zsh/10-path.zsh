typeset -U path  # 중복 제거

path=(
  /opt/homebrew/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /Applications/WebStorm.app/Contents/MacOS
  /Users/jaeyeong/.codeium/windsurf/biㅂn
  /Users/jaeyeong/Library/pnpm
  $path  # 기존 path 유지
)

export PATH

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
