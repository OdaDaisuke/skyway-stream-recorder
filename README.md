# skyway-stream-recorder

[SkyWay WebRTC Gateway](https://github.com/skyway/skyway-webrtc-gateway) を利用して、ストリームを録画するツールです。

## セットアップ

下記コマンドで、SkyWay WebRTC Gatewayとffmpegをインストールします。

```shell
$ make install
```

## 使い方

SkyWay WebRTC Gatewayを起動。

```shell
$ ./skyway_linux_x64
```

Rubyスクリプト実行

```shell
$ ruby main.rb
```

音声のリッスン。

```shell
$ make listen-audio
```

映像のリッスン。

```shell
$ make listen-video
```

## ライセンス

[License](https://github.com/OdaDaisuke/skyway-stream-recorder/blob/master/LICENSE)
