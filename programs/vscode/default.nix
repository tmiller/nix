{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      github.copilot
      github.copilot-chat
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "aws-toolkit-vscode";
        publisher = "amazonwebservices";
        version = "2.4.0";
        sha256 = "sha256-09JzYBQeHOptryUjSWFBY/k4CpH9UD6yI/xXwN8zU0E=";
      }
      {
        name = "jbockle-format-files";
        publisher = "jbockle";
        version = "3.4.0";
        sha256 = "sha256-BHw+T2EPdQq/wOD5kzvSln5SBFTYUXip8QDjnAGBfFY=";
      }
      {
        name = "java";
        publisher = "redhat";
        version = "1.25.1";
        sha256 = "sha256-mSPtL41ollWBol5mKOuSh/H9/Hpwl3TI8ilThmQya2A=";
      }
    ];
    userSettings = {
      "files.trimTrailingWhitespace" = true;
      "editor.formatOnSave" = true;
      "git.openRepositoryInParentFolders" = "never";
    };
  };
}
