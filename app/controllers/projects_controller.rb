class ProjectsController < ActionController::Base
  def new
    @project = Entity::Project.new
  end

  def create
    UseCase::AddProject.run(repository, params[:entity_project], self)
  end

  def project_added(project)
    redirect_to root_path, notice: "Project added."
  end

  def index
  end

  private

  def repository
    Repository::Memory.instance
  end
end
