require 'repositories/memory/mapper'
require 'repositories/common/project_mapper'

module Repository
  class Memory::ProjectMapper < Memory::Mapper
    include Repository::Common::ProjectMapper
  end
end
