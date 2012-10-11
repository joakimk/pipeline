module Repositories
  Memory = Minimapper::Repository.build({
    projects: Memory::ProjectMapper.new,
    builds:   Memory::BuildMapper.new
  })

  AR = Minimapper::Repository.build({
    projects: AR::ProjectMapper.new,
    builds:   AR::BuildMapper.new
  })
end
