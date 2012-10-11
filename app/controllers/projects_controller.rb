class ProjectsController < WebController
  def index
    @projects = ListProjects.run(repository)
  end

  def new
    @project = Project.new
  end

  def edit
    @project = FindProject.by_id(repository, params[:id])
  end

  # Add project
  def create
    AddProject.run(repository, params[:project], self)
  end

  def project_was_added(project)
    redirect_to root_path, notice: "Project added."
  end

  def project_was_not_added(project)
    @project = project
    render :new
  end

  # Update project
  def update
    UpdateProject.run(repository, params[:id], params[:project], self)
  end

  def project_was_updated(project)
    redirect_to root_path, notice: "Project updated."
  end

  def project_was_not_updated(project)
    @project = project
    render :edit
  end

  # Remove project
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
