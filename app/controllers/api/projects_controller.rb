class Api::ProjectsController < ApiController
  def destroy
    Project.find_by_name(params[:name]).destroy
    render text: "ok"
  end
end
