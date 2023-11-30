{
  description = "A flake for building Hello World";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;

  outputs = { self, nixpkgs }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    drv = forAllSystems (system: 
      with import nixpkgs { system = system; };
      stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildPhase = "gcc -o hello ./main.c";
        installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
      });
    in {
      packages = forAllSystems (system: { default = drv.${system}; hello = drv.${system}; });
    };
}
