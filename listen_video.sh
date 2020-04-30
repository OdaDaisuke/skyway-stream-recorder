# 映像のみコピー
ffmpeg -analyzeduration 30M -probesize 30M -loglevel debug -protocol_whitelist file,crypto,udp,rtp -i input.sdp -vcodec copy output_video.webm

