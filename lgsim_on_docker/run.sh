nvidia-docker build -t lg-headless .
nvidia-docker run -ti --rm \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $PWD/../lgsvlsimulator-linux64-2019.05:/lgsim \
  -p 8181:8181 -p 8080:8080 --name lg-headless \
  -e DISPLAY=$DISPLAY lg-headless /lgsim/simulator -screen-height 480 -screen-width 640 -screen-quality Beautiful -screen-fullscreen 0
  # -v /home/hamakita9/lg-headless/log:/home/glxtest/.config/unity3d/Editor \
  # -v /home/hamakita9/lg-headless/lgsvlsimulator-linux64-master-182:/lgsim2 \
  # -e DISPLAY=$DISPLAY lg-headless /lgsim/simulator -batchmode
  # -e DISPLAY=$DISPLAY lg-headless /lgsim/simulator
  # -e DISPLAY=$DISPLAY lg-headless bash
  # -e DISPLAY=$DISPLAY lg-headless glxgears
