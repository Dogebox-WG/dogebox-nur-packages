{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  fetchurl ? pkgs.fetchurl,
  lib ? pkgs.lib,
  disableWallet ? false,
  disableGUI ? false,
  disableTests ? false,
  enableZMQ ? false,
  ...
}:

let
  boost_1_63_0 = stdenv.mkDerivation rec {
    pname = "boost";
    version = "1.63.0";

    src = pkgs.fetchurl {
      url = "mirror://sourceforge/boost/boost_1_63_0.tar.bz2";
      sha256 = "beae2529f759f6b3bf3f4969a19c2e9d6f0c503edcb2de4a61d1428519fcb3b0";
    };

    nativeBuildInputs = [ pkgs.bzip2 pkgs.perl pkgs.which pkgs.boost-build ];
    buildInputs = [ pkgs.zlib ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ pkgs.gcc ];

    configurePhase = ''./bootstrap.sh --with-toolset=gcc --without-icu --with-bjam=b2 --with-libraries=chrono,filesystem,program_options,system,thread,test'';
    buildPhase     = ''b2 -d0 -j''${NIX_BUILD_CORES:-1} threading=multi link=static runtime-link=shared address-model=64 stage'';
    installPhase   = ''b2 -d0 threading=multi link=static runtime-link=shared address-model=64 install --prefix="$out"'';
  };
in
stdenv.mkDerivation rec {
  pname = "dogecoin-core";
  upstreamVersion = "1.14.9";
  derivationVersion = "v1";

  version = "${upstreamVersion}-${derivationVersion}";

  src = fetchurl {
    url = "https://github.com/dogecoin/dogecoin/archive/refs/tags/v${upstreamVersion}.tar.gz";
    hash = "sha256-DqAJtiA0qf6WYUDf9kHaoUJkI/c0NSrBeaKyOvA8Ayo=";
  };

  configureFlags = [
    "--with-incompatible-bdb"
    "--with-boost-libdir=${boost_1_63_0}/lib"
  ]
  ++ lib.optional disableWallet "--disable-wallet"
  ++ lib.optional disableGUI "--with-gui=no"
  ++ lib.optional disableTests "--disable-tests";

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.autoreconfHook
    pkgs.openssl
    pkgs.db5
    pkgs.util-linux
    boost_1_63_0
    pkgs.zlib
    pkgs.libevent
    pkgs.protobuf
    pkgs.qrencode
  ]
  ++ lib.optional enableZMQ [
    pkgs.zeromq
  ];

  meta = with lib; {
    description = "Allows anyone to operate a node in the Dogecoin blockchain networks";
    homepage = "https://dogecoin.com";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
