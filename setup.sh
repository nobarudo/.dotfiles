ln -fsv $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -fsv $HOME/.dotfiles/.zshrc $HOME/.zshrc

if [ ! -d ~/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

if [ ! -d ~/.solarized ]; then
  git clone git@github.com:seebi/dircolors-solarized.git ~/.solarized
fi
