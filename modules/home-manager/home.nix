{ pkgs, config, ... }: {

    home.stateVersion = "24.05";
    home.packages = with pkgs; [
        neovim
        vim
        git
        wget
        zsh-history
        zsh-autosuggestions
        zsh-autocomplete
        nix-direnv
        direnv
        bat
        gh
    ];

    programs.home-manager.enable = true;
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        initExtra = ''
            source ~/.p10k.zsh
        '';

        syntaxHighlighting.enable = true;

        shellAliases = {
            ll = "ls -l";
            update = "sudo nixos-rebuild switch";
        };

        history.size = 10000;
        history.path = "${config.xdg.dataHome}/zsh/history";

        oh-my-zsh = {
            enable = true;
            plugins = [
                "history"
                "git"
            ];
        };

        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
        ];
    };
}
