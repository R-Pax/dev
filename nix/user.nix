{ pkgs, ... }:
{
  users.mutableUsers = true;
  users.groups."pax".gid = 1000;

  users.users."pax" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    uid = 1000;
    group = "pax";
    home = "/home/pax";
    createHome = false;
    description = "Existing Gravity Linux user";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
  };
}
