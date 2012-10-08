require 'repositories/memory/mapper'
require 'repositories/common/project'

module Repository
  class Memory::Project < Memory::Mapper
    include Repository::Common::Project
  end
end
