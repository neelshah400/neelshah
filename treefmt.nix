_: {
  projectRootFile = "flake.nix";

  programs = {
    # (Broad)
    typos.enable = true;

    # Nix
    statix.enable = true;
    deadnix.enable = true;
    nixfmt.enable = true;

    # Shell
    shfmt.enable = true;
    shellcheck.enable = true;
  };

  settings.formatter = {
    # (Broad)
    typos.priority = 10;

    # Nix
    statix.priority = 20;
    deadnix.priority = 21;
    nixfmt.priority = 30;

    # Shell
    shfmt.priority = 40;
    shellcheck.priority = 50;
  };
}
