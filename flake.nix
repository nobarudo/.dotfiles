# ~/.dotfiles/flake.nix
{
  description = "Home Manager configuration of nobarudo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      # 🍎 Mac 用設定
      "nobarudo" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ 
          ./home.nix 
          # 🌟 ここにMac専用のユーザー設定を注入
          {
            home.username = "nobarudo";
            home.homeDirectory = "/Users/nobarudo";
          }
        ];
      };

      # 🐧 WSL (openSUSE) 用設定
      "nobarudo-wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ 
          ./home.nix 
          # 🌟 ここにWSL専用のユーザー設定を注入（パスが /home になります）
          {
            home.username = "nobarudo";
            home.homeDirectory = "/home/nobarudo";
          }
        ];
      };
    };
  };
}
