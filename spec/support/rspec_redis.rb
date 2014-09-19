class RSpec::Redis
  def self.setup(config)
    @@running = false

    config.before(:each, :redis) do
      RSpec::Redis.ensure_running
    end

    config.before(:each, :redis) do
      $redis.flushdb
    end

    config.after(:all) do
      RSpec::Redis.ensure_stopped
    end
  end

  def self.ensure_running
    unless @@running
      RSpec::Redis::Server.new.start
      @@running = true
      $_redis = $redis
    end

    # we sometimes stub redis, so ensuring its set
    $redis = $_redis
  end

  def self.ensure_stopped
    if @@running
      RSpec::Redis::Server.new.stop
      @@running = false
    end
  end

  class Server
    def start
      FileUtils.mkdir_p("#{Rails.root}/tmp")

      port = 6379 + 1 + ENV["TEST_ENV_NUMBER"].to_i

      redis_options = {
        "daemonize"     => "yes",
        "pidfile"       => pid_file,
        "port"          => port,
      }.map { |k, v| "#{k} #{v}" }.join("\n")

      `echo "#{redis_options}" | redis-server -`
      sleep 1

      $redis = Redis.new(host: "localhost", port: port)
    end

    def stop
      `cat #{pid_file} | xargs kill -9 2> /dev/null`
    end

    private

    def pid_file
      "#{Rails.root}/tmp/redis.#{ENV["TEST_ENV_NUMBER"].to_i}.pid"
    end
  end
end
