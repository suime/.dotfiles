if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/gcc:$HOME/.nix-profile/bin:$PATH
export fpath=($HOME/.dotfiles/zsh:$fpath)
export LC_ALL=ko_KR.UTF-8

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX="true"


# 외장 usb 경로
export USB="/volumeUSB1/usbshare/"


function mkcd() {
  mkdir $1
  cd $1
}

function cnt() {
    count=$(find . -maxdepth 1 -type f | wc -l) 
    echo "현재 폴더의 파일 개수: $count"
}

# .DAV 폴더 및 .trash 폴더 재귀 삭제 함수 (기본 경로: ~/01_노트)
function davclean() {
    local target_path=${1:-~/01_노트}  # 기본 경로 설정

    echo "다음 경로에서 ._DAV, @eaDir, .trash 폴더를 삭제합니다: $target_path"

    # 삭제할 디렉토리 패턴 목록
    local patterns=("._DAV" "@eaDir" "\.trash")

    for pattern in "${patterns[@]}"; do
        fd -t d -I -H -c never "$pattern" "$target_path" | while read -r dir; do
            rm -rf "$dir"
            echo "삭제됨: $dir"
        done
    done

    echo "모든 지정된 폴더 삭제 완료!"
}


plugins=(
    git
    zsh-navigation-tools
    zsh-interactive-cd
    fzf
    zsh-syntax-highlighting
    zsh-autosuggestions
    zoxide
    zsh-hangul
 )

source $ZSH/oh-my-zsh.sh



# Example aliases
alias zshconfig="cd ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias cls="clear"
alias re="source ~/.zshrc"
alias ep="vim ~/.zshrc"

# 파이썬 관련 
alias python="/usr/local/bin/python3.10"
alias pip="/usr/local/bin/python3.10 -m pip"

# 경로 관련 
alias cdd="cd ~/downloads"
alias cdh="cd /volume1/homes"
alias cd-note="cd ~/01_노트"
alias cd-data="cd /volume1/homes/박진수/DB\ 폴더"

# fd 
alias fd="fd -E '*@eaDir*' -H"
# alias fd="fd"

# yazi
alias yz="yazi"

# nix 
function nix_install(){
    nix-env -iA nixpkgs.$1
}
function nix_search(){
    nix --extra-experimental-features "nix-command flakes" search nixpkgs $1
}
alias nix="nix --extra-experimental-features nix-command --extra-experimental-features flakes"
alias ni="nix_install"
alias ns="nix_search"
zle -N cls
zle -N re
bindkey '^[l' cls
bindkey '^[r' re
# eza 
alias ls="eza --icons=always --hyperlink -w=80 --ignore-glob=@eaDir"
alias ll="eza -l --icons=always --hyperlink -a -h --no-permissions --no-user --ignore-glob=@eaDir \
--time-style='+%Y.%m.%d %H:%M' --group-directories-first --color-scale=all --color-scale-mode=gradient"
alias ld="eza -l --icons=always --hyperlink -a -D -h --no-permissions --no-user --ignore-glob=@eaDir --time-style='+%Y.%m.%d %H:%M'"
alias lf="eza -l --icons=always --hyperlink -a -f -h --no-permissions --no-user --time-style='+%Y.%m.%d %H:%M'"
alias lt="eza -T --icons=always --hyperlink --level=2"

export FZF_BASE="~/.oh-my-zsh"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {} | head -200'"

source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.oh-my-zsh/.p10k.zsh ]] || source ~/.oh-my-zsh/.p10k.zsh
[ -f ~/.oh-my-zsh/.fzf.zsh ] && source ~/.oh-my-zsh/.fzf.zsh

source /var/services/homes/qkqxk500/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /var/services/homes/qkqxk500/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# eval "$(zoxide init zsh)"