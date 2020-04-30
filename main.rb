require "json"
require "net/http"
require "socket"
require './util.rb'

skyway_api_key = ""
peer_id = "TestRecorder"

# リダイレクト先(IPv4)
RECV_ADDR = "127.0.0.1"
# リダイレクト先ポート
VIDEO_RTP_RECV_PORT = 5000
AUDIO_RTP_RECV_PORT = 5002

peer_token = create_peer(skyway_api_key, peer_id)
puts "created"

media_connection_id = wait_call(peer_token, peer_id)
puts media_connection_id

video_redirect = [RECV_ADDR, VIDEO_RTP_RECV_PORT]
audio_redirect = [RECV_ADDR, AUDIO_RTP_RECV_PORT]
answer_res = answer(media_connection_id, video_redirect, audio_redirect)
puts answer_res
wait_ready(media_connection_id)

puts "connected"

thread_event = wait_thread_for("/media/connections/#{media_connection_id}/events", event: "STREAM", ended: lambda { |e|
  puts "received stream"
  puts e
})

sleep(120)

