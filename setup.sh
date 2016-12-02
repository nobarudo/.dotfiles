ln -fsv $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -fsv $HOME/.dotfiles/.zshrc $HOME/.zshrc

if [ ! -d ~/.zplug ]; then
  curl -sL zplug.sh/installer | zsh
fi

if [ ! -d ~/.solarized ]; then
  git clone git@github.com:seebi/dircolors-solarized.git ~/.solarized
fi
