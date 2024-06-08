{ config, lib, pkgs, ... }:
{
    imports = [
        (fetchTarball {
            url="https://github.com/msteen/nixos-vscode-server/tarball/master";
            sha256 = "sha256:1rq8mrlmbzpcbv9ys0x88alw30ks70jlmvnfr2j8v830yy5wvw7h";
        })
    ];
    programs.nix-ld.enable = true;

    services.vscode-server.enable = true;
    services.vscode-server.enableFHS = true;

    environment.systemPackages = with pkgs; [
        wslu
    ];
}
