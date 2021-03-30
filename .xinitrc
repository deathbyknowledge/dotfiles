setxkbmap -option ctrl:nocaps
setxkbmap gb -model macbook79

xrandr --output DP-0 --mode 5120x1440 --rate 120
dbus-launch leftwm
