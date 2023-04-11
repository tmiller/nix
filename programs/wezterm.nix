{ config, specialArgs }:
let
  fontSize = if specialArgs.isDarwin then "12.0" else "10.0";
in
{
  enable = true;
  extraConfig = ''
    return {
      font_size = ${fontSize},
      color_scheme = 'Gruvbox dark, medium (base16)',
      enable_tab_bar = false,
    }
  '';
}
