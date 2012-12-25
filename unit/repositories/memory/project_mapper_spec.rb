require 'memory/project_mapper'

describe Memory::ProjectMapper do
  let(:repository) { Repositories::Memory }
  include_examples :project_mapper
end
