xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
export _JAVA_AWT_WM_NONREPARENTING=1 
export AWT_TOOLKIT=MToolkit 
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCKwmname LG3D
xrandr --output DP-0 --mode 3440x1440 --right-of HDMI-0 --primary --right-of eDP-1-1
xrandr --output DP-0 --mode 3440x1440 --right-of HDMI-0 --primary
#xrandr --output HDMI-0 --mode 5120x1440
xcompmgr &
#redshift -O3500; 
xset r rate 300 50; 
#exec /home/piotr/.dwm/dwm
#feh --bg-fill  ~/Desktop/arch1.jpeg
exec ~/.config/chadwm/scripts/run.sh
xrandr --output DP-0 --mode 3440x1440 --right-of HDMI-0 --primary
xrandr --output HDMI-0 --mode 5120x1440
xcompmgr &

