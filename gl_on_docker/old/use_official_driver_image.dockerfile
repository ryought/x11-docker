#
# driverをcontainer内にインストールしている公式イメージから出発して、追加でXとかをインストールする試み
# ただインストール時にXを除外している && Xがないとインストールしてくれないので、その部分を自分で書き直すことに
#
FROM nvidia/driver:410.104-ubuntu16.04

# keyboard-configurationのCUIを抑制(ビルド時に出てきても答えられないので)
ARG DEBIAN_FRONTEND=noninteractive
# これを入れないとgpuが見えず、nvidia-smiが失敗する
ARG NVIDIA_VISIBLE_DEVICES=all

RUN apt-get update && apt-get install -y vim less pkg-config

RUN apt-get update && apt-get install -y xinit

ENTRYPOINT ["bash"]
