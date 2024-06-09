{
    description = "NixOS Flake configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
        nix-ld.url = "github:Mic92/nix-ld";
        nix-ld.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        vscode-server.url = "github:nix-community/nixos-vscode-server";
    };

    outputs = { self, nixpkgs, nixos-wsl, nix-ld, home-manager, vscode-server, ... }: {
        nixosConfigurations = {
            destiny = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    nix-ld.nixosModules.nix-ld
                    { programs.nix-ld.dev.enable = true; }

                    ./modules/nixos/configuration.nix
                    ./modules/nixos/cdubos.nix
                    ./hardware-configuration.nix

                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.cdubos = { ... }: {
                            imports = [
                                ./modules/home-manager/home.nix
                                ./modules/users/cdubos.nix
                            ];
                        };

                    }
                ];
            };
            destiny-wsl = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    nix-ld.nixosModules.nix-ld
                    { programs.nix-ld.dev.enable = true; }

                    nixos-wsl.nixosModules.default
                    {
                        system.stateVersion = "24.05";
                        wsl.enable = true;
                        wsl.defaultUser = "nixos";
                    }

                    vscode-server.nixosModules.default
                    ({ config, pkgs, ... }: {
                        services.vscode-server.enable = true;
                    })

                    ./modules/nixos/configuration.nix
                    ./modules/nixos/wsl.nix

                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.nixos = { pkgs, config, ... }: {
                            imports = [
                                ./modules/home-manager/home.nix
                                ./modules/users/wsl.nix
                            ];
                        };
                    }
                ];
            };
        };
    };
}
