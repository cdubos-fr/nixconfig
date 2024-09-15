{ pkgs, config, ... }: with pkgs.python312Packages; let
    buildPythonPackage = pkgs.python312Packages.buildPythonPackage;
    fetchPypi = pkgs.python312Packages.fetchPypi;

    cruft = buildPythonPackage
        rec {
            pname = "cruft";
            version = "2.15.0";

            doCheck = false;
            format = "pyproject";
            src = fetchPypi {
                inherit pname version;
                sha256 = "sha256-mAKvZgN0GGVefktvMLUxWR4HYZObP/XdRdJ8Oj9Yir4=";
            };
            propagatedBuildInputs = [ typer cookiecutter gitpython click ];
            nativeBuildInputs = [ poetry-core ];
        };
in {

    home.stateVersion = "24.05";
    home.packages = with pkgs; [
        neovim
        vim
        bat

        wget

        zsh-history
        zsh-autosuggestions
        zsh-autocomplete

        nix-direnv
        direnv

        git
        gh

        dive
        podman
        podman-tui
        docker-compose
        arion

        (
            pkgs.python312.withPackages (ppkgs: with ppkgs; [
                cruft
            ])
        )
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
