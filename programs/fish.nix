{ config, pkgs, lib, specialArgs }:

let
  home = config.home.homeDirectory;
in {
  enable = true;
  plugins = with pkgs.fishPlugins; [
    {
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
        hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
      };
    }
  ];

  shellAliases = {
  };

  interactiveShellInit = ''
  '';

  shellInit = ''
    # Launch tmux immediately after loading the shell
    if command --query ${pkgs.tmux}/bin/tmux
      and status is-interactive
      and not string match --quiet --regex 'screen|tmux' $TERM
      and test -z $TMUX
      exec ${pkgs.tmux}/bin/tmux new-session -A -s main
    end

    # Setup Path
    if test -d /opt/homebrew/bin
      fish_add_path /opt/homebrew/sbin /opt/homebrew/bin
    end
    if test -d ${home}/bin
      fish_add_path ${home}/bin
    end

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '${home}/opt/google-cloud-sdk/path.fish.inc' ]; . '${home}/opt/google-cloud-sdk/path.fish.inc'; end

    if test -d ${config.xdg.dataHome}/npm/bin
      fish_add_path ${config.xdg.dataHome}/npm/bin
    end
  '';
}
