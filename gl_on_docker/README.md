解決策いくつか

- PCIで認識もしている、nvidia-smiも来ている
    - ただglx系のライブラリがない。

- xorgやglxのライブラリをhostからコピーしてくる
    実際の運用では走るデバイスは固定だから、これでも構わない気がする。
    結局nvidiaのglxドライバのインストールがうまくいっていないという話なので、https://qiita.com/gm3d2/items/8346c76961d3fdb257b7 が参考になりそう。
    依存関係があるので、全部コピーしないといけないし、まずhostでインストールしないといけないのでボツ？

- dockerの内側で新たにドライバをインストール
    エラーが出る。不要なところを消す？
    nvidia-dockerのdriver containersの仕組みを使う？

    https://gitlab.com/nvidia/driver/blob/master/ubuntu16.04/Dockerfile 基本的にはこのdockerfileと同じことをやりたい。 NVIDIA*.run実行してインストール。
    ただし、Xも使いたいので、nvidia-installer起動前にXorgをインストールしておき、--x-prefixを適切に設定する。
    https://github.com/NVIDIA/nvidia-docker/wiki/Driver-containers-(Beta) 実行手順はこういう感じを参考にしている。

    これ起動するときには https://github.com/NVIDIA/nvidia-docker/wiki/Usage#non-cuda-image に従って NVIDIA_VISIBLE_DEVICES=all をつけなければいけない。

    xinitインストールすると一緒に入るkeyboard-configurationのCUIを無効化するにはDEBIAN_FRONTEND=noninteractiveをつける

- kubernetesのnode-config startup-scriptやcustom imageなどで、XorgサーバーとGPUドライバをインストールできないか？




作業ログ

- ./NVIDIA-*.run すると nvidia-uvm already be loaded
    /dev/nvidia-uvm にある

docker run --runtime=nvidia -it --rm nvidia/cuda bash
root@3c61cd014211:/# ldconfig -p | grep nvidia
        libnvidia-ptxjitcompiler.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so.1
        libnvidia-opencl.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-opencl.so.1
        libnvidia-ml.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
        libnvidia-fatbinaryloader.so.418.67 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-fatbinaryloader.so.418.67
        libnvidia-fatbinaryloader.so.410.104 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-fatbinaryloader.so.410.104
        libnvidia-compiler.so.410.104 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-compiler.so.410.104
        libnvidia-cfg.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-cfg.so.1

docker run --runtime=nvidia -it --rm nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 bash
root@6108d87b7972:/# ldconfig -p | grep nvidia
        libnvidia-tls.so.410.104 (libc6,x86-64, OS ABI: Linux 2.3.99) => /usr/lib/x86_64-linux-gnu/libnvidia-tls.so.410.104
        libnvidia-ml.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
        libnvidia-ifr.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-ifr.so.1
        libnvidia-glsi.so.410.104 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-glsi.so.410.104
        libnvidia-glcore.so.410.104 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-glcore.so.410.104
        libnvidia-fbc.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-fbc.so.1
        libnvidia-eglcore.so.410.104 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-eglcore.so.410.104
        libnvidia-cfg.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libnvidia-cfg.so.1
        libGLX_nvidia.so.0 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libGLX_nvidia.so.0
        libGLESv2_nvidia.so.2 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libGLESv2_nvidia.so.2
        libGLESv1_CM_nvidia.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so.1
        libEGL_nvidia.so.0 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libEGL_nvidia.so.0

docker run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all -it --rm --entrypoint /bin/bash nvidia/driver:410.104-ubuntu16.04
> たくさん出る。これはいけるんでは？

# ドライバのチェックリスト

/usr/lib/xorg/modules/drivers  Xserver用のドライバ、glx extension


# vulkanのサポート
https://github.com/NVIDIA/nvidia-docker/issues/631
公式にはまだ
https://github.com/mit-fast/FlightGoggles/issues/46

apt install -y libvulkan1 mesa-vulkan-drivers vulkan-utils

vulkaninfo  ドライバが読み込まれているか?

vulkan-smoketest fpsのテスト
