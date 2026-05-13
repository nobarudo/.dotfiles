################################################################
#  環境設定
################################################################
export LANG=ja_JP.UTF-8
autoload -Uz compinit
compinit

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

function cd() {
  builtin cd $@ && ls;
}

