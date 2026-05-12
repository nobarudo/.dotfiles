# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################################################################
#  環境設定
################################################################
export LANG=ja_JP.UTF-8
export TERM=screen-256color
autoload -Uz compinit
compinit

autoload -U colors
colors

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt share_history
setopt auto_param_slash
setopt mark_dirs
setopt no_beep
setopt correct
setopt list_types
setopt no_flow_control



################################################################
#  エイリアス
################################################################

alias ls='ls --color=auto -F'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -lA'
alias cp='cp -i'
alias rm='rm -i'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%C(yellow)%d%Creset'"
alias gs="git status"
alias gd="git diff"
alias gin="git init"
alias ga="git add"
alias v="nvim"

################################################################
#  プロンプト
################################################################

source ~/.zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function cd() {
  builtin cd $@ && ls;
}

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

eval "$(~/homebrew/bin/brew shellenv)"
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.nodebrew/current/bin:$PATH
