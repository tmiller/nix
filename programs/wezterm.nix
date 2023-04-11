{ config }:
{
  enable = true;
  extraConfig = ''
    return {
      font_size = 10.0,
      color_scheme = 'Gruvbox dark, medium (base16)',
    }
  '';
}
