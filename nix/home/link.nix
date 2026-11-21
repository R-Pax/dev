
{ lib, ... }:

{
  xdg.configFile = {
    "ghostty/config.ghostty" = {
        source = ./conf/ghostty/config.ghostty; 
        force = true;
    };
    "tmux/.tmux.conf".source = ./conf/tmux/.tmux.conf;
  };

  home.activation.copyHyprlandConfig =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD install -D -m 644 \
        ${./conf/hypr/hyprland.lua} \
        "$HOME/.config/hypr/hyprland.lua"
    '';
}

