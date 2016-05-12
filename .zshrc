################################################################
#  環境設定
################################################################
autoload -Uz compinit
compinit

autoload -U colors
colors

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..

setopt no_beep

################################################################
#  プロンプト
################################################################

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -lA'

################################################################
#  プロンプト
################################################################

PROMPT="
[${fg[green]}%n${reset_color}@${fg[blue]}%m${reset_color}] %{${fg[yellow]}%}%~
%{${reset_color}%}%#"

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
        branchstatus='%{'${fg[green]}'%}⮂%{'${fg[black]}${bg[green]}'%} ⭠ '${branchname}
    elif [[ -n `echo $output | grep '^Untracked files:'` ]]; then
        branchstatus='%{'${fg[yellow]}'%}⮂%{'${fg[black]}${bg[yellow]}'%} ⭠ '${branchname}
    elif [[ -n `echo $output | grep '^Changes not staged for commit:'` ]]; then
        branchstatus='%{'${fg[red]}'%}⮂%{'${fg[black]}${bg[red]}'%} ⭠ '${branchname}
    else
        branchstatus='%{'${fg[cyan]}'%}⮂%{'${fg[black]}${bg[cyan]}'%} ⭠ '${branchname}
    fi
    echo ${branchstatus}' '
}

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/home/13t203/cocos/cocos2d-x-3.10/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT=/home/13t203/cocos
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/home/13t203/cocos/cocos2d-x-3.10/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH
