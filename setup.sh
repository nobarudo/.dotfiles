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

if ! command -v starship &>/dev/null; then
  echo "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$LOCAL_BIN" -y
fi

# 2. starship.toml の配置（インストールの有無に関わらず、常に最新を同期）
echo "Configuring Starship..."
mkdir -p "$HOME/.config"

# パターンA：単純にファイルをコピーする場合
cp "$HOME/.dotfiles/starship.toml" "$HOME/.config/starship.toml"
