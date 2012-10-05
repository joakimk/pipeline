require 'add_project'

class ProjectsController < ApplicationController
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
end
