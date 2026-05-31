{ config, pkgs, ... }:

{
  # ユーザー名とホームディレクトリの指定
  home.username = "nobarudo";
  home.homeDirectory = "/Users/nobarudo";

  # 1. コマンドラインツールのインストール (curl | sh とサヨナラ！)
  home.packages = with pkgs; [
    fzf
    zoxide
    starship
  ];

  programs.home-manager.enable = true;

  # 2. Zsh の設定（grep >> .zshrc の泥臭いハックをパージ）
  programs.zsh = {
    enable = true;
    # 既存の .zshrc を読み込む設定をここに注入
    initContent = ''
      source ~/.dotfiles/.zshrc
    '';
  };

  # 3. Zoxide の有効化と Zsh へのフック注入
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true; # これだけで eval "$(zoxide init zsh)" が自動設定される！
  };

  # 4. Starship の有効化と Zsh へのフック注入
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # 5. 設定ファイルのリンク (cp ではなくシンボリックリンクで直結)
  home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/starship.toml";
  # Home Manager 自身のバージョン
  home.stateVersion = "23.11"; 
}
