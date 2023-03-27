{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tom";
  home.homeDirectory = "/Users/tom";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.hello
    pkgs.awscli2
    pkgs.bat
    pkgs.direnv
    pkgs.exa
    pkgs.fd
    pkgs.fzf
    # pkgs.helm Not available on platform
    pkgs.kubectl
    pkgs.cue
    pkgs.kubie
    pkgs.nodejs
    pkgs.terraform
    pkgs.terragrunt

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tom/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    extraConfig = {
      color = {
        ui = true;
        status = {
          added = "green";
          changed = "yellow";
          untracked = "red";
        };
      };
      commit = {
        verbose = true;
        gpgsign = false;
      };
      tag = {
        gpgsign = false;
      };
    };
    aliases = {
      st = "status --short --branch";
      co = "checkout";
      aa = "add --all";
      au = "add --update";
      fa = "fetch --all";
      fap = "fetch --all --prune";
      b = "branch";
      ff = "merge --ff-only";
      fu = "merge --ff-only @{u}";
      ms = "merge --no-commit --log --no-ff";
      mc = "merge --log --no-ff";
      rc = "rebase --continue";
      ci = "commit -v";
      amend = "commit -v --amend";
      di = "diff";
      dc = "diff --cached";
      dh1 = "diff HEAD~1";
      h = "log --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ar)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s' -1";
      head = "log --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ar)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s' -1";
      hp = "show --patch --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ar)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s'";
      l = "log --graph --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ar)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s'";
      la = "log --graph --all --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ar)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s'";
      r = "log --graph --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ar)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s' -20";
      ra = "log --graph --all --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ar)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s' -20";
      lf = "log --first-parent --oneline";
      my-commits = "log --author='Tom Miller' --author-date-order --date=format:'%a %b %d %r' --format='%h | %ad | %s'";
      publish = "!git checkout -; echo; git merge --no-ff --no-edit -; echo; git push; echo; git checkout -";
    };

    ignores = [
      # OSX
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "Icon"

      # Thumbnails
      "._*"

      # Files that might appear on external disk
      ".Spotlight-V100"
      ".Trashes"

      # Jetbrains IDE
      ".idea"

      # Vim
      ".*.sw[a-z]"
      "*.un~"
      "Session.vim"
      ".netrwhist"

      # Emacs
      "*~"
      "\\#*\\#"
      "/.emacs.desktop"
      "/.emacs.desktop.lock"
      ".elc"
      "auto-save-list"
      "tramp"
      ".\\#*"

      # Org-mode
      ".org-id-locations"
      "*_archive"

      # Ruby
      ".bundle"
      ".ruby-version"
      ".rbenv-version"
      ".rvmrc"
      "test-unit.yml"
      "/pkg/"
      "/doc/"
      "/cov/"
      "/vendor/bundle"
      "/exec/"

      # ctags
      "tags"
      "TAGS"

      # terraform
      "*.tfstate"
      "tfplan"

      # asdf-tools
      ".tool-versions"
      ".vscode"
      "*.dot"

      # project level config
      ".envrc"
    ];
  };
}
