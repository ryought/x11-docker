#!/bin/sh
echo "display: $DISPLAY"
nvidia-smi
echo 'launch xserver'
# Xvfb :1 -screen 0 800x600x16 &     # launch headless X server in :1
Xvfb :1 -screen 0 800x600x16 +extension GLX +render -noreset &     # launch headless X server in :1
sleep 5
echo 'launch xeyes'
DISPLAY=:1 xeyes &                 # run a X application on :1
echo 'launch xhost'
DISPLAY=:1 xhost +local:           # allow all connection from localhost
echo 'launch vnc'
x11vnc -display :1 -passwd ryought # create a pipe to X display from VNC connection
