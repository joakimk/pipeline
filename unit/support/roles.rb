require 'rspec/roles'

RSpec::Roles.define do
  role :project_mapper, { :add_by_attributes => [ :attributes, :client ] }
end
