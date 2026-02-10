{ pkgs, stdenv, fetchurl, ... }:

stdenv.mkDerivation rec {
  pname = "radicle";
  version = "1.6.1";

  src = fetchurl {
    url = "https://files.radicle.xyz/releases/${version}/${pname}-${version}-x86_64-unknown-linux-musl.tar.xz";
    hash = "sha256-swYhPDWNTAtykC0WbZRKkQK8MgY9YkuMHZs0GP5vPmo=";
  };

  installPhase = ''
    mkdir -p $out
    cp -a * $out
  '';

  meta = {
    description = "An open source, peer-to-peer code collaboration stack built on Git.";
    homepage = "https://radicle.xyz";
    changelog = "https://radicle.xyz/#updates";
  };
}
