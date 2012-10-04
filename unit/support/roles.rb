require 'rspec/roles'

RSpec::Roles.define do
  role :base_repository, { add: [ :entity ], last: [], all: [], delete_all: [] }
  role :repository_backend, [ :instance ]
  role :project_repository, { :add_by_attributes => [ :attributes, :client ] }
end
