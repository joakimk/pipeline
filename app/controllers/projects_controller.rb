class ProjectsController < WebController
  def index
    @projects = Project.all_sorted
    revision_amount = 2
    locals revision_amount: revision_amount
  end

  def show
    @projects = Project.all_sorted
    @project = Project.find(params[:id])
    revision_amount = 15
    locals :show,
      revision_amount: revision_amount
  end

  def edit
    @projects = Project.all_sorted
    @project = Project.find(params[:id])
  end

  def update
    @projects = Project.all_sorted
    project = Project.find(params[:id])

    if project.update_attributes(project_params)
      PostStatusToWebhook.call(project)
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
    params.require(:project).permit(:name, :repository, :mappings, :position)
  end

  def setup_menu
    active_menu_item_name :projects
  end
end
