class ProjectsController < WebController
  def index
    @projects = Project.all_sorted_by_name
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])

    if project.update_attributes(params[:project])
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

  def setup_menu
    active_menu_item_name :projects
  end
end
