def create_peer(key, peer_id)
  params = {
    "key": key,
    "domain": "localhost",
    "turn": true,
    "peer_id": peer_id,
  }
  res = request(:post, "/peers", JSON.generate(params))
  if res.is_a?(Net::HTTPCreated)
    json = JSON.parse(res.body)
    json["params"]["token"]
  else
    p res
    exit(1)
  end
end

def wait_call(peer_token, peer_id)
  media_connection_id = nil
  wait_thread_for("/peers/#{peer_id}/events?token=#{peer_token}", event: "OPEN", ended: lambda{ |e|
    puts "open-----"
    puts e
  })
  wait_thread_for("/peers/#{peer_id}/events?token=#{peer_token}", event: "CONNECTION", ended: lambda{ |e|
    puts "connection-----"
    puts e
  })
  thread_event = wait_thread_for("/peers/#{peer_id}/events?token=#{peer_token}", event: "CALL", ended: lambda{ |e|
    puts "call-----"
    puts e
    media_connection_id = e["call_params"]["media_connection_id"]
  })

  thread_event.join
  media_connection_id
end

def answer(media_connection_id, video_redirect, audio_redirect)
  params = {
    "constraints": {
      "video": false,
      "audio": false,
      "videoReceiveEnabled": true,
      "audioReceiveEnabled": true
    },
    "redirect_params": {
      "video": {
        "ip_v4": video_redirect[0],
        "port": video_redirect[1],
      },
      "audio": {
        "ip_v4": audio_redirect[0],
        "port": audio_redirect[1],
      }
    },
  }
  res = request(:post, "/media/connections/#{media_connection_id}/answer", JSON.generate(params))
  json = parse_response(res)
end

def wait_ready(media_connection_id)
  thread_event = wait_thread_for("/media/connections/#{media_connection_id}/events", event: "READY", ended: lambda { |e|
    puts "ready----"
    puts e
  })

  thread_event.join
end

def wait_thread_for(uri, event: "OPEN", ended: nil)
  e = nil
  thread_event = Thread.new do
    while e == nil or e["event"] != event
      r = request(:get, uri)
      e = parse_response(r)
    end
    if ended
      ended.call(e)
    end
  end.run
  thread_event
end

def request(method_name, uri, *args)
  response = nil
  Net::HTTP.start("localhost", "8000") { |http|
    response = http.send(method_name, uri, *args)
  }
  response
end

def parse_response(json)
  if json.is_a?(Net::HTTPCreated)
    JSON.parse(json.body)
  elsif json.is_a?(Net::HTTPOK)
    JSON.parse(json.body)
  elsif json.is_a?(Net::HTTPAccepted)
    JSON.parse(json.body)
  elsif json.is_a?(String)
    JSON.parse(json)
  else
    json
  end
end

