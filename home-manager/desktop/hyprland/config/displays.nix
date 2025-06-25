{work ? false}:
if work
then {
  # Firefly
  left = {
    output = "HDMI-A-1";
    settings = "2560x1440@144, 0x0, 1";
  };
  primary = {
    output = "DP-1";
    settings = "3840x2160@240, 2560x0, 1.5";
  };
  disable = {output = "eDP-1";};
}
else {
  # Zion
  left = {
    output = "DP-2";
    settings = "2560x1440@240, 0x0, 1";
  };
  primary = {
    output = "DP-1";
    settings = "3840x2160@240, 2560x0, 1.5";
  };
}
