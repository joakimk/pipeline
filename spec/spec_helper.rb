ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require 'factory_girl'
FactoryGirl.definition_file_paths = [ "#{Rails.root}/spec/factories" ]
FactoryGirl.find_definitions

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.before do
    App.repository.delete_all!
  end

  config.after do
    FactoryGirl.repository = nil
  end

  running_a_single_file = (ARGV.count == 1)
  using_memory_repository = App.repository.projects.is_a?(Minimapper::Memory)
  if using_memory_repository
    unless running_a_single_file
      config.filter_run_excluding :pg
    end
  end
end
