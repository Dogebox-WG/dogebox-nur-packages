# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  pkgs ? import <nixpkgs> { },
}:

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  dogecoin-core   = pkgs.callPackage ./pkgs/dogecoin-core {};
  dogemap         = pkgs.callPackage ./pkgs/dogemap {};
  dogenet         = pkgs.callPackage ./pkgs/dogenet {};
  jampuppy        = pkgs.callPackage ./pkgs/jampuppy {};
  libdogecoin     = pkgs.callPackage ./pkgs/libdogecoin {};
  nrpe            = pkgs.callPackage ./pkgs/nrpe {};
  radicle         = pkgs.callPackage ./pkgs/radicle {};
  radicle-httpd   = pkgs.callPackage ./pkgs/radicle-httpd {};
  rk3588-firmware = pkgs.callPackage ./pkgs/rk3588-firmware {};
  gigawallet      = pkgs.callPackage ./pkgs/gigawallet {};
  identity        = pkgs.callPackage ./pkgs/identity {};
  reflector       = pkgs.callPackage ./pkgs/reflector {};
}
