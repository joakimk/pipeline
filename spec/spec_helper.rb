ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.infer_base_class_for_anonymous_controllers = false
  config.use_transactional_fixtures = false
  config.order = "random"

  DatabaseAccessFilter.setup(config)

  config.before do
    App.reset_repository
  end

  config.after do
    App.repository.delete_all!
  end
end
