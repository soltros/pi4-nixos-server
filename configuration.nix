{ pkgs, lib, ... }:
{
  imports = [
    ./repart.nix
    ./ssh-server.nix
    ./tailscale-support.nix
    ./docker-support.nix
    ./user-account.nix
    ./basic-server.nix
    ./motd.nix
    ./swapfile.nix
    ./apps.nix
  ];
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  environment.systemPackages = with pkgs; [ nano git ];
  services.openssh.enable = true;
  networking.hostName = "pi4-nixos-server";
  users = {
    users.default = {
      password = "default";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
  networking = {
    interfaces."wlan0".useDHCP = true;
    wireless = {
      interfaces = [ "wlan0" ];
      enable = true;
      networks = {
        networkSSID.psk = "password";
      };
    };
  };
  nix.settings = {
    experimental-features = lib.mkDefault "nix-command flakes";
    trusted-users = [ "root" "@wheel" ];
  };
}
