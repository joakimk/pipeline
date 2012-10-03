class Repository::Memory < RepositoryBackend
  def projects
    @projects ||= Project.new
  end
end
