{ config }:
{
  enable = true;
  git = true;
  extraOptions = [
    "--group-directories-first"
    "--header"
  ];
  enableAliases = true;
}
