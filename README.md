# env-win10
## 概要
----------------------------------------
Windows10上で理想まちづくりを目指します。

以下のような環境を構築する。

- キーバインドを自由にカスタマイズ(ChgKey+AutoHotkey)
- 可能な限りscoopによってインストールするソフトを管理する
- WSLとWindowsの連携
  - WSLのディストリビューションはDebian
  - WSLのGUIアプリをWindowsで表示 (XvSrv)
  - クリップボード (tmux+nvim+xclip+XvSrv)
  - NvimのIME問題 (spzehan.exe)
  - Desktop通知 (toast.exe)
  - VSCodeとWSL
  - Docker (Docker for windows desktop)


## ディレクトリ構成
----------------------------------------
### Windows側

```
C:\home
  - bin   ... wslからも利用するコマンドを配置(PATHを通す)
  - share ... 共有データファイル
  - tools ... windowsでしか使わないツールを配置
  - repos ... gitなどのリポジトリ
  - works ... お仕事用

%USERPROFILE%
```


## Windows側
----------------------------------------
### ChgKey
新しいパソコンを手に入れたら、何はともあれキーバインドを変更する。
キーバインド変更ツール。非常中(レジストリ変更)タイプ。

https://forest.watch.impress.co.jp/library/software/changekey/


### Scoop
PowerShellを管理者権限で起動し、以下のスクリプトをたたく。

```dos
scoop bucket add jfut https://github.com/jfut/scoop-jfut.git
scoop bucket add iyokan-jp https://github.com/tetradice/scoop-iyokan-jp
echo "hey"
```


#### 7zipのコンテキストメニューに追加
1. %userprofile%\scoop\apps\7zip\current\7zFM.exe を起動
2. [ツール] => [オプション]
3. [システム]タブで拡張子関連付け設定
4. [7-zip]タブでコンテキストメニュー追加


### Docker for Desktop

https://docs.docker.jp/docker-for-windows/install.html#install-docker-desktop-on-windows


### spzenhan.exe
IMEの状態制御・取得するコマンド。
https://github.com/kaz399/spzenhan.vim


```sh
curl -sL https://github.com/kaz399/spzenhan.vim/raw/master/zenhan/spzenhan.exe -o /mnt/c/home/bin/spzenhan.exe
```

### toast64.exe
Windowsのポップアップ通知を表示させるコマンド。
tellスクリプトで使用。

https://github.com/go-toast/toast

curl -sL https://go-toast-downloads.s3.amazonaws.com/v1/toast64.exe -o /mnt/c/home/bin/toast64.exe

sound:http://www.noproblo.dayjo.org/ZeldaSounds/QuickSearch.php?q=navi&sa=Search+


### mklink で必要なコマンドのシンボリックリンクを作成
参考：https://hepokon365.hatenablog.com/entry/2020/10/24/211638

```dos
mklink C:\home\bin\firefox  C:\Users\kinou\scoop\apps\firefox\current\firefox.exe
```

### WSL
https://www.kkaneko.jp/tools/wsl/wsl2.html

ubuntuよりdebianの方が余計なものが入ってなくていいので推奨。

### Ramdisk
curl -L https://sourceforge.net/projects/imdisk-toolkit/files/20210125/ImDiskTk-x64.zip


### WSL設定ファイル
%USERPROFILE%\.wslconfig

```
[wsl2]
memory=4G
processors=4
swapFile=R:\\Temp\\swap.vhd
```

### WSLスリープ時の問題解決
WSLはスリープ時に時刻がズレるため、wsl側で以下のコマンドを実行する必要がある。

```sh
sudo hwclock --hctosys
```

毎回たたくのは面倒なので、以下のコマンドでWindowsのスケジューラに登録する。

```dos
schtasks /Create /TN wsl-clock /TR "wsl.exe -u root sh -c hwclock -s" /SC ONEVENT /EC System /MO "*[System[Provider[@Name='Microsoft-Windows-Kernel-Power'] and (EventID=107 or EventID=507)]]" /F
```

参考： https://secon.dev/entry/2021/04/17/100000-wsl-clock-sync/

### VcXsrv
WindowsでWSL側のGUIソフトを使えるようにするため、WindowsにXserverをインストールする。
WindowsとWSLのクリップボードの共有にもXserverを利用している。

参考: https://sourceforge.net/projects/vcxsrv/

installer: https://rin-ka.net/windows-x-server/

起動用ショートカットはWindowsのスタートアップフォルダに置く。


### VSCode
参考：https://zenn.dev/yutakatay/articles/vscode-neovim

https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim


## WSL側
----------------------------------------
### Windows側のパスを除外する
デフォルトだとWindows側のパスの通ったソフトが入力候補に表示される。
鬱陶しい場合は、以下の設定を記載する。

vim /etc/wsl.conf

```sh
[interop]
appendWindowsPath = false
```

### my scripts

```
~/bin
|-- aptup
|-- ggl
|-- ghtoc
|-- imectrl
|-- imests
|-- mktoc
|-- notify-send
|-- pman
|-- promod
|-- setkeymap
|-- tell
|-- tellkill
|-- tenki
|-- tree
```

### Debian

#### 基本ソフト群
```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    curl \
    tmux \
    git \
    fish \
    neovim \
    ripgrep \
    xclip \
    cmigemo
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

#### golang

```sh
sudo apt install -y golang
```

#### Rust

```sh
# install cargo
sudo apt-get update && sudo apt-get install build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustup target add thumbv7em-none-eabihf

# install packages
sudo apt install git minicom libusb-1.0-0-dev libsdl2-dev libssl-dev

# cargo subcommand
cargo install cargo-generate
cargo install hf2-cli
cargo install cargo-hf2
```
```udev
ATTRS{idVendor}=="2886", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2886", MODE="0666"
SUBSYSTEM=="ttyp", ATTRS{idVendor}=="2886", MODE="0666"
```

```sh
sudo udevadm control --reload-rules
sudo adduser $USER dialout
```


### トラブルシューティング
#### VPN接続時になんか通らない

1. PINGは通る？
  - `sudo ping 8.8.8.8`
2. DNSは解決できる？
  - `sudo ping google.com`
  - [https://zenn.dev/mallowlabs/articles/vpn-on-wsl2-ubuntu]
3. MTUの値がVPNとWSLで一致している？
  - [https://ydkk.hateblo.jp/entry/2020/12/06/150914]
  - DOS : `netsh interface ipv4 show subinterfaces`
  - WSL : `ip link show`
  - WSL : `sudo ip link set eth0 mtu XXXX`

