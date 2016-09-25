class RSpec::Redis
  def self.setup(config)
    config.before(:each, :redis) do
      $redis.flushdb
    end
  end
end
