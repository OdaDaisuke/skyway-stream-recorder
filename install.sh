# skyway-webrtc-gatewayインストール
git clone https://github.com/skyway/skyway-webrtc-gateway/releases/download/0.2.1/gateway_linux_x64
chmod +x gateway_linux_x64

# ffmpegインストール
sudo su -
cd /usr/local/bin
mkdir ffmpeg
cd ffmpeg
wget https://www.johnvansickle.com/ffmpeg/old-releases/ffmpeg-4.2.1-amd64-static.tar.xz
tar xvf ffmpeg-4.2.1-amd64-static.tar.xz
mv ffmpeg-4.2.1-amd64-static/ffmpeg .
ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg

