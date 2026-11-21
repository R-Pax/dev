
{ lib, ... }:

{
  xdg.configFile = {
    "kitty/kitty.conf".source = ./conf/kitty/kitty.conf;
    "tmux/tmux.conf".source = ./conf/tmux/.tmux.conf;
  };

  home.activation.copyHyprlandConfig =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD install -D -m 644 \
        ${./conf/hypr/hyprland.lua} \
        "$HOME/.config/hypr/hyprland.lua"
    '';
}

