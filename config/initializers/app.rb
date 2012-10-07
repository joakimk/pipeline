class App
  cattr_accessor :repository

  if Rails.env.test? && !ENV['DB']
    self.repository = Repository::Memory.instance
  else
    self.repository = Repository::PG.instance
  end

  def self.api_token
    if Rails.env.test? || Rails.env.development?
      'test-api-token'
    else
      ENV['API_TOKEN'] || raise("Missing API_TOKEN")
    end
  end
end
