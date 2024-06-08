{ config, lib, pkgs, ... }:
{
    imports = [
        (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
    ];
    programs.nix-ld.enable = true;

    services.vscode-server.enable = true;
    services.vscode-server.enableFHS = true;

    environment.systemPackages = with pkgs; [
        wslu
    ];
}
