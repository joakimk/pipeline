$: << File.expand_path(File.join(File.dirname(__FILE__), "../app/models"))
$: << File.expand_path(File.join(File.dirname(__FILE__), "../lib"))
$: << File.expand_path(File.join(File.dirname(__FILE__), "."))

require 'support/load_path_optimizations'
require 'active_support/core_ext'
require 'active_model'
require 'rspec/rails/extensions'

RSpec.configure do |config|
end
