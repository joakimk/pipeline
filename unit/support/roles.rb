require 'rspec/roles'

RSpec::Roles.define do
  role :base_repository, {
    add: [ :entity ],
    #update: [ :entity ],
    #delete: [ :entity ],
    delete_all: [],
    #first: [],
    last: [],
    count: [],
    all: []
  }
  role :repository_backend, [ :instance ]
  role :project_repository, { :add_by_attributes => [ :attributes, :client ] }
end
