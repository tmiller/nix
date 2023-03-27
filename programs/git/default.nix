{config}:

{
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
}
