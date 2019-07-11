# Google Cloud Platformでheadlessにglxgearsを動かす


## VMのセットアップ
GCP Compute Engineに、Marketplaceから入手できるDeep Learning VMをdeployした。

### 設定
- n1-highmem-2
- 1 x NVIDIA Tesla T4
- 100GB HDD
- Tensorflow 1.14 frameworkを有効化(これはどれでも良さそう)
- nvidiaドライバ込み

それ以外は標準のまま

us-west1-bに立ち上げた。起動時にwarningが出るが気にしない。

## 操作手順
sshでログイン(ブラウザ上のsshで試した)

### GPUの接続確認
nvidia-smiでT4が検出されるのを確認。

ドライババージョンは410.104が入っていた

### ドライバのインストール(省略可能)
```
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/410.104/NVIDIA-Linux-x86_64-410.104.run
chmod +x NVIDIA-Linux-x86_64-410.104.run 
sudo ./NVIDIA-Linux-x86_64-410.104.run --no-questions --accept-license --no-precompiled-interface --ui=none
```

### Xサーバーのインストール
mesa-utilsはglx-gearsのデモが入っているパッケージ
```
sudo apt-get install xinit mesa-utils  # xserverとglxinfoをインストール
```


### 設定ファイルのmodify
Xserverを起動するために、いくつか変更が必要

- 全ユーザーにXserver起動権限をあげる
    - sudo vi /etc/X11/Xwrapper.config
    - 全員にXサーバー起動権限をあげる allowed_users=anybodyに変更。
    - これをしないと/usr/lib/xorg/Xorg.wrap: Only console users are allowed to run the X serverが出る
- /etc/X11/xorg.conf を変更(大事)
    - nvidia-xconfig --query-gpu-info  # BusIDを確認
    - sudo nvidia-xconfig -a --virtual=1280x1024 --allow-empty-initial-configuration --enable-all-gpus --busid PCI:0:4:0  # 雛形作成。BusIDは上でゲットしたものを入れる
    - ここは色々注意が必要 --use-display-device=None はつけてはいけない(teslaに対応していない)

### 起動
```
Xorg :0 &  # Xserverが:0で起動
DISPLAY=:0 glxinfo | less  # NVIDIAが有効になっているのを確認
DISPLAY=:0 glxgears  # fpsが3万程度まで出ているのでOKそう
```

### 注意
lspci | grep VGA  # ここにはnvidia製の画面ドライバみたいなのは読み込まれてない





## tips

- nvidia driverのバージョン確認方法
    - cat /proc/driver/nvidia/version か nvidia-smi の一番上の行

- edid

- ドライバ的にTeslaではDisplay Noneは書いてはいけない

    Tesla T4だとopenGLに対応していないという記述もあるが、driver410.72のrelease noteを見ると対応している。(Ch2 API Support OpenGL 4.5 Vulkan 1.1に対応)

    Ch1.4にUseDisplayDevice: Noneは対応しなくなったと書いてある。xorg.confからも消す。

    https://docs.nvidia.com/datacenter/tesla/pdf/tesla-release-notes-410-72.pdf

- BusIDが必要

    nvidia-xconfig --query-gpu-info https://virtualgl.org/Documentation/HeadlessNV でPCI BusIDがゲットできる

    sudo nvidia-xconfig -a --allow-empty-initial-configuration --use-display-device=None --virtual=1920x1200 --busid {busid} に入れてconfigをゲット



