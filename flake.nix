{
  description = "A flake for building Hello World";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;

  outputs = { self, nixpkgs }: 
    let drv =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildPhase = "gcc -o hello ./main.c";
        installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
      };
  in {
    packages.x86_64-linux.default = drv;
    packages.x86_64-linux.hello = drv;
  };
}
