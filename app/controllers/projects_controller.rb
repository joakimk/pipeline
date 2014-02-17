class ProjectsController < WebController
  def index
    @projects = Project.all_sorted
  end

  def edit
    PushBackend.push({ foo: "bar" })
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])

    if project.update_attributes(project_params)
      redirect_to root_path, notice: "Project updated."
    else
      @project = project
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to root_path, notice: "Project removed."
  end

  private

  def project_params
    params.require(:project).permit(:name, :revision, :status, :status_url)
  end

  def setup_menu
    active_menu_item_name :projects
  end
end
