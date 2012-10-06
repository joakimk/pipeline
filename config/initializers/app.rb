class App
  cattr_accessor :repository

  if Rails.env.test? && !ENV['DB']
    self.repository = Repository::Memory.instance
  else
    self.repository = Repository::PG.instance
  end
end
