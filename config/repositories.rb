module Repositories
  Memory = Minimapper::Repository.build({
    projects: Repository::Memory::ProjectMapper.new,
    builds:   Repository::Memory::BuildMapper.new
  })

  AR = Minimapper::Repository.build({
    projects: Repository::AR::ProjectMapper.new,
    builds:   Repository::AR::BuildMapper.new
  })
end
