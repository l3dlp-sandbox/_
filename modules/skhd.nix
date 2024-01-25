{config, ...}: let
  skhdPath = "${config.xdg.configHome}/skhd";
in {
  home.file."${skhdPath}/skhdrc".text = ''
    meh - b : open -a "Safari"
    meh - c : open -a "Notion Calendar"
    meh - d : open -a "Discord"
    meh - f : open -a "Finder"
    meh - n : open -a "Obsidian"
    meh - r : open -a "Reminders"
    meh - t : open -a "Ghostty"

    meh - p : open /System/Library/PreferencePanes/Passwords.prefPane

    ctrl - t : skhd --key escape

    meh - h : yabai -m window --grid 2:2:0:0:1:2
    meh - l : yabai -m window --grid 2:2:1:0:1:2

    meh - H : yabai -m window --display 1 && yabai -m display --focus 1 && yabai -m window --grid 1:1:1:1:1:1
    meh - L : yabai -m window --display 2 && yabai -m display --focus 2 && yabai -m window --grid 1:1:1:1:1:1
  '';
}
