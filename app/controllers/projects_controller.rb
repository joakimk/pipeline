class ProjectsController < WebController
  before_action :get_projects

  def index
    revision_amount = 2
    locals revision_amount: revision_amount
  end

  def show
    project = Project.find(params[:id])
    revision_amount = 15
    locals :show,
      {revision_amount: revision_amount,
      project: project}
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
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

  def get_projects
    @projects = Project.all_sorted
  end
end
