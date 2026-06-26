{
  description = "Neel's Personal Monorepo";

  inputs = {
    # Core packages
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Developer tooling
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vite-plus = {
      url = "github:ryoppippi/nix-vite-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      nix-vite-plus,
    }:
    let
      inherit (nixpkgs) lib;

      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      forAllSystems =
        f: lib.genAttrs supportedSystems (system: f system nixpkgs.legacyPackages.${system});

      nodeFor = pkgs: pkgs.nodejs_24;
      pnpmFor = pkgs: pkgs.pnpm_11;
      vpFor = pkgs: nix-vite-plus.packages.${pkgs.stdenv.hostPlatform.system}.vp;

      treefmtEval = forAllSystems (_system: pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      # Lint and format code
      formatter = forAllSystems (system: _pkgs: treefmtEval.${system}.config.build.wrapper);

      # Verify code
      checks = forAllSystems (
        system: _pkgs: {
          treefmt = treefmtEval.${system}.config.build.check self;
        }
      );

      # Expose development environments
      devShells = forAllSystems (
        system: pkgs: {
          default = pkgs.mkShellNoCC {
            inputsFrom = [ treefmtEval.${system}.config.build.devShell ];
            packages = with pkgs; [
              git
              jujutsu
              (nodeFor pkgs)
              (pnpmFor pkgs)
              typst
              (vpFor pkgs)
            ];

            shellHook = ''
              export VP_HOME="$PWD/.vite-plus"
              mkdir -p "$VP_HOME"
              vp env off >/dev/null
            '';
          };
        }
      );
    };
}
