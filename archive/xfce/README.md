
```bash
cat ~/.xrandr/dual-work.sh 
xrandr --output LVDS1 --auto
xrandr --output DP1 --auto
xrandr --output DP1 --left-of LVDS1

$ cat ~/.xrandr/laptop.sh 
xrandr --output DP1 --off
xrandr --output HDMI1 --off
xrandr --output LVDS1 --auto
```
