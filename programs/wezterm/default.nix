{ config, ... }:
let
  fontSize = "10.0";
in
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font_size = ${fontSize},
        color_scheme = 'GruvboxDark',
        enable_tab_bar = false,
        send_composed_key_when_left_alt_is_pressed = false,
        send_composed_key_when_right_alt_is_pressed = false,
        enable_wayland = false,
        -- front_end = 'WebGpu',
      }
    '';
  };
}
