require 'repository/memory/project'

describe Repository::Memory::Project do
  implements_role :base_repository
  implements_role :project_repository
end
