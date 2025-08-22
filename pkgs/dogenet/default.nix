{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  buildGoModule ? pkgs.buildGoModule,
  ...
}:

let
  version = "0.1.10";
in
buildGoModule {
  name = "dogenet";
  inherit version;

  src = pkgs.fetchgit {
    url = "https://github.com/dogebox-wg/dogenet.git";
    rev = "v${version}";
    hash = "sha256-0F0aMZaAiIReGWsoNoj3F86gMFUnh+P+T52LQX5opNM=";
  };

  vendorHash = "sha256-4XDgSVH+QAlIAv5/h30oqeVzMTEoAfEAySkVmMH6kFs=";

  nativeBuildInputs = [
    pkgs.go
    pkgs.gzip
  ];

  meta = with lib; {
    description = "Gossip network for Dogecoin";
    homepage = "https://github.com/dogebox-wg/dogenet";
    license = licenses.mit;
    maintainers = with maintainers; [ dogecoinfoundation ];
    platforms = platforms.all;
  };
}
