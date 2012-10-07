require 'rspec/roles'

RSpec::Roles.define do
  role :repository_backend, [ :instance ]
  role :project_repository, { :add_by_attributes => [ :attributes, :client ] }
end
