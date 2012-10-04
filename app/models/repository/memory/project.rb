require 'repository/memory/base'
require 'repository/common/project'

module Repository
  class Memory::Project < Memory::Base
    include Repository::Common::Project
  end
end
