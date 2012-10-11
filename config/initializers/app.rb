# This will go away when I remove Repository:: and follow rails convention :)
$: << "#{Rails.root}/app"
require "#{Rails.root}/app/repositories/memory/project_mapper.rb"
require "#{Rails.root}/app/repositories/memory/build_mapper.rb"
require "#{Rails.root}/app/repositories/ar/project_mapper.rb"
require "#{Rails.root}/app/repositories/ar/build_mapper.rb"

require 'minimapper/repository'
require File.join(Rails.root, 'config/repositories')

class App
  cattr_accessor :repository

  if Rails.env.test? && !ENV['DB']
    self.repository = Repositories::Memory
  else
    self.repository = Repositories::AR
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
