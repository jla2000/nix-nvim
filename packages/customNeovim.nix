{ pkgs }:
let
  configDir = pkgs.stdenv.mkDerivation {
    name = "neovim-config";
    src = ../config;
    installPhase = ''
      mkdir -p $out/nvim
      cp -r ./ $out/nvim
    '';
  };
  configuredNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = ''
        luafile ${configDir}/nvim/init.lua
      '';
      packages.all.start = with pkgs.vimPlugins; [
        indent-blankline-nvim
        mini-nvim
        nvim-treesitter
        nvim-treesitter-parsers.bash
        nvim-treesitter-parsers.lua
        nvim-treesitter-parsers.nix
        nvim-treesitter-parsers.rust
        oil-nvim
        tokyonight-nvim
        plenary-nvim
        lazygit-nvim
      ];
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = with pkgs; [
    lazygit
  ];
  text = ''
    export XDG_CONFIG_HOME=${configDir}
    export XDG_DATA_HOME=${configDir}
    ${configuredNeovim}/bin/nvim "$@"
  '';
}
