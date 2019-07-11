#
# nvidiaドライバ一式を丸ごと動かす案。しかしこれだとnvidia-uvmのエラーが出る。カーネル周り。
# 公式のnvidia/driver dockerfileのように、extractして必要なファイルだけインストールする方式に変えた。
#
FROM ubuntu:16.04
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN apt-get update && apt-get install -y vim wget kmod
# kmod is for driver install modprobe


# RUN apt-get install nvidia-384
RUN wget -nv http://us.download.nvidia.com/XFree86/Linux-x86_64/410.104/NVIDIA-Linux-x86_64-410.104.run \
 && chmod +x NVIDIA-Linux-x86_64-410.104.run \
 && ./NVIDIA-Linux-x86_64-410.104.run --no-questions --accept-license --no-precompiled-interface --ui=none

# RUN apt-get install -y nvidia-384

# RUN apt-get update && apt-get install -y pciutils xinit mesa-utils

#ADD xorg.conf /etc/X11/xorg.conf
#COPY /usr/lib/xorg/modules/drivers/nvidia_drv.so /usr/lib/xorg/modules/drivers/nvidia_drv.so
