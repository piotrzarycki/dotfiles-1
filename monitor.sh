function list {
  xrandr --listmonitors
}

function laptopoff {
  xrandr --output eDP-1 --off
}

function laptopmirror {
  xrandr --output eDP-1 --mode 1920x1080 --output HDMI-2 --mode 1920x1080 --same-as eDP-1
}

function reset {
  xrandr --auto
}

function wallreload {
  feh --bg-scale ~/Pictures/config/wallpaper/wallpaper.jpg
}
