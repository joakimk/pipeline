require 'repository/memory/build'
require 'build'

describe Repository::Memory::Build do
  let(:repository) { Repository::Memory.instance }
  include_examples :build_repository
end
