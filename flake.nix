{
  description = "My neovim flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim }:
    let
      system = "x86_64-linux";

      overlayNeovim = prev: final: {
        neovim = neovim.packages.${system}.neovim;
      };

      overlayNixNvim = prev: final: {
        nixNvim = import ./nix-nvim.nix {
          pkgs = final;
        };
      };

      pkgs = import nixpkgs
        {
          inherit system;
          overlays = [ overlayNeovim overlayNixNvim ];
        };
    in
    {
      packages.${system}.default = pkgs.nixNvim;
      apps.${system}.default = {
        type = "app";
        program = "${pkgs.nixNvim}/bin/nvim";
      };
    };
}
