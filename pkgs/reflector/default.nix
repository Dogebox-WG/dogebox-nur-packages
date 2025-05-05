{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  buildGoModule ? pkgs.buildGoModule,
  ...
}:

buildGoModule {
  pname = "reflector";
  version = "0.0.2";

  src = fetchGit {
    url = "https://github.com/dogeorg/reflector.git";
    rev = "d68d4281fb8df2bd54b65beb8950e64a2af50af9";
  };

  vendorHash = "sha256-Dfdzc2wZWis2/Lla6VLYkSUNKw4dTw8kEGCGdDN0org=";

  nativeBuildInputs = [
    pkgs.go
  ];

  meta = with lib; {
    description = "Dogebox Reflector service";
    homepage = "https://github.com/dogeorg/reflector";
    license = licenses.mit;
    maintainers = with maintainers; [ dogecoinfoundation ];
    platforms = platforms.all;
  };
}
