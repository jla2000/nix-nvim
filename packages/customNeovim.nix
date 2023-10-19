{ pkgs }:
let
  configDir = pkgs.stdenv.mkDerivation {
    name = "neovim-config";
    src = ../config;
    installPhase = ''
      mkdir -p $out/nix-nvim
      cp -r ./ $out/nix-nvim
    '';
  };
  configuredNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = ''
        luafile ${configDir}/nix-nvim/init.lua
      '';
      packages.all.start = with pkgs.vimPlugins; [
        cmp-nvim-lsp
        indent-blankline-nvim
        lazygit-nvim
        lsp-zero-nvim
        luasnip
        mini-nvim
        neodev-nvim
        nvim-cmp
        nvim-lspconfig
        nvim-treesitter
        nvim-treesitter-parsers.bash
        nvim-treesitter-parsers.lua
        nvim-treesitter-parsers.nix
        nvim-treesitter-parsers.rust
        nvim-web-devicons
        oil-nvim
        plenary-nvim
        telescope-nvim
        tokyonight-nvim
      ];
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = with pkgs; [
    lazygit
    ripgrep
    lua-language-server
    rnix-lsp
  ];
  text = ''
    export XDG_CONFIG_HOME=${configDir}
    export NVIM_APPNAME=nix-nvim
    ${configuredNeovim}/bin/nvim "$@"
  '';
}
