xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
export _JAVA_AWT_WM_NONREPARENTING=1 
export AWT_TOOLKIT=MToolkit 
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCKwmname LG3D
redshift -O3500; xset r rate 300 50; exec /home/piotr/.dwm/dwm
