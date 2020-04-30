install:
  @sh install.sh
send-test-rtp:
  @ffmpeg -re -i BigBuckBunny.mp4 -r 30 -c:v libvpx -vn -f rtp rtp://127.0.0.1:5000 -sdp_file test_output.sdp
listen-audio:
  @ffmpeg -i rtp://127.0.0.1:5002 -vcodec copy output_aideo.webm
listen-video:
  @ffmpeg -analyzeduration 30M -probesize 30M -loglevel debug -protocol_whitelist file,crypto,udp,rtp -i input.sdp -vcodec copy output_video.webm

