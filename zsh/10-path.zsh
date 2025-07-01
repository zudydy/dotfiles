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
