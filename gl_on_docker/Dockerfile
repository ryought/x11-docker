FROM ubuntu:16.04
ARG NVIDIA_VISIBLE_DEVICES=all
ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        apt-utils \
        build-essential \
        ca-certificates \
        curl \
        wget \
        vim \
        kmod \
        libc6:i386 \
        libelf-dev && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        xinit && \
    rm -rf /var/lib/apt/lists/*

# Install the userspace components and copy the kernel module sources.
ENV DRIVER_VERSION=410.104
RUN cd /tmp && \
    curl -fSsl -O https://us.download.nvidia.com/tesla/$DRIVER_VERSION/NVIDIA-Linux-x86_64-$DRIVER_VERSION.run && \
    sh NVIDIA-Linux-x86_64-$DRIVER_VERSION.run -x && \
    cd NVIDIA-Linux-x86_64-$DRIVER_VERSION* && \
    ./nvidia-installer --silent \
                       --no-kernel-module \
                       --install-compat32-libs \
                       --no-nouveau-check \
                       --no-nvidia-modprobe \
                       --no-rpms \
                       --no-backup \
                       --no-check-for-alternate-installs \
                       --no-libglx-indirect \
                       --no-install-libglvnd \
                       --no-glvnd-egl-client \
                       --no-glvnd-glx-client && \
    mkdir -p /usr/src/nvidia-$DRIVER_VERSION && \
    mv LICENSE mkprecompiled kernel /usr/src/nvidia-$DRIVER_VERSION && \
    sed '9,${/^\(kernel\|LICENSE\)/!d}' .manifest > /usr/src/nvidia-$DRIVER_VERSION/.manifest && \
    rm -rf /tmp/*


RUN apt-get update && apt-get install -y --no-install-recommends \
        pkg-config mesa-utils x11-apps && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        x11vnc && \
    rm -rf /var/lib/apt/lists/*

# vulkan
RUN apt-get update && apt-get install -y --no-install-recommends \
        libvulkan1 vulkan-utils && \
    rm -rf /var/lib/apt/lists/*
# libvulkan1 mesa-vulkan-drivers vulkan-utils && \

# generate
# RUN nvidia-xconfig -a --virtual=1280x1024 --allow-empty-initial-configuration --enable-all-gpus --busid PCI:0:4:0
# use existing one
COPY xorg.conf /etc/X11/xorg.conf

RUN apt-get update && apt-get install -y --no-install-recommends \
        python && \
    rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
CMD ["bash", "/run.sh"]
