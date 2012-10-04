require 'repository/pg/project'

describe Repository::PG::Project do
  implements_role :base_repository
  implements_role :project_repository
end
