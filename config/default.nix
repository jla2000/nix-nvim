{ pkgs }:
let
  configDir = pkgs.stdenv.mkDerivation {
    name = "customNeovim-config";
    src = ./lua;
    installPhase = ''
      mkdir -p $out
      cp -r ./ $out/
    '';
  };
  sourceConfigFiles = builtins.map (file: "luafile ${configDir}/${file}") (builtins.attrNames (builtins.readDir configDir));
  customRC = builtins.concatStringsSep "\n" sourceConfigFiles;
  plugins = with pkgs.vimPlugins; [
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
in
{
  inherit customRC;
  inherit plugins;
}
