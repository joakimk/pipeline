module Repositories
  Memory = Minimapper::Repository.build({
    projects: Memory::ProjectMapper.new,
    builds:   Memory::BuildMapper.new
  })

  AR = Minimapper::Repository.build({
    projects: Repository::AR::ProjectMapper.new,
    builds:   Repository::AR::BuildMapper.new
  })
end
