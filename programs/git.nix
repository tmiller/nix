{config}:

let
  user_dba = {
    user = {
      name = "Tom M";
      email = "tom@dbadbadba.com";
      signingKey = "0x28AB3EBD8D9B1464";
    };
  };
in
{
  enable = true;

  rerere = {
    enabled = true;
  };

  extraConfig = {
    user = {
      name = "Thomas Miller";
      email = "git@me.tmiller.dev";
    };
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
    };
    pull = {
      ff = true;
    };
  };

  signing = {
     signByDefault = true;
     key = "0xA6B3BAA6C1B861FC";
  };

  includes = [
    ({
      contentSuffix = "dba_user_config";
      contents = user_dba;
      condition = "hasconfig:remote.*.url:git@gitlab.com:daring-bit-assembly/**";
    })
    ({
      contentSuffix = "dba_user_config";
      contents = user_dba;
      condition = "hasconfig:remote.*.url:git@gitlab.com:software224/**";
    })
    ({
      contentSuffix = "dba_user_config";
      contents = user_dba;
      condition = "hasconfig:remote.*.url:git@bitbucket.org:settlementdatasystems/**";
    })
    ({
      contentSuffix = "dba_user_config";
      contents = user_dba;
      condition = "hasconfig:remote.*.url:git@bitbucket.org:vistaproducers/**";
    })
  ];

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
    ce = "commit -v --allow-empty";
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
    ld = "log --graph --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ad)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s'";
    lda = "log --graph --all --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ad)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s'";
    rd = "log --graph --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ad)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s' -20";
    rda = "log --graph --all --pretty='tformat:%C(auto,yellow)%h%C(auto,reset) %C(auto,green)(%ad)%C(auto,reset) %C(auto,bold blue)<%an>%C(auto,reset) %C(auto,red)%d%C(auto,reset) %s' -20";
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

    # Python
    ".venv"

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

    # Direnv
    ".envrc"
    ".direnv"
  ];
}
