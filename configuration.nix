# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:
{
    imports = [
        # ./hardware-configuration.nix
        <nixos-wsl/modules>
        <home-manager/nixos>
        (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
    ];


    wsl.enable = true;
    wsl.defaultUser = "cdubos";
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # nix.extraOptions = ''
    #     experimental-features = nix-command flakes
    # '';

    programs.zsh.enable = true;
    programs.nix-ld.enable = true;

    users.defaultUserShell = pkgs.zsh;
    users.users.cdubos = {
        isNormalUser = true;
        home = "/home/cdubos";
        useDefaultShell = true;
    };

    services.vscode-server.enable = true;
    services.vscode-server.enableFHS = true;

    environment.systemPackages = with pkgs; [
        wslu
    ];

    system.stateVersion = "24.05";
    system.autoUpgrade.enable  = true;
    system.autoUpgrade.allowReboot  = true;
}
