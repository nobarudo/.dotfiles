ln -fnsv $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -fnsv $HOME/.dotfiles/.zshrc $HOME/.zshrc

if [ ! -d ~/.zplug ]; then
  curl -sL zplug.sh/installer | zsh
fi
