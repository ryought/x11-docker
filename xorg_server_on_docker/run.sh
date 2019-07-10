nvidia-docker build -t x11-docker .
nvidia-docker run --privileged --rm --name x11-docker -p 5901:5900 -it x11-docker
