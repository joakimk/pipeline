module Repositories
  Memory = Minimapper::Repository.build({
    projects: Memory::ProjectMapper.new,
    builds:   Memory::BuildMapper.new
  })

  # Only load AR mappers when rails is loaded
  if defined?(Deployer)
    AR = Minimapper::Repository.build({
      projects: AR::ProjectMapper.new,
      builds:   AR::BuildMapper.new
    })
  end
end
