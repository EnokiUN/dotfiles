if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(starship init zsh)"

zstyle ':omz:update' mode reminder

ENABLE_CORRECTION="true"
plugins=(git sudo pip colored-man-pages command-not-found zsh-autosuggestions zsh-syntax-highlighting docker docker-compose rust kubectl minikube)
source $ZSH/oh-my-zsh.sh

source /usr/share/nvm/init-nvm.sh


eval "$(zoxide init zsh)"

function proj () {
  cd ~/Projects/$1
}

export EDITOR='neovide --nofork'
export PATH="$HOME/.local/bin:$PATH"

### ALIASES ###
alias zr='source ~/.zshrc'
alias vim='neovide --multigrid'
alias py='python3'
alias sysstart='sudo systemctl start'
alias :wq='exit'
autoload -Uz tetriscurses
alias tetris="tetriscurses"
alias notes='cd ~/Notes && git pull && nvim . && git add . && git commit -m "notes" && git push && cd -'
alias '$'='' # Olivier, behold 0.001% of my power.
alias '!'='t2eb'
alias ff='firefox-developer-edition'
alias dupe='alacritty --working-directory . & disown'

if [ "$(command -v exa)" ]; then
  unalias -m ll
  alias ll='exa -1FTrls name --color always --git --icons --level=1'
  alias ll2='exa -1FTrls name --color always --git --icons --level=2'
  alias ll3='exa -1FTrls name --color always --git --icons --level=3'
  alias ll4='exa -1FTrls name --color always --git --icons --level=4'
  unalias -m la
  alias la='exa -1FTrlas name --color always --git --icons --level=1'
  alias la2='exa -1FTrlas name --color always --git --icons --level=2'
  alias la3='exa -1FTrlas name --color always --git --icons --level=3'
  alias la4='exa -1FTrlas name --color always --git --icons --level=4'
  unalias -m ls
  alias ls='exa -GFrs name --color always --git --icons'
fi

if [ "$(command -v bat)" ]; then
  unalias -m cat
  alias cat='bat --color=always'
fi

set -o vi

echo
neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# pnpm
export PNPM_HOME="/home/enoki/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
