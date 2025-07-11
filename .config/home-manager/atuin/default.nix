{ config, lib, pkgs, ... }:

{
  # Enable Atuin with zsh integration
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      # Core settings
      auto_sync = true;
      update_check = false;
      sync_frequency = "10m";
      sync_address = "https://api.atuin.sh";
      
      # Search configuration
      search_mode = "fuzzy";
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "session";
      inline_height = 10;
      show_preview = true;
      max_preview_height = 10;
      show_help = true;
      exit_mode = "return-original";
      word_jump_mode = "emacs";
      
      # Display settings
      style = "compact";
      
      # Key bindings - vim mode settings
      keymap_mode = "vim-insert";
      
      # Sync settings
      sync_records = true;
      
      # Common commands configuration
      common_prefix = [ "sudo" "doas" ];
      common_subcommands = false;
      
      # History filtering options
      history_filter = [
        "^ls$"
        "^cd$"
        "^pwd$"
        "^exit$"
        "^clear$"
        "^history$"
      ];
      
      # Daemon settings
      daemon_timeout = 3000;
      
      # Theme configuration
      theme = "catppuccin-mocha";
    };
  };

  # Create Catppuccin Mocha theme file for Atuin
  xdg.configFile."atuin/themes/catppuccin-mocha.toml" = {
    text = ''
      # Catppuccin Mocha theme for Atuin
      # Based on https://github.com/catppuccin/catppuccin
      
      [colors]
      # Catppuccin Mocha palette
      rosewater = "#f5e0dc"
      flamingo = "#f2cdcd"
      pink = "#f5c2e7"
      mauve = "#cba6f7"
      red = "#f38ba8"
      maroon = "#eba0ac"
      peach = "#fab387"
      yellow = "#f9e2af"
      green = "#a6e3a1"
      teal = "#94e2d5"
      sky = "#89dceb"
      sapphire = "#74c7ec"
      blue = "#89b4fa"
      lavender = "#b4befe"
      text = "#cdd6f4"
      subtext1 = "#bac2de"
      subtext0 = "#a6adc8"
      overlay2 = "#9399b2"
      overlay1 = "#7f849c"
      overlay0 = "#6c7086"
      surface2 = "#585b70"
      surface1 = "#45475a"
      surface0 = "#313244"
      base = "#1e1e2e"
      mantle = "#181825"
      crust = "#11111b"
      
      # Atuin theme mappings
      [theme]
      # Main interface colors
      background = "base"
      foreground = "text"
      
      # Search interface
      search_bg = "surface0"
      search_fg = "text"
      search_border = "surface1"
      
      # Selected item highlighting
      selected_bg = "surface1"
      selected_fg = "text"
      
      # Command preview
      preview_bg = "surface0"
      preview_fg = "subtext1"
      
      # Status and help text
      status_bg = "surface0"
      status_fg = "subtext0"
      help_bg = "surface0"
      help_fg = "subtext0"
      
      # Syntax highlighting for commands
      command = "blue"
      path = "green"
      flag = "yellow"
      string = "green"
      number = "peach"
      comment = "overlay0"
      
      # Time and date
      time = "lavender"
      date = "subtext1"
      
      # Exit code colors
      exit_success = "green"
      exit_failure = "red"
      
      # Borders and separators
      border = "surface1"
      separator = "overlay0"
    '';
  };
}
