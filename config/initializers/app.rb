class App
  cattr_accessor :repository

  if Rails.env.test? && !ENV['DB']
    puts "\nUsing the memory store.\n\n"
    self.repository = Repository::Memory.instance
  else
    puts "\nUsing the postgres store.\n\n"
    self.repository = Repository::PG.instance
  end
end
