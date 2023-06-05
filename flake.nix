{
  description = "NixOS configuration v0.1 - MLUUG";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
  };

  outputs = inputs@{ nixpkgs, home-manager, nur, ... }: {

    nixosConfigurations = {
      # My Laptop
      nix-as = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./platform/apple-silicon/default.nix
          ./modules/main-config.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anze = import ./home;
            
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./platform/generic-pc/default.nix
          ./modules/main-config.nix
          ./modules/nur-config.nix

          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anze = import ./home;
            
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
      latitude-3310 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./platform/latitude-3310/default.nix
          ./modules/main-config.nix
          ./modules/nur-config.nix

          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.anze = import ./home;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };    
    };
  };

}
