# ~/.config/home-manager/flake.nix
{
  description = "Home Manager configuration of nobarudo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      # 💡 修正：Apple Silicon Mac 用のアーキテクチャ指定
      system = "aarch64-darwin"; 
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."nobarudo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
