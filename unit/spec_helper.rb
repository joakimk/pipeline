RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))
$: << File.join(RAILS_ROOT, "app/models")
$: << File.join(RAILS_ROOT, "app/use_cases")
$: << File.join(RAILS_ROOT, "lib")
$: << File.join(RAILS_ROOT, "unit")

require 'support/load_path_optimizations'
require 'support/roles'
require 'active_support/core_ext'

# Stub AR in unit tests
module ActiveRecord
  class Base
    def self.table_name=(name)
    end

    def self.attr_accessible(*opts)
    end
  end
end

require 'factory_girl'
FactoryGirl.definition_file_paths = [ "#{RAILS_ROOT}/spec/factories" ]
FactoryGirl.find_definitions

RSpec.configure do |config|
end
