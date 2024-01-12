{ config, ... }:
let
  excludes = [
    "--exclude .git"
    "--exclude .terraform"
    "--exclude .terragrunt-cache"
    "--exclude node_modules"
    "--exclude vendor"
    "--exclude elm-stuff"
    "--exclude deps"
    "--exclude _build"
    "--exclude target"
    "--exclude pkg"
    "--exclude Library"
    "--exclude .Trash"
  ];
in
{
  programs.fzf = {
    enable = true;
    defaultCommand = builtins.concatStringsSep " " ([
      "fd"
      "--type file"
    ] ++ excludes);

    fileWidgetCommand = builtins.concatStringsSep " " ([
      "fd"
      "--type file"
    ] ++ excludes);

    changeDirWidgetCommand = builtins.concatStringsSep " " ([
      "fd"
      "--type directory"
    ] ++ excludes);
  };
}
