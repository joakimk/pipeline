require 'rspec/roles'

RSpec::Roles.define do
  role :repository_backend, [ :instance ]
  role :project_mapper, { :add_by_attributes => [ :attributes, :client ] }
end
