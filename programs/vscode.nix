{config, pkgs}:
{
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    vscodevim.vim
    github.copilot
    github.copilot-chat
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "aws-toolkit-vscode";
      publisher = "amazonwebservices";
      version = "2.1.0";
      sha256 = "sha256-09JzYBQeHOptryUjSWFBY/k4CpH9UD6yI/xXwN8zU0E=";
    }
  ];
  userSettings = {
    "files.trimTrailingWhitespace" = true;
    "editor.formatOnSave" = true;
    "git.openRepositoryInParentFolders" = "never";
  };
}
