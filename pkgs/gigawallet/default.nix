{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  buildGoModule ? pkgs.buildGoModule,
  ...
}:

buildGoModule rec {
  pname = "gigawallet";
  version = "1.0.8";

  src = fetchGit {
    url = "https://github.com/dogecoinfoundation/gigawallet.git";
    ref = "refs/tags/v${version}";
  };

  vendorHash = "sha256-mW5SStSabjWIlLWarI0OfyCTRWRQnEbk2BXabJCJ2h4";

  nativeBuildInputs = [
    pkgs.go_1_22
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.zeromq
  ];

  # This is needed because gigawallet depends on things that have native, vendored header files.
  proxyVendor = true;

  buildPhase = ''
    go build -tags libdogecoin -o gigawallet ./cmd/gigawallet
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp gigawallet $out/bin/
  '';

  meta = with lib; {
    description = "GigaWallet - A backend for your Dogecoin Business";
    homepage = "https://gigawallet.dogecoin.org";
    license = licenses.mit;
    maintainers = with maintainers; [ dogecoinfoundation ];
    platforms = platforms.all;
  };
}