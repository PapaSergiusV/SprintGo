class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show update destroy]

  def index
    @projects = Project.where(company_id: params[:company_id])
    render json: { projects: @projects }
  end

  def show
    return_project
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      return_project
    else
      error_406
    end
  end

  def update
    if @project.update(project_params)
      return_project
    else
      error_406
    end
  end

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:name, :about)
          .merge(params.permit(:company_id))
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def return_project
    render json: { project: @project }
  end

  def error_406
    render json: { errors: @project.errors }, status: :not_acceptable
  end
end
