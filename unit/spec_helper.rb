RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))
$: << File.join(RAILS_ROOT, "app/models")
$: << File.join(RAILS_ROOT, "app/use_cases")
$: << File.join(RAILS_ROOT, "app/repositories")
$: << File.join(RAILS_ROOT, "lib")
$: << File.join(RAILS_ROOT, "unit")
$: << RAILS_ROOT

Dir[File.join(RAILS_ROOT, "unit/support/*.rb")].each { |f| require f }
Dir[File.join(RAILS_ROOT, "spec/support/shared/*.rb")].each { |f| require f }
Dir[File.join(RAILS_ROOT, "spec/support/shared_examples/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.after do
    App.repository.delete_all!
    App.reset_repository
  end
end
