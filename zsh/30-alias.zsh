alias cl="clear"
alias finder="open -a Finder ."
alias f="open -a Finder ."

# .zshrc
alias zr="nvim ~/.zshrc"
alias zs="source ~/.zshrc"

# git
alias gs="git status"
alias glf="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
alias wip="git add . && git commit -m "wip""
alias unwip="git reset --soft HEAD^"
alias gsm="git switch main"
alias gsd="git switch develop"
alias gsq="git switch qa"
alias gsr="git switch release/CSRV-1225-cashwalk-cashreview-renewal"
alias gcm="git commit -m"
alias gbb="git branch --sort=-committerdate \
  --format='%(if)%(HEAD)%(then)* %(color:green)%(committerdate:relative) - %(refname:short)%(color:reset)%(else)  %(committerdate:relative) - %(refname:short)%(end)'"

gwp() {
  emulate -L zsh
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "Not a git repo"; return 1; }

  local picked branch fmt
  fmt=$'%(if)%(HEAD)%(then)%(color:green)* %(align:14,left)%(committerdate:relative)%(end)  %(refname:short)%(color:reset)%(else)  %(align:14,left)%(committerdate:relative)%(end)  %(refname:short)%(end)\x1f%(refname:short)'

  picked=$(
    git for-each-ref --color=always refs/heads \
      --sort=-committerdate \
      --format="$fmt" |
    fzf --ansi \
        --prompt='switch> ' \
        --delimiter=$'\x1f' \
        --with-nth=1 \
        --no-sort \
        --preview='b=$(printf "%s" {} | cut -d $'\''\x1f'\'' -f2); git log "$b" -n 50 --oneline --color=always' \
        --preview-window='right:55%:wrap'
  ) || return 1

  branch=$(printf '%s' "$picked" | cut -d $'\x1f' -f2)
  [[ -n "$branch" ]] || return 1

  git switch "$branch"
}

# logo-ls
alias ls="logo-ls"
alias la="logo-ls -A"
alias ll="logo-ls -lh"
alias lla="logo-ls -lhA"

# warp directory
alias wd='cd_warp'
cd_warp() {
    case "$1" in
		"")
			cd ~
			;;
        "gh")
            cd ~/Documents/GitHub
            ;;
        "work")
            cd ~/Documents/GitHub_AlmSmartDoctor
            ;;
		"local")
			cd ~/Development/Local
			;;
        *)
            echo "알 수 없는 목적지입니다. 가능한 옵션: gh, work, local"
            ;;
    esac
}

# GitHub
alias npr="gh pr create --web"