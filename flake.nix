{
  description = "build & runtime dependencies for my AoC 2021 solutions";

  inputs.nixpkgs.url = "github:NixOs/nixpkgs";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in rec {
        devShell = pkgs.mkShell {
          nativeBuildInputs = (with pkgs; [
            # always needed
            gnumake
            curl

            # day1
            gcc # and day 6
            gnused

            # day2 (though this doesn't setup the server :P)
            postgresql

            # day3
            gawk
            bash
            coreutils-full

            # day 4
            jq

            # day 5
            guile_3_0

            # day 6
            ocaml

            # day 7
            gnat
          ]);
        };
      }
    );
}
