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

SPROMPT="correct: %R -> %r ? [No/Yes/Abort/Edit]"

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..


## slarized
eval $(dircolors $HOME/.solarized/dircolors.256dark)

## set color when completion
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

################################################################
#  エイリアス
################################################################

alias ls='ls --color=auto -F'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -lA'
alias cp='cp -i'
alias rm='rm -i'
alias viewcolor='for c in {000..255}; do echo -n "[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done'
alias v='vim'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%C(yellow)%d%Creset'"
alias gs="git status"
alias gd="git diff"
alias gin="git init"
alias ga="git add"
alias gc="git commit -m"

################################################################
#  plugin
################################################################

source ~/.zplug/init.zsh

zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-autosuggestions'

if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

if zplug check zsh-users/zsh-autosuggestions; then
  bindkey '^[i' autosuggest-accept
  bindkey '^[m' autosuggest-execute
fi

################################################################
#  プロンプト
################################################################

# {と[の間に特殊文字を挿入
# 入力方法は<C-v><ESC>
HOST_COLOR='%{[38;5;054m%}'
MINT_GREEN='%{[38;5;047m%}'
YELLOW_COLOR='%{[38;5;011m%}'
reset='%{[0m%}'

autoload -Uz vcs_info
setopt prompt_subst
precmd() { vcs_info }
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

PROMPT="
[${MINT_GREEN}%n${reset_color}@${HOST_COLOR}%m${reset_color}] ${fg[red]}%D ${fg[blue]}%T "'${vcs_info_msg_0_}'" %{${YELLOW_COLOR}%}%~
%{${reset_color}%}--> "

# git関連
#RPROMPT=$'`branch-status-check`'
# 表示毎にPROMPTで設定されている文字列を評価する
# fg[color]表記と$reset_colorを使いたい
# @see https://wiki.archlinux.org/index.php/zsh
#function branch-status-check() {
#    local branchname suffix
#    # .gitの中だから除外
#    [[ '$PWD' =~ '/\.git(/.*)?$' ]] && return
#    branchname=`get-branch-name`
#    # ブランチ名が無いので除外
#    [[ -z $branchname ]] && return
#    suffix='%{'${reset_color}'%}'
#    echo `get-branch-status`${suffix}
#}
#function get-branch-name() {
#    local git==git
#    # gitディレクトリじゃない場合のエラーを捨てる
#    echo `${git} rev-parse --abbrev-ref HEAD 2> /dev/null`
#}
#function get-branch-status() {
#    local git==git branchstatus branchname
#    branchname=`get-branch-name`
#    output=`${git} status 2> /dev/null`
#    if [[ -n `echo $output | grep '^nothing to commit'` ]]; then
#        branchstatus='%{'${fg[green]}'%}%{'${fg[black]}${bg[green]}'%} \ue0a0 '${branchname}
#    elif [[ -n `echo $output | grep '^Untracked files:'` ]]; then
#        branchstatus='%{'${fg[yellow]}'%}%{'${fg[black]}${bg[yellow]}'%} \ue0a0 '${branchname}
#    elif [[ -n `echo $output | grep '^Changes not staged for commit:'` ]]; then
#        branchstatus='%{'${fg[red]}'%}%{'${fg[black]}${bg[red]}'%} \ue0a0 '${branchname}
#    else
#        branchstatus='%{'${fg[cyan]}'%}%{'${fg[black]}${bg[cyan]}'%} \ue0a0 '${branchname}
#    fi
#    echo ${branchstatus}' '
#}

function cd() {
  builtin cd $@ && ls;
}

PURPLE='[38;5;054m'
MINTGREEN='[38;5;047m'
YELLOW_COLOR='[38;5;011m'
BACKWHITE='[38;5;015m'
BACKRED='[38;5;160m'
BACKBLUE='[38;5;004m'
FONTCOLOR='[38;5;000m'
reset='[0m'
logo="
${MINTGREEN}   ,,,,,,,,,,,,,,,,,,,,,,,,  ${BACKWHITE}     ,llll,        ${BACKRED} ,,,,,,      ,l''ll    ,,,  ${PURPLE} ,,lllll,,,  l'''''''''''ll  ${BACKBLUE}      ,,,,,      ${YELLOW_COLOR}                      ${reset-color}
${MINTGREEN}'llllll,,,,,,,,  ,,,,ll'llll  ${BACKWHITE}  ,l'',ll'        ${BACKRED}ll ll' ,,,,,,ll 'll,, l,,l  ${PURPLE}ll  ll'lll' ll lllllll ll${BACKBLUE}          lllll'  ,,,${YELLOW_COLOR},,,,,,     ,,,,,,,,,  ${reset-color}
${MINTGREEN}     ,,ll'l''  .  llll'  ${BACKWHITE}   ,ll'  ll,,,         ${BACKRED}l' ll ''''''''l, ll'''   ${PURPLE} ,lll   ''ll,ll ,,,,,,, lll ${BACKBLUE}        ll l  ll lll ${YELLOW_COLOR} ..,'ll,  ll'  ..llll,${reset-color}
${MINTGREEN}     l' ll'  .l'         ${BACKWHITE},,llll, ll,  ,,,   ,. ${BACKRED}l 'll,,  ,,,,,ll ll,,   ${PURPLE} lllll, ,lllll'll ''''''' lll ${BACKBLUE}        ll l  ll ll  ${YELLOW_COLOR}ll ll  l' l   '       ${reset-color}
${MINTGREEN}     'l,,l' l,,,,,,,     ${BACKWHITE}ll' ll'  lll ll,,,''  ${BACKRED}ll  ll  ll '' ll lll ,,${PURPLE}lll  ll      llll lllllll lll, ${BACKBLUE}  ,,,   l ll  ll l   ${YELLOW_COLOR}ll ll  l,'ll,  'llllll${reset-color}
${MINTGREEN}       '''ll,llll'       ${BACKWHITE}''''      l,,,,ll''   ${BACKRED}'l,,ll' ''l,l,,,,ll''   ${PURPLE} ''ll,,lll''ll,,,,,,,,,,,,,,,l${BACKBLUE}l..ll ll  '''''  ''''${YELLOW_COLOR}' ''''   '''lllll'''  ${reset-color}
"

#printf $logo

alias wwd='echo $logo'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export GOPATH=~/develop/go
export PATH=$PATH:$GOPATH/bin
