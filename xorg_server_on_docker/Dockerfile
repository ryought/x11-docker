FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04

RUN apt-get update && apt-get install -y xorg xvfb x11vnc

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

RUN apt-get update && apt-get install -y mesa-utils

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ADD xorg.conf /xorg.conf
CMD ["/entrypoint.sh"]
