{ config, lib, pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;
    virtualisation.containers.enable = true;
    virtualisation = {
        docker.enable = false;
        podman = {
            enable = true;

            dockerCompat = true;
            dockerSocket.enable = true;
            defaultNetwork.settings.dns_enabled = true;
        };
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    programs.zsh.enable = true;

    users.defaultUserShell = pkgs.zsh;

    system.stateVersion = "24.11";
    system.autoUpgrade.enable  = true;
    system.autoUpgrade.allowReboot  = true;

    environment.sessionVariables = {
        PODMAN_IGNORE_CGROUPSV1_WARNING="true";
    };
}
