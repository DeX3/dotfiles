# 10 ms for key sequences
export DOTFILES_DIR=~/.dotfiles
export KEYTIMEOUT=1 
export PATH="$HOME/bin:/usr/local/bin:$DOTFILES_DIR/bin:$HOME/.fzf/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export LANG=en_US.UTF-8


bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history

bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^w' vi-backward-kill-word

bindkey '^r' history-incremental-search-backward

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '\e.' insert-last-word

autoload edit-command-line
zle -N edit-command-line

bindkey -a v begin-selection
bindkey -M vicmd v edit-command-line
bindkey '^X^E' edit-command-line

export EDITOR=nvim

alias vim=nvim
alias 'new-project'='tmuxifier ns'
alias 'edit-project'='tmuxifier es'
alias 'list-projects'='tmuxifier ls'
alias 'grep-projects'='tmuxifier ls | grep -i'
alias project='tmuxifier s'
alias gen='HYGEN_TMPLS=~/.dotfiles/hygen-templates npx hygen'

fpath=($fpath $DOTFILES_DIR/.zfunctions/)

autoload -U promptinit; promptinit
prompt pure

autoload -Uz compinit
compinit

autoload -U zcalc
autoload -Uz transfer

setopt histignorealldups    # ignore duplicates
setopt hist_ignore_space    # do not save commands starting with space to history
setopt inc_append_history
setopt share_history

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=$HOME/.zsh_history


export TMUXIFIER_LAYOUT_PATH="$DOTFILES_DIR/.tmux-layouts"
export PATH=$PATH:$DOTFILES_DIR/submodules/tmuxifier/bin
eval "$(tmuxifier init -)"
export TMUXIFIER_TMUX_OPTS=-2

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved ; then
  zgen load wbingli/zsh-wakatime
  zgen save
fi

killport() {
  pid=$(lsof -i :$1 | tail -n+2 | head -1 | awk '{ print $2 }')

  kill -9 $pid
}

encrypt-for() {
  b64=$(gpg -e --recipient $1 | base64)

  echo "Send this to $1:"
  echo "echo $b64 | base64 -D | gpg -d"
}

docker-cleanup() {
  docker rmi $(docker images -q -f dangling=true)
}

source ~/.dotfiles/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.dotfiles/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export YVM_DIR="$HOME/.yvm"
[ -s /usr/local/bin/yvm ] && source /usr/local/bin/yvm

export SNIPPET_DIR=~/.dotfiles/snippets
source ~/.dotfiles/snippets.sh

source ~/.dotfiles/remember.sh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

