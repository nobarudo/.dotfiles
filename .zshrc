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

################################################################
#  環境設定
################################################################
export LANG=ja_JP.UTF-8

autoload -Uz compinit
compinit

autoload -U colors
colors

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..

setopt no_beep

################################################################
#  エイリアス
################################################################

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -lA'
alias viewcolor='for c in {000..255}; do echo -n "[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done'
alias v='vim'
alias wwd='echo $logo'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%C(yellow)%d%Creset'"
alias gs="git status"
alias gd="git diff"
alias gin="git init"
alias ga="git add"
alias gc="git commit -m"

################################################################
#  プロンプト
################################################################

# {と[の間に特殊文字を挿入
# 入力方法は<C-v><ESC>
HOST_COLOR='%{[38;5;054m%}'
MINT_GREEN='%{[38;5;047m%}'
YELLOW_COLOR='%{[38;5;011m%}'
reset='%{[0m%}'
PROMPT="
[${MINT_GREEN}%n${reset_color}@${HOST_COLOR}%m${reset_color}] ${fg[red]}%D ${fg[blue]}%T %{${YELLOW_COLOR}%}%~
%{${reset_color}%}--> "

# git関連
RPROMPT=$'`branch-status-check`'
# 表示毎にPROMPTで設定されている文字列を評価する
setopt prompt_subst
# fg[color]表記と$reset_colorを使いたい
# @see https://wiki.archlinux.org/index.php/zsh
function branch-status-check() {
    local branchname suffix
    # .gitの中だから除外
    [[ '$PWD' =~ '/\.git(/.*)?$' ]] && return
    branchname=`get-branch-name`
    # ブランチ名が無いので除外
    [[ -z $branchname ]] && return
    suffix='%{'${reset_color}'%}'
    echo `get-branch-status`${suffix}
}
function get-branch-name() {
    local git==git
    # gitディレクトリじゃない場合のエラーを捨てる
    echo `${git} rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status() {
    local git==git branchstatus branchname
    branchname=`get-branch-name`
    output=`${git} status 2> /dev/null`
    if [[ -n `echo $output | grep '^nothing to commit'` ]]; then
        branchstatus='%{'${fg[green]}'%}%{'${fg[black]}${bg[green]}'%} \ue0a0 '${branchname}
    elif [[ -n `echo $output | grep '^Untracked files:'` ]]; then
        branchstatus='%{'${fg[yellow]}'%}%{'${fg[black]}${bg[yellow]}'%} \ue0a0 '${branchname}
    elif [[ -n `echo $output | grep '^Changes not staged for commit:'` ]]; then
        branchstatus='%{'${fg[red]}'%}%{'${fg[black]}${bg[red]}'%} \ue0a0 '${branchname}
    else
        branchstatus='%{'${fg[cyan]}'%}%{'${fg[black]}${bg[cyan]}'%} \ue0a0 '${branchname}
    fi
    echo ${branchstatus}' '
}
