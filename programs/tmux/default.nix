{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-space";
    plugins = with pkgs.tmuxPlugins; [
      pain-control
      sensible
      sessionist
      yank
    ];
    extraConfig = ''
      bind-key 'c' new-window -c "#{pane_current_path}"
      set-option -g status-style "fg=blue,bg=black"
      set-option -g status-left "#[fg=green]#H"
      set-option -g status-right "#[fg=yellow]%A %F %l:%M %p"
      set-window-option -g window-status-current-style "fg=white"
    '';
  };
}
