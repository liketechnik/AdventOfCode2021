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

            # day 8
            # gleam maybe some time later...
            # (pkgs.rustPlatform.buildRustPackage rec {
            #   pname = pkgs.gleam.pname;
            #   version = "0.18.0";
            #   src = fetchFromGitHub {
            #     owner = "gleam-lang";
            #     repo = pname;
            #     rev = "v${version}";
            #     sha256 = "sha256-S7PYN0iiSXEApIG0Tyb/PJmKjHzjz3S+ToDy+pwPK18=";
            #   };
            #   cargoSha256 = "sha256-Q5WyKQ4HFOIL1KAQ0QvAbZfy+WRAWf9HxSvSabSz4W4=";

            #   nativeBuildInputs = pkgs.gleam.nativeBuildInputs;

            #   buildInputs = pkgs.gleam.buildInputs;

            #   meta = pkgs.gleam.meta;
            # })
            erlang
          ]);
        };
      }
    );
}
