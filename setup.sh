ln -fsv $HOME/.dotfiles/.zshrc $HOME/.zshrc

PLUGIN_DIR="$HOME/.zsh-plugins"
P10K_DIR="$PLUGIN_DIR/powerlevel10k"

if [ ! -d "$P10K_DIR" ]; then
  echo "Installing Powerlevel10k..."
  mkdir -p "$PLUGIN_DIR"

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi
