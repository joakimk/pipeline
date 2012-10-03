require 'rspec/roles'

RSpec::Roles.define do
  role :base_repository, { add: [ :entity ], last: [], all: [] }
end
