{ pkgs, ... }: {
  "$uwsm" = "${pkgs.uwsm}/bin/uwsm-app";
  "$grimblast" = "${pkgs.grimblast}/bin/grimblast";
  "$hyprpicker" = "${pkgs.hyprpicker}/bin/hyprpicker";
  "$playerctl" = "${pkgs.playerctl}/bin/playerctl";
  "$brightnessctl" = "${pkgs.brightnessctl}/bin/brightnessctl";
  "$wpctl" = "${pkgs.wireplumber}/bin/wpctl";

  "$launch" = "$uwsm --";
  "$terminal" = "$uwsm -T --";

  "$browser" = "$launch firefox.desktop";
  "$secondary_browser" = "$launch chromium-browser.desktop";
  "$file_explorer" = "$terminal yazi.desktop";
  "$editor" = "$terminal nvim.desktop";
  "$discord" = "$launch vesktop.desktop";
}
