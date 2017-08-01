class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[edit update destroy show import add_language]
  def index
    @projects = Project.where(user_id: current_user.id).order('name ASC')
  end

  def new
    @project = Project.new(user_id: current_user.id)
  end

  def show; end

  def import
    content = YAML.load_file(params[:project][:locales].path)
    puts_tree(content, @project)
    # puts(content)
  end

  def add_language
    @project = ProjectLanguage.where(project_id: params[:id], language_id: params[:project_languages][:language_id]).first_or_create
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def puts_tree(content, project, parent_id = nil)
    content.each do |key, value|
      word = Word.new(word: key, project_id: project.id, parent_id: parent_id)
      word.save!
      puts_tree(value, project, word.id) if value.is_a?(Hash)
      save_translation(project.default_language_id, word.id, value) unless value.is_a?(Hash)
    end
  end

  def save_translation(language_id, word_id, text)
    Translation.find_or_create_by(language_id: language_id, word_id: word_id) do |t|
      t.text = text
    end
  end

  def project_params
    params.require(:project).permit(:name, :default_language_id)
  end

  def find_project
    @project = Project.find_by(id: params[:id], user_id: current_user.id)
  end
end
