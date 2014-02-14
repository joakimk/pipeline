class ProjectsController < WebController
  def index
    @projects = Project.all_sorted_by_name
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    project = Project.new(params[:project])

    if project.save
      redirect_to root_path, notice: "Project added."
    else
      @project = project
      render :new
    end
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
    if [ "new", "create" ].include?(params[:action])
      active_menu_item_name :new_project
    else
      active_menu_item_name :projects
    end
  end
end
