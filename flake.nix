{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware }: rec {
    # Overlay to ensure `man` is included in the system
    nixpkgs.overlays = [
      (self: super: {
        environment.systemPackages = super.environment.systemPackages ++ [
          super.pkgs.man
        ];
      })
    ];

    images = {
      pi4 = self.nixosConfigurations.pi4.config.system.build.image;
    };
    packages.x86_64-linux.pi-image = images.pi4;
    packages.aarch64-linux.pi-image = images.pi4;

    nixosConfigurations = {
      pi4 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-4
          "${nixpkgs}/nixos/modules/profiles/minimal.nix"
          ./configuration.nix
        ];

        # Ensure `man` is available in the `nixos-rebuild` environment
        environment.systemPackages = with nixpkgs.pkgs; [
          man
        ];
      };
    };
  };
}
