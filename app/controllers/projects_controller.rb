class ProjectsController < WebController
  def index
    @projects = ListProjects.in(repository)
  end

  def new
    @project = Project.new
  end

  def edit
    @project = projects_mapper.find(params[:id])
  end

  def create
    project = Project.new(params[:project])

    if projects_mapper.create(project)
      redirect_to root_path, notice: "Project added."
    else
      @project = project
      render :new
    end
  end

  def update
    project = projects_mapper.find(params[:id])
    project.attributes = params[:project]

    if projects_mapper.update(project)
      redirect_to root_path, notice: "Project updated."
    else
      @project = project
      render :edit
    end
  end

  def destroy
    projects_mapper.delete_by_id(params[:id])
    redirect_to root_path, notice: "Project removed."
  end

  private

  def projects_mapper
    repository.projects
  end

  def setup_menu
    if [ "new", "create" ].include?(params[:action])
      active_menu_item_name :new_project
    else
      active_menu_item_name :projects
    end
  end
end
