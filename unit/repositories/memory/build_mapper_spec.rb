require 'memory/build_mapper'
require 'build'

describe Memory::BuildMapper do
  let(:repository) { Repositories::Memory }
  include_examples :build_mapper
end
