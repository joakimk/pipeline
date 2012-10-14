require 'rspec/roles'

RSpec::Roles.define do
  role :project_mapper, { :create_by_attributes => [ :attributes, :client ] }
end
