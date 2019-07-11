# x11-docker

X11(Xorg) server と GPU GLX/OpenGLを使うX application をnvidia-docker2内で動かす。

hostは全くいじれず、nvidia-dockerのみが使える状態を仮定している。


## packages

- gl_on_gcp/
    先ずはheadlessのGCP GPU instanceでglxgearsを動かす。これは動いた。手順はREADME.mdにまとめた。
- gl_on_docker/
    メインタスクのdocker内で動かすバージョン。GCPのnvidia-docker上で動作を確認済み。

old ones
- lgsim_on_docker/
    lgsimをdocker内に閉じ込める。ただしこれは外側で起動しているGPUありのXorgサーバーがないと立ち上がらない。(シミュレータソフト自体は内側にあるが、描画はコンテナ外側でやっている)
- xorg_server_on_docker/
    GPUなしのXorgサーバーをdocker内で立ち上げる方法。これは容易にできた。
- nvidia_driver_check_on_docker/
    nvidia-docker2がコンテナにどのようにドライバを共有するかを確かめるためのスクリプトたち
- driver_inspect/
    nvidiaのドライバの中身がどうなっているか(特にインストールスクリプト)を調べるためのエリア
