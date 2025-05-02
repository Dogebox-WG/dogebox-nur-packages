{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  fetchurl ? pkgs.fetchurl,
  ...
}:

stdenv.mkDerivation rec {
  pname = "libdogecoin";
  version = "0.1.4";

  src = fetchurl {
    url = "https://github.com/dogecoinfoundation/libdogecoin/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-4VIO+Rjc7jDi+H+//8OkBiH/yPXYJOYCz2rVzDW6jFA=";
  };

  configurePhase = ''
    export HOME=$(pwd)
    ./autogen.sh
    LIBS="-levent_core" ./configure
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp sendtx spvnode such $out/bin
    cp -rv contrib $out/contrib
    cp -rv doc     $out/doc
    cp -rv include $out/include
    cp -rv .libs   $out/lib
    rm $out/lib/libdogecoin.la
    cp libdogecoin.la $out/lib
  '';

  buildInputs = [
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
    pkgs.libevent
    pkgs.libunistring
  ];

  meta = with lib; {
    description = "A clean C library of Dogecoin building blocks";
    homepage = "https://github.com/dogecoinfoundation/libdogecoin";
    license = licenses.mit;
    maintainers = with maintainers; [ dogecoinfoundation ];
    platforms = platforms.all;
  };
}
