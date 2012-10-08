$: << "#{Rails.root}/app"
require "#{Rails.root}/app/repositories/ar.rb"
require "#{Rails.root}/app/repositories/memory.rb"

class App
  cattr_accessor :repository

  if Rails.env.test? && !ENV['DB']
    self.repository = Repository::Memory.instance
  else
    self.repository = Repository::AR.instance
  end

  def self.api_token
    if Rails.env.test? || Rails.env.development?
      'test-api-token'
    else
      ENV['API_TOKEN'] || raise("Missing API_TOKEN")
    end
  end

  def self.builds_to_keep
    (ENV['BUILDS_TO_KEEP'] || 1000).to_i
  end
end
