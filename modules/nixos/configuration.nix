{ config, lib, pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    programs.zsh.enable = true;

    users.defaultUserShell = pkgs.zsh;

    system.stateVersion = "24.05";
    system.autoUpgrade.enable  = true;
    system.autoUpgrade.allowReboot  = true;
}
