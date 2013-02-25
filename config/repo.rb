Repo = Minimapper::Repository.build({
  projects: AR::ProjectMapper.new,
  builds:   AR::BuildMapper.new
})
