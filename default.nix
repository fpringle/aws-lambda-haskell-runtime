let
  nixpkgs-pinned = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    rev = "57695599bdc4f7bfe5d28cfa23f14b3d8bdf8a5f";
    ref = "nixpkgs-unstable";
  };

  pkgs = import nixpkgs-pinned { }; # pin the channel to ensure reproducibility!
in
pkgs.haskellPackages.developPackage {
  root = ./.;
  modifier = drv:
    pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
      [ cabal-install
        haskell-language-server
        hlint
        fourmolu
        ghcid
      ]);
}
