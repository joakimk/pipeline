require 'faye/websocket'
require 'redis'
require 'thread'

Faye::WebSocket.load_adapter('thin')

class PushBackend
  CHANNEL        = "push"

  def self.push(data)
    @@publisher.publish(CHANNEL, data.to_json)
  end

  def initialize(app)
    @app = app
    @clients = []

    @@publisher = @publisher = build_redis

    Thread.new do
      subscriber = build_redis
      subscriber.subscribe(CHANNEL) do |on|
        on.message do |channel, msg|
          clients.each { |ws| ws.send(msg) }
        end
      end
    end
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env)
      ws.on :open do |event|
        p [:open, ws.object_id]
        clients << ws
      end

      ws.on :close do |event|
        p [:close, ws.object_id, event.code, event.reason]
        clients.delete(ws)
        ws = nil
      end

      # Return async Rack response
      ws.rack_response
    else
      app.call(env)
    end
  end

  private

  attr_reader :publisher, :clients, :app

  def build_redis
    uri = URI.parse(ENV["REDISCLOUD_URL"] || "localhost:6379")
    Redis.new(host: uri.host, port: uri.port, password: uri.password)
  end
end
