class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[edit update destroy]
  def index
    @projects = Project.where(user_id: current_user.id).order('name ASC')
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).premit(:name, :default_language_id)
  end

  def find_project
    @project = Project.find_by(id: params[:id], user_id: current_user.id)
  end
end
