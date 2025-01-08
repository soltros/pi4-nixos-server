{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.derrik = {
    isNormalUser = true;
    description = "Derrik Diener";
    extraGroups = [ "networkmanager" "wheel" "gamemode"];
    initialPassword = "1derrik1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrT2fNpnU3yOcpOJIF/5QQb0Nqgq1+DO9w1TiVqcRp/ derrik@b450m-d3sh"
    ];
  };
}
