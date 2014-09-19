uri = URI.parse(ENV["REDISCLOUD_URL"] || "redis://localhost:6379")
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
