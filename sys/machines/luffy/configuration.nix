{ config, lib, pkgs, ... }:
{
  imports =
    [
       ../../modules
       ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "luffy";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.ellie = {
    isNormalUser = true;
    description = "Eloise Zappala";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  services.getty.autologinUser = "ellie";

  # Only instantiating packages that are *required* to perform
  # initial setup. All other setup moved to home-manager.
  environment.systemPackages = with pkgs; [
    neovim
    git
    home-manager
    # needed to view graphics card bus information
    lshw
  ];
  
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load the nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required (although the nixos wiki fails to elaborate why)
    modesetting.enable = true;

    # Can be enabled if issues occur when loading programs after sleep.
    # Experimental power management dumps the vram to /tmp
    powerManagement.enable = false;
    
    # Fine-grained power management. Turns off GPU when not in use.
    # TODO: Need to enable Offload first, then we can turn this back on
    powerManagement.finegrained = false;
    
    # use Nvidia's open source drivers. (As of july 2024, 
    # all nvidia kernels are open source)
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
