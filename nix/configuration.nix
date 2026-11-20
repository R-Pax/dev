{ config, lib, pkgs, inputs, ... }:

let
  kernelRelease = "7.3.0-520.gravity.fc44.aarch64+16k";

  # Read the configuration of the prebuilt Gravity kernel.
  kernelConfigLines = lib.splitString "\n" (builtins.readFile ./assets/kernel.config);
  kernelConfigEntries = lib.concatMap (line:
    let
      enabled = builtins.match "CONFIG_([A-Za-z0-9_]+)=(.*)" line;
      disabled = builtins.match "# CONFIG_([A-Za-z0-9_]+) is not set" line;
    in
      if enabled != null then [
        {
          name = builtins.elemAt enabled 0;
          value = builtins.elemAt enabled 1;
        }
      ] else if disabled != null then [
        {
          name = builtins.elemAt disabled 0;
          value = "n";
        }
      ] else [ ]
  ) kernelConfigLines;
  kernelConfigValues = builtins.listToAttrs kernelConfigEntries;
  kernelConfig = rec {
    getValue = option: kernelConfigValues.${option} or "n";
    isSet = option: getValue option != "n";
    isYes = option: getValue option == "y";
    isNo = option: getValue option == "n";
    isModule = option: getValue option == "m";
    isEnabled = option: isYes option || isModule option;
  };

  # Use the existing M4-compatible Gravity kernel instead of the generic NixOS kernel.
  kernelBase = pkgs.stdenvNoCC.mkDerivation {
    pname = "gravity-m4-kernel";
    version = "7.3.0";
    outputs = [ "out" "modules" "dev" ];
    dontUnpack = true;
    dontBuild = true;
    dontStrip = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p "$out/lib/firmware"
      install -m 0644 ${./assets/vmlinuz} "$out/Image"
      mkdir -p "$modules/lib/modules/${kernelRelease}"
      cp -a ${./assets/modules}/. "$modules/lib/modules/${kernelRelease}/"
      test -s "$modules/lib/modules/${kernelRelease}/modules.dep"
      # Provide the directory expected by NixOS; no kernel headers are needed.
      mkdir -p "$dev/lib/modules/${kernelRelease}/build"
    '';

    passthru = {
      modDirVersion = kernelRelease;
      target = "Image";
      # Expose the original kernel configuration for NixOS compatibility.
      features = { };
      config = kernelConfig;
      configfile = ./assets/kernel.config;
    };

    meta.platforms = [ "aarch64-linux" ];
  };

  # Adapt the prebuilt kernel to the interface expected by NixOS.
  kernel = kernelBase // {
    stdenv = pkgs.stdenv;
    isLTS = false;
    isZen = false;
    modDirVersion = kernelRelease;
    target = "Image";
    features = { };
    config = kernelConfig;
    configfile = ./assets/kernel.config;
    commonMakeFlags = [ ];
    kernelOlder = version: lib.versionOlder kernelBase.version version;
    kernelAtLeast = version: lib.versionAtLeast kernelBase.version version;
    override = _: kernel;
  };

  # Create the NixOS package set for this kernel.
  kernelPackages = pkgs.linuxKernel.packagesFor kernel;

  # Include the vendor firmware required by the M4 hardware.
  vendorFirmware = pkgs.runCommand "gravity-m4-vendor-firmware" { } ''
    mkdir -p "$out/lib/firmware"
    cp -a ${./assets/firmware/vendor} "$out/lib/firmware/vendor"
    test -f "$out/lib/firmware/vendor/.vendorfw.manifest"
  '';

in {
  nixpkgs.hostPlatform = "aarch64-linux";
  system.stateVersion = "26.05";

  # Use the M4-compatible Mesa version from Firn.
  nixpkgs.overlays = [
    (final: prev: {
      mesa = final.callPackage (inputs.firn.outPath + "/pkgs/mesa") {
        mesa = prev.mesa;
      };
    })
  ];

  networking.hostName = "nixos-m4";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Reuse the working Gravity kernel and its modules.
  boot.kernelPackages = kernelPackages;
  system.boot.loader.kernelFile = "Image";
  system.boot.loader.initrdFile = "initrd";
  boot.kernelParams = [ "rootwait" ];

  # Use the kernel's built-in drivers and vendor firmware in the initrd.
  boot.initrd.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.emergencyAccess = true;
  boot.initrd.includeDefaultModules = false;
  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.initrd.compressor = "zstd";
  boot.initrd.extraFirmwarePaths = [ "vendor" ];
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ vendorFirmware ];

  # Use the device tree supplied by Gravity.
  hardware.deviceTree.enable = false;

  # Keep the existing bootloader; do not install another one.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fcd7ff92-9073-4a20-9ccd-f4289ac9a785";
    fsType = "btrfs";
    options = [ "subvol=nixos" "compress=zstd:1" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/fcd7ff92-9073-4a20-9ccd-f4289ac9a785";
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd:1" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/715f0598-a3cd-4fcc-8367-98d3efddb690";
    fsType = "ext4";
  };

  # Enable graphics and the Hyprland desktop.
  hardware.graphics.enable = true;
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  security.polkit.enable = true;

  # Enable audio services.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Enable Bluetooth and power management.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.upower.enable = true;

  # Install system applications.
  environment.systemPackages = with pkgs; [
    git
    kitty
    neovim
    zsh
    tmux
    waybar
    wofi
    grim
    slurp
    wl-clipboard
    pavucontrol
    brightnessctl
    playerctl
  ];

  # Enable flakes and the new Nix command.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Avoid waiting for NetworkManager during boot.
  systemd.services.NetworkManager-wait-online.enable = false;
}

