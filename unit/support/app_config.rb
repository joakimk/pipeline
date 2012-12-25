# Sets up App.repository
require 'ostruct'

class Rails
  def self.root
    RAILS_ROOT
  end

  def self.env
    OpenStruct.new(test?: true)
  end
end

Dir.glob("#{RAILS_ROOT}/app/repositories/memory/*_mapper.rb").each do |mapper|
  require mapper.split("/")[-2, 2].join('/')
end

require File.join(RAILS_ROOT, "config/initializers/app")
