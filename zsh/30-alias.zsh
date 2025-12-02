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