# todo: remove the "Repository" namespace so that rails can find things in
# app/repositories
require 'ar/project_mapper'

class ProjectsController < WebController
  def index
    @projects = repository.projects.all
  end

  def new
    @project = Project.new
  end

  def create
    AddProject.run(repository, params[:project], self)
  end

  def project_added(project)
    redirect_to root_path, notice: "Project added."
  end

  def project_could_not_be_added(project)
    @project = project
    render :new
  end

  def destroy
    RemoveProject.run(repository, params[:id])
    redirect_to root_path, notice: "Project removed."
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
