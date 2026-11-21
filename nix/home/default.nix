{ ... }:

{
  imports = [
    ./link.nix
  ];

  home.username = "pax";
  home.homeDirectory = "/home/pax";
  home.stateVersion = "26.05";
}
