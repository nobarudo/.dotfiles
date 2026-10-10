{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    curl
    htop
    bottom
    nb
    fzf
    zoxide
    starship
    lazygit
    neovim
    go
    semgrep
  ];

  programs.home-manager.enable = true;

programs.zsh = {
    enable = true;
    initExtra = ''
      # 1. macOS特有のNix環境読み込み（最優先で実行）
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      # 2. パスの追加
      export PATH="$HOME/.nix-profile/bin:$PATH"
      export PATH="$PATH:$HOME/go/bin"

      # 3. 外部設定ファイルの読み込み
      if [ -f ~/.dotfiles/.zshrc ]; then
        source ~/.dotfiles/.zshrc
      fi

      if [ -f ~/.zshrc.local ]; then
        source ~/.zshrc.local
      fi
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/starship.toml";
  home.stateVersion = "23.11"; 
}
