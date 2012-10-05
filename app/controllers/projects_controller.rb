require 'add_project'

class ProjectsController < ActionController::Base
  before_filter :temporary_security

  def new
    @project = Entity::Project.new
  end

  def create
    UseCase::AddProject.run(repository, params[:entity_project], self)
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

  def repository
    if ENV['DB']
      Repository::PG.instance
    else
      Repository::Memory.instance
    end
  end

  def temporary_security
    return unless Rails.env.production?
    raise 'Need pw configured in prod.' unless ENV['TEMP_PW']
    if !session[:logged_in] && params[:pw] != ENV['TEMP_PW']
      render text: ''
    else
      session[:logged_in] = true
    end
  end
end
