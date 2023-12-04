{ pkgs }:
let
  distroName = "nix-nvim";
  configDir = pkgs.stdenv.mkDerivation {
    name = "neovim-config";
    src = ./config;
    installPhase = ''
      mkdir -p $out/${distroName}
      cp -r ./ $out/${distroName}
    '';
  };
  configuredNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = ''
        lua vim.opt.runtimepath:remove(vim.fn.expand('~/.config/${distroName}'))
        lua vim.opt.runtimepath:append(vim.fn.expand('${configDir}/${distroName}'))
        luafile ${configDir}/${distroName}/init.lua
      '';
      packages.all.start = with pkgs.vimPlugins; [
        cmp-nvim-lsp
        fzf-vim
        indent-blankline-nvim
        lazygit-nvim
        lsp-zero-nvim
        luasnip
        mini-nvim
        neodev-nvim
        nvim-bqf
        nvim-cmp
        nvim-lspconfig
        nvim-treesitter
        nvim-treesitter-parsers.bash
        nvim-treesitter-parsers.cpp
        nvim-treesitter-parsers.lua
        nvim-treesitter-parsers.nix
        nvim-treesitter-parsers.rust
        nvim-web-devicons
        oil-nvim
        plenary-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        tokyonight-nvim
        lualine-nvim
      ];
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = with pkgs; [
    git
    lazygit
    libclang
    lua-language-server
    nil
    nixpkgs-fmt
    ripgrep
    rust-analyzer
  ];
  text = ''
    export NVIM_APPNAME=${distroName}
    ${configuredNeovim}/bin/nvim "$@"
  '';
}
