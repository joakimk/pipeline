require "digest/sha1"

class BuildLock
  # NOTE: If you change this, update the README
  TIMEOUT = 60 * 30 # seconds

  def initialize(repository, build_name, redis = $redis)
    @repository = repository
    @build_name = build_name
    @redis = redis
  end

  attr_private :repository, :build_name, :redis

  def take(revision)
    redis.setnx(key_name, revision)
    redis.expire(key_name, TIMEOUT)
    redis.get(key_name)
  end

  def release
    redis.del(key_name)
  end

  private

  def key_name
    "build_lock_for_#{redis_friendly_repository_name}_#{build_name}"
  end

  def redis_friendly_repository_name
    Digest::SHA1.hexdigest(repository)
  end
end
