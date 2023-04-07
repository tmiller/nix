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
    set --global --export SSH_AUTH_SOCK (${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)
  '';

  shellInit = ''
    # Launch tmux immediately after loading the shell
    if command --query ${pkgs.tmux}/bin/tmux
      and status is-interactive
      and not string match --quiet --regex 'screen|tmux' $TERM
      and test -z $TMUX
      exec ${pkgs.tmux}/bin/tmux new-session -A -s main
    end

    set --global --export PAGER ${pkgs.less}/bin/less
    set --global --export LESS -ingFXRS
    set --global --export GOPATH ${home}
    set --global --export DOCKER_SCAN_SUGGEST false
    set --global --export FZF_DEFAULT_COMMAND $FZF_FIND_FILE_COMMAND

    # Setup Path
    if test -d /opt/homebrew/bin
      fish_add_path /opt/homebrew/sbin /opt/homebrew/bin
    end
    if test -d ${home}/bin
      fish_add_path ${home}/bin
    end

    # XDG Settings
    set --global --export GNUPGHOME ${config.xdg.configHome}/gnupg

    # XDG Settings
    set --global --export XDG_CACHE_HOME  ${config.xdg.cacheHome}
    set --global --export XDG_CONFIG_HOME ${config.xdg.configHome}
    set --global --export XDG_DATA_HOME   ${config.xdg.dataHome}
    set --global --export XDG_STATE_HOME  ${config.xdg.stateHome}

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '${home}/opt/google-cloud-sdk/path.fish.inc' ]; . '${home}/opt/google-cloud-sdk/path.fish.inc'; end

    set --global --export NPM_CONFIG_USERCONFIG ${config.xdg.configHome}/npm/config
    set --global --export NPM_CONFIG_CACHE ${config.xdg.cacheHome}/npm
    set --global --export NPM_CONFIG_PREFIX ${config.xdg.dataHome}/npm
    if test -d ${config.xdg.dataHome}/npm/bin
      fish_add_path ${config.xdg.dataHome}/npm/bin
    end
  '';
}
