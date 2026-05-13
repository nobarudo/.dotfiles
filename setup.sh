ZSHRC_REAL="$HOME/.zshrc"
DOT_ZSHRC="$HOME/.dotfiles/.zshrc"

if [ ! -f "$ZSHRC_REAL" ]; then
  touch "$ZSHRC_REAL"
fi

if ! grep -q "$DOT_ZSHRC" "$ZSHRC_REAL"; then
  echo "source $DOT_ZSHRC" >>"$ZSHRC_REAL"
fi

PLUGIN_DIR="$HOME/.zsh-plugins"
P10K_DIR="$PLUGIN_DIR/powerlevel10k"
if ! command -v zoxide &>/dev/null; then
  echo "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

export PATH="$HOME/.local/bin:$PATH"

ZOXIDE_INIT='eval "$(zoxide init zsh --cmd z)"'
if ! grep -q "zoxide init" "$ZSHRC_REAL"; then
  echo "Adding zoxide initialization to $ZSHRC_REAL"
  echo "$ZOXIDE_INIT" >>"$ZSHRC_REAL"
fi

if [ ! -d "$P10K_DIR" ]; then
  echo "Installing Powerlevel10k..."
  mkdir -p "$PLUGIN_DIR"

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

P10K_SOURCE="source $P10K_DIR/powerlevel10k.zsh-theme"
if ! grep -q "powerlevel10k.zsh-theme" "$ZSHRC_REAL"; then
  echo "Adding Powerlevel10k to $ZSHRC_REAL"
  echo "$P10K_SOURCE" >>"$ZSHRC_REAL"
  echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >>"$ZSHRC_REAL"
fi
