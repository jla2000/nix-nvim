{ pkgs }:
let
  config = import ../config { inherit pkgs; };
  configuredNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = config.customRC;
      packages.all.start = config.plugins;
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = with pkgs; [
    lazygit
  ];
  text = ''
    ${configuredNeovim}/bin/nvim "$@"
  '';
}
