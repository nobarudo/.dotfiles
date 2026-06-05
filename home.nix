{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    curl
    fzf
    zoxide
    starship
    lazygit
    neovim
    go
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH="$PATH:$HOME/go/bin"
      source ~/.dotfiles/.zshrc
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
