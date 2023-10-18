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

      overlayFlakeInputs = prev: final: {
        neovim = neovim.packages.${system}.neovim;
      };

      overlayCustomNeovim = prev: final: {
        customNeovim = import ./packages/customNeovim.nix {
          pkgs = final;
        };
      };

      pkgs = import nixpkgs
        {
          inherit system;
          overlays = [ overlayFlakeInputs overlayCustomNeovim ];
        };
    in
    {
      packages.${system}.default = pkgs.customNeovim;
      apps.${system}.default = {
        type = "app";
        program = "${pkgs.customNeovim}/bin/nvim";
      };
    };
}
