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

    # Typst
    typstyle.enable = true;
  };

  settings.formatter = {
    # Priority:
    # - 10 = broad, lint, fix
    # - 20 = specific, lint, fix
    # - 30 = broad, format, fix
    # - 40 = specific, format, fix
    # - 50 = specific, lint, check

    # (Broad)
    typos.priority = 10;

    # Nix
    statix.priority = 20;
    deadnix.priority = 21;
    nixfmt.priority = 30;

    # Shell
    shfmt.priority = 40;
    shellcheck.priority = 50;

    # Typst
    typstyle.priority = 40;
  };
}
