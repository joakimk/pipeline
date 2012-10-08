require 'repository/memory/mapper'
require 'repository/common/project'

module Repository
  class Memory::Project < Memory::Mapper
    include Repository::Common::Project
  end
end
