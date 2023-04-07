{ config }:
{
  enable = true;
  fileWidgetCommand = builtins.concatStringsSep " " [
    "fd"
    "--type directory"
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
  changeDirWidgetCommand = builtins.concatStringsSep " " [
    "fd"
    "--type directory"
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
}
