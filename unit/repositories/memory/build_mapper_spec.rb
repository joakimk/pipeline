require 'repositories/memory/build_mapper'
require 'build'

describe Repository::Memory::BuildMapper do
  let(:repository) { Repository::Memory.instance }
  include_examples :build_mapper
end
