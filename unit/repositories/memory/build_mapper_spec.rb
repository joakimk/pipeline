require 'repositories/memory/build_mapper'
require 'build'

describe Repository::Memory::BuildMapper do
  let(:repository) { Repositories::Memory }
  include_examples :build_mapper
end
