# inside docker script

# 1. launch X server
Xorg :0 &
sleep 5

# 2. start x11 and vnc connection
x11vnc -display :0 -passwd ryought -forever &

# 3. start simulator
#DISPLAY=:0 ./lg/simulator -screen-height 480 -screen-width 640 -screen-quality Beautiful -screen-fullscreen 0
DISPLAY=:0 ./lg2/simulator
