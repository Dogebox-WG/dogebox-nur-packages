{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  fetchurl ? pkgs.fetchurl,
  ...
}:

stdenv.mkDerivation rec {
  pname = "radicle-httpd";
  version = "0.23.0";

  src = fetchurl {
    url = "https://files.radicle.xyz/releases/${pname}/${version}/${pname}-${version}-x86_64-unknown-linux-musl.tar.xz";
    hash = "sha256-0ZFF5txyNEP9uLXqsTHD9C2Nrc0FGwwBmWohMo9q8BY=";
  };

  installPhase = ''
    mkdir -p $out
    cp -a * $out
  '';

  meta = {
    description = "An open source, peer-to-peer code collaboration stack built on Git - Web service.";
    homepage = "https://radicle.xyz";
    changelog = "https://radicle.xyz/#updates";
  };
}
