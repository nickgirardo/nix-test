{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
    name = "hello";
    src = ./.;
    buildInputs = [];
    buildPhase = ''
        mkdir -p $out
        echo "hello world!" > $out/hello.txt
    '';
}
