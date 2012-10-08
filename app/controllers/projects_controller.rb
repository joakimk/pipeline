require 'add_project'

class ProjectsController < WebController
  def new
    @project = Project.new
  end

  def create
    UseCase::AddProject.run(repository, params[:project], self)
  end

  def project_added(project)
    redirect_to root_path, notice: "Project added."
  end

  def project_could_not_be_added(project)
    @project = project
    render :new
  end

  def index
    @projects = repository.projects.all
  end

  private

  def setup_menu
    if [ "new", "create" ].include?(params[:action])
      active_menu_item_name :new_project
    else
      active_menu_item_name :projects
    end
  end
end
