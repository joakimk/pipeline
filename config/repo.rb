Repo = Minimapper::Repository.build({
  projects: ProjectMapper.new,
  builds:   BuildMapper.new
})
